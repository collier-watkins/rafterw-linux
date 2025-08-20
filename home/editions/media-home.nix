{ config, pkgs, lib, ... }:
{
	imports = [
		./dev-home.nix
	];

	home.packages = with pkgs; [
		rofi
    	papirus-icon-theme
	];


	# Symlink Papirus to ~/.icons for fuzzel
	home.file.".icons/Papirus".source = "${pkgs.papirus-icon-theme}/share/icons/Papirus";

  rofiTheme = pkgs.writeText "rofi-theme" ''
* {
    background-color: #282a36;
    foreground-color: #f8f8f2;
}
'';
 programs.rofi = {
    enable = true;
	theme = rofiTheme;
    extraConfig = {
		show-icons = true;
		icon-theme = "Papirus";
	};
  };


	wayland.windowManager.sway.config.menu = lib.mkForce "rofi -show drun -theme ${rofiTheme}";

    # Symlink your repo directory of .desktop files
  #home.file.".local/share/fuzzel-apps".source = ../configs/media-edition-desktop-apps;

  # Prepend it so it overrides system entries
  home.sessionVariables = {
    XDG_DATA_DIRS = "${config.home.homeDirectory}/.local/share/fuzzel-apps:${config.xdg.dataHome}:${pkgs.xdg-utils}/share";
  };
}
