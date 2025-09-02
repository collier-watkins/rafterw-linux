{ config, pkgs, lib, ... }:
{
  imports = [
    ./dev-home.nix
  ];

  home.packages = with pkgs; [
    rofi # Unmodified rofi package
    papirus-icon-theme
    desktop-file-utils
    mlocate
    kitty
  ];


  # GTK and icon theme session variables
 # home.sessionVariables = lib.mkForce {
 #   XCURSOR_THEME = "Material-Cursors";
 #   XCURSOR_SIZE = "128";
 # };

  # Symlink Papirus to ~/.icons for rofi
  home.file.".icons/Papirus".source = "${pkgs.papirus-icon-theme}/share/icons/Papirus";
  # Deploy your standalone theme file into ~/.config/rofi/theme.rasi
  home.file.".config/rofi/theme.rasi".source = ../configs/media/rofi/theme.rasi;

  # Override system .desktop files to hide Rofi and Rofi Theme Selector
  home.file.".local/share/applications/rofi.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Rofi
    NoDisplay=true
  '';
  home.file.".local/share/applications/rofi-theme-selector.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Rofi Theme Selector
    NoDisplay=true
  '';

  programs.rofi = {
    enable = true;
    extraConfig = {
      show-icons = true;
      icon-theme = "Papirus";
      display-drun = "Applications:";
    };
  };

  wayland.windowManager.sway.config.menu = lib.mkForce "rofi -show drun -theme ~/.config/rofi/theme.rasi";
  wayland.windowManager.sway.config.output = lib.mkForce {"*" = { scale = "2.0"; };};

  # Custom .desktop files in applications/ subdirectory
  home.file.".local/share/rofi/desktop-items/applications".source = ../configs/media/desktop-items;

  home.sessionVariables = {
    XDG_DATA_DIRS = "${config.home.homeDirectory}/.local/share/rofi/desktop-items:${config.home.homeDirectory}/.local/share/applications";
  };
}
