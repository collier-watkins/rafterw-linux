{ config, pkgs, lib, ... }:
let
	fuzzelDesktopPaths = [
		"/run/current-system/sw/share/applications"
		"~/.nix-profile/share/applications"
	];
in
{
	imports = [
		./dev-home.nix
	];

	home.packages = with pkgs; [
		fuzzel
	];


	# Symlink Papirus to ~/.icons for fuzzel
	home.file.".icons/Papirus".source = "${pkgs.papirus-icon-theme}/share/icons/Papirus";

	  # Fuzzel wrapper script to ensure correct GTK env
  home.file.".config/fuzzel/run-fuzzel.sh" = {
    text = ''
      #!/usr/bin/env bash
		export GTK_THEME=Adwaita-dark
		export GTK_ICON_THEME=Papirus
		export XDG_DATA_DIRS="$HOME/.nix-profile/share:/run/current-system/sw/share:$XDG_DATA_DIRS"
		exec fuzzel --show drun
    '';
    executable = true;
  };

	# Fuzzel configuration
	# Fuzzel configuration
programs.fuzzel = {
  enable = true;
  settings = {
    main = {
      font = "monospace:size=12";
      dpi-aware = true;
      terminal = "${pkgs.foot}/bin/foot";
	  layout = "grid";   # Use a grid instead of a list
      columns = 4;       # Number of columns
    };
    colors = {
      background = "#282a36ff";
      text = "#f8f8f2ff";
      selection = "#44475add";
      selection-text = "#f8f8f2ff";
      match = "#8be9fdff";
      selection-match = "#8be9fdff";
      border = "#bd93f9ff";
    };
  };
};


	wayland.windowManager.sway.config.menu = lib.mkForce "$HOME/.config/fuzzel/run-fuzzel.sh";

    # Symlink your repo directory of .desktop files
  #home.file.".local/share/fuzzel-apps".source = ../configs/media-edition-desktop-apps;

  # Prepend it so it overrides system entries
  home.sessionVariables = {
    XDG_DATA_DIRS = "${config.home.homeDirectory}/.local/share/fuzzel-apps:${config.xdg.dataHome}:${pkgs.xdg-utils}/share";
  };
}
