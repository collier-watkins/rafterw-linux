{ config, pkgs, lib, ... }:

{
	imports = [
		./dev-home.nix
	];

	home.packages = with pkgs; [
		vlc
		mpv
		fuzzel
	];

	wayland.windowManager.sway.config.menu = lib.mkForce "fuzzel";

    # Symlink your repo directory of .desktop files
  home.file.".local/share/fuzzel-apps".source = ./media-edition-desktop-apps;

  # Prepend it so it overrides system entries
  home.sessionVariables = {
    XDG_DATA_DIRS = "${config.home.homeDirectory}/.local/share/fuzzel-apps:${config.xdg.dataHome}:${pkgs.xdg-utils}/share";
  };
}
