{ config, pkgs, ... }:

{
	imports = [
		./dev-home.nix
	];

#	home.username = lib.mkForce "media";
#	home.homeDirectory = lib.mkForce "/home/media";

	# Add or override options heres
	home.packages = with pkgs; [
		vlc
		mpv
		fuzzel
	];

	wayland.windowManager.sway.config.menu = "fuzzel";

	# Any other tweaks specific to media edition
}
