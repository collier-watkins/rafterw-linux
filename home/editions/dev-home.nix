{ config, pkgs, lib, ... }:
let
  backgroundsDir = ./../../backgrounds;
in
{
	# Add more laptop-specific dotfiles here

	home.packages = with pkgs; [
		nerd-fonts.fira-code
		nerd-fonts.jetbrains-mono
		noto-fonts-emoji
		pamixer
		brightnessctl
		material-cursors
		swww #Sway wallpaper swicher
	];

	home.sessionVariables = {
		GTK_THEME = "Adwaita:dark";
		QT_STYLE_OVERRIDE = "Adwaita-Dark";
		QT_QPA_PLATFORMTHEME = "qt5ct";
		XCURSOR_THEME = "Material-Cursors";
		XDG_CURRENT_DESKTOP = "GNOME:GNOME";
		XDG_THEME = "dark";
	#	GDK_SCALE = "1";
	#	GDK_DPI_SCALE = "1.0";
	#	QT_SCALE_FACTOR = "1.0";
	#	QT_AUTO_SCREEN_SCALE_FACTOR = "0";
	#	XCURSOR_SIZE = "24";
	#	WLR_DPI = "96";
	};

	 home.file.".config/sway/backgrounds".source = backgroundsDir;


	xsession.enable = true;

	programs.kitty = {
		enable = true;
		settings = {
			background_opacity = 0.9;
			font_size = 12.0;
		};
	};

	programs.zsh = {
		shellAliases = {
			logout = "swaymsg exit";
		};
		initContent = ''
			if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
				exec sway
			fi
		'';
	};

	wayland.windowManager.sway = {
		enable = true;
		wrapperFeatures.gtk = true;
		config = {
			startup = [
				#{ command = "swaybg -i $(find ../../backgrounds -type f | shuf -n1) -m fill"; }    #Random picture in that directory every time
				{ command = "$HOME/.config/sway/background-switcher.sh"; }
			];
			bars = [
				{ command = "${pkgs.waybar}/bin/waybar"; }
			];
			window = {
				titlebar = false;
				hideEdgeBorders = "smart";
			};
			gaps = {
				inner = 0;
			};
			input = {
				"*" = {
					xkb_layout = "us";
					repeat_delay = "250";
					repeat_rate = "25";
				};
			};
			output = {
				"*" = {
					scale = "1.5";
				};
			};
			modifier = "Mod4";
			terminal = "kitty";
			menu = "wofi --show drun";
			
			keybindings = let
			modifier = config.wayland.windowManager.sway.config.modifier;
			in {
				"${modifier}+Return" = "exec ${config.wayland.windowManager.sway.config.terminal}";
				"${modifier}+space" = "exec ${config.wayland.windowManager.sway.config.menu}";
				"${modifier}+Escape" = "exec swaylock";
				"${modifier}+q" = "kill";
				"${modifier}+v" = "splitv";
				"${modifier}+n" = "splith";

				"XF86AudioRaiseVolume" = "exec pamixer -i 5";
				"XF86AudioLowerVolume" = "exec pamixer -d 5";
				"XF86AudioMute" = "exec pamixer -t";
				"XF86MonBrightnessUp" = "exec brightnessctl set +10%";
				"XF86MonBrightnessDown" = "exec brightnessctl set 10%-";
				"XF86KbdBrightnessUp" = "exec brightnessctl -d leds::kbd_backlight set +1";
				"XF86KbdBrightnessDown" = "exec brightnessctl -d leds::kbd_backlight set 1-";
				"Print" = "exec grim ~/Pictures/Screenshots/screenshot-$(date +%s).png";

				"F9" = "exec pkill waybar || waybar &"; # Toggle Waybar visibility with F9

				"${modifier}+left" = "focus left";
				"${modifier}+down" = "focus down";
				"${modifier}+up" = "focus up";
				"${modifier}+right" = "focus right";
				"${modifier}+h" = "focus left";
				"${modifier}+j" = "focus down";
				"${modifier}+k" = "focus up";
				"${modifier}+l" = "focus right";

				"${modifier}+1" = "workspace number 1";
				"${modifier}+2" = "workspace number 2";
				"${modifier}+3" = "workspace number 3";
				"${modifier}+4" = "workspace number 4";
				"${modifier}+5" = "workspace number 5";
				"${modifier}+6" = "workspace number 6";
				"${modifier}+7" = "workspace number 7";
				"${modifier}+8" = "workspace number 8";
				"${modifier}+9" = "workspace number 9";
				# Add modifier+Tab for next workspace
  				"${modifier}+Tab" = "workspace next";
				# (optional) Shift+Tab to go backwards
				"${modifier}+Shift+Tab" = "workspace prev";

				"${modifier}+Shift+1" = "move container to workspace number 1; workspace number 1";
				"${modifier}+Shift+2" = "move container to workspace number 2; workspace number 2";
				"${modifier}+Shift+3" = "move container to workspace number 3; workspace number 3";
				"${modifier}+Shift+4" = "move container to workspace number 4; workspace number 4";
				"${modifier}+Shift+5" = "move container to workspace number 5; workspace number 5";
				"${modifier}+Shift+6" = "move container to workspace number 6; workspace number 6";
				"${modifier}+Shift+7" = "move container to workspace number 7; workspace number 7";
				"${modifier}+Shift+8" = "move container to workspace number 8; workspace number 8";
				"${modifier}+Shift+9" = "move container to workspace number 9; workspace number 9";

				"${modifier}+Shift+left" = "move left";
				"${modifier}+Shift+down" = "move down";
				"${modifier}+Shift+up" = "move up";
				"${modifier}+Shift+right" = "move right";
				"${modifier}+Shift+h" = "move left";
				"${modifier}+Shift+j" = "move down";
				"${modifier}+Shift+k" = "move up";
				"${modifier}+Shift+l" = "move right";

				"${modifier}+Control+left" = "resize shrink width 40 px";
				"${modifier}+Control+down" = "resize shrink height 40 px";
				"${modifier}+Control+up" = "resize grow height 40 px";
				"${modifier}+Control+right" = "resize grow width 40 px";
				"${modifier}+Control+h" = "resize shrink width 40 px";
				"${modifier}+Control+j" = "resize shrink height 40 px";
				"${modifier}+Control+k" = "resize grow height 40 px";
				"${modifier}+Control+l" = "resize grow width 40 px";

				"${modifier}+f" = "floating toggle";
			};
		};
	};

	programs.waybar = {
		enable = true;
		settings = {
			mainBar = {
				layer = "top";
				position = "top";
				height = 30;
				spacing = 20;
				modules-left = [ "custom/launcher" "sway/workspaces" "sway/window"];
				modules-center = [ "clock" ];
				modules-right = [ "custom/localip" "network" "pulseaudio" "memory" "cpu" "battery" "custom/power" ];
				"custom/launcher" = {
					format = " ";
					tooltip = false;
					on-click = "wofi --show drun";
				};
				"sway/workspaces" = {
					#format = "*";
					};
				"sway/window" = {
					format = "{app_id} {title}";
					#max-length = 50;
					};
				"custom/power" = {
					format = "󰤆 ";
					tooltip = false;
					on-click = "~/.config/rofi/powermenu/type-2/powermenu.sh &";
				};
				clock = {
					#format = " {:%a %d %b  %H:%M}";s
					format = "{:%a %d %b  %H:%M}";
					tooltip-format = "{:%A, %B %d %Y}";
					interval = 60;
				};
				"custom/localip" = {
					format = "{}";
					exec = "ip -4 addr show $(ip route get 1 | awk '{print $5; exit}') | grep -oP '(?<=inet\\s)\\d+(\\.\\d+){3}'";
					interval = 5;
					tooltip = false;
				};
				cpu = {
					format = " {usage}%";
					interval = 5;
				};
				memory = {
					format = " {used:0.1f}G/{total:0.1f}G";
					interval = 5;
				};
				network = {
					format-wifi = "  {essid} ({signalStrength}%)";
					format-ethernet = "󰈀 {ifname}";
					format-disconnected = "󰖪 Disconnected";
					tooltip = true;
					on-click = "kitty -e nmtui";
				};
				pulseaudio = {
					format = "{icon}  {volume}%";
					format-muted = " Muted";
					format-icons = {
						default = [ "" "" "" ];
					};
					on-click = "pavucontrol";
				};
				battery = {
					format = "{icon} {capacity}%";
					format-charging = " {capacity}%";
					format-icons = [ "" "" "" "" "" ];
					interval = 30;
				};
			};
		};
		# Base 100: #2D2926
		# Base 200: #282422
		# Base 300: #231F1D
		# Content base: #19362D
		#
		style = ''
			* {
				font-family: JetBrainsMono Nerd Font, FontAwesome, sans-serif;
				font-size: 16px;
				color: #bbbbbb;
				background: transparent;
			}
			window#waybar {
				background-color: #282422;
				border-bottom: 1px solid #44475a;
				padding: 0 10px;
			}
			#workspaces button {
				padding: 0 6px;
				color: white;
				background-color: transparent;
				border: none;
			}
			#workspaces button.focused {
				background-color: #19362D;
				color: white;
				border-radius: 4px;
			}
			#clock,
			#custom-localip {
				color: #a3be8c;
				padding: 0 10px;
			}
			#cpu,
			#memory,
			#network,
			#pulseaudio,
			#battery,
			#custom-launcher {
				padding: 0 10px;
				margin: 5px 0;
				border-radius: 5px;
			}
			#custom-power {
				font-size: 24px;
			}
			#clock {
				color: #FFFFFF;
			}
			#battery.charging {
				color: #a6e3a1;
			}
			#battery.critical {
				color: #f38ba8;
			}
		'';
	};

	# Background switcher script
	home.file.".config/sway/background-switcher.sh" = {
		text = ''
		#!/usr/bin/env bash
		DIR="$HOME/.config/sway/backgrounds"

		# Start swww-daemon if not already running
		pgrep -x swww-daemon >/dev/null || swww-daemon &
		sleep 1

		# Loop: pick random wallpaper every 5 minutes with fade
		while true; do
			IMG=$(find -L "$DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) | shuf -n1)
			swww img "$IMG" --transition-type fade --transition-duration 3
			sleep 300
		done
		'';
		executable = true;
	};
}
