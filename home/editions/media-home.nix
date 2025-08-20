{ config, pkgs, lib, ... }:

{
  imports = [
    ./dev-home.nix
  ];

  home.packages = with pkgs; [
    rofi
    papirus-icon-theme
  ];

  # Symlink Papirus to ~/.icons for rofi
  home.file.".icons/Papirus".source = "${pkgs.papirus-icon-theme}/share/icons/Papirus";

  programs.rofi = {
    enable = true;
    theme = ''
    * {
      background-color: #282a36;
      foreground-color: #f8f8f2;
    }
  '';
    extraConfig = {
      show-icons = true;
      icon-theme = "Papirus";
    };
  };

  wayland.windowManager.sway.config.menu = lib.mkForce "rofi -show drun";

  # Custom .desktop files
  home.file.".local/share/applications/custom".source = ../configs/media-edition-desktop-apps;

  home.sessionVariables = {
    XDG_DATA_DIRS = "${config.home.homeDirectory}/.local/share/applications/custom:${config.xdg.dataHome}:${pkgs.xdg-utils}/share";
  };
}
