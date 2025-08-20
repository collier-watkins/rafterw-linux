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
  # Deploy your standalone theme file into ~/.config/rofi/theme.rasi
  home.file.".config/rofi/theme.rasi".source = ../configs/media/desktop-items;

  programs.rofi = {
    enable = true;
    extraConfig = {
      show-icons = true;
      icon-theme = "Papirus";
      # Add filter to exclude Rofi Theme Selector
      drun-match = "!Rofi Theme Selector";
    };
  };

  wayland.windowManager.sway.config.menu = lib.mkForce "rofi -show drun -theme ~/.config/rofi/theme.rasi";

  # Custom .desktop files
  home.file.".local/share/rofi/desktop-items".source = ../configs/media/desktop-items;

  home.sessionVariables = {
    XDG_DATA_DIRS = "${config.home.homeDirectory}/.local/share/rofi/desktop-items";
  };
}