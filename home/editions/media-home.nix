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
		exec fuzzel --config "$HOME/.config/fuzzel/config" --show drun
    '';
    executable = true;
  };

	# Fuzzel configuration
 home.file.".config/fuzzel/config" = {
    text = ''
      [launcher]
      show-icons = true
      icon-size = 64
      desktop-files-path = ${lib.concatStringsSep ":" fuzzelDesktopPaths}
      max-items = 50

      [appearance]
      background-color = #1e1e2e
      foreground-color = #cdd6f4
      layout = grid
      columns = 4
    '';
  };

	wayland.windowManager.sway.config.menu = lib.mkForce "$HOME/.config/fuzzel/run-fuzzel.sh";

    # Symlink your repo directory of .desktop files
  #home.file.".local/share/fuzzel-apps".source = ../configs/media-edition-desktop-apps;

  # Prepend it so it overrides system entries
  home.sessionVariables = {
    XDG_DATA_DIRS = "${config.home.homeDirectory}/.local/share/fuzzel-apps:${config.xdg.dataHome}:${pkgs.xdg-utils}/share";
  };
}
