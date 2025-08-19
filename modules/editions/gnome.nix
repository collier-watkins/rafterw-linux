{ config, pkgs, ... }:

{
  # Install GNOME and some useful GNOME apps
  environment.systemPackages = with pkgs; [
    pkgs.gnome-tweaks
    pkgs.gnome-control-center
    pkgs.gnome-calculator
    pkgs.gnome-system-monitor
    pkgs.gnome-font-viewer
    pkgs.gnome-disk-utility
    pkgs.gnome-characters
    pkgs.gnome-weather
    pkgs.gnome-maps
    pkgs.gnome-logs
    pkgs.gnome-contacts
    pkgs.gnome-clocks
    pkgs.gnome-screenshot
    pkgs.gnome-software
    pkgs.gnome-shell-extensions
    pkgs.gnome-backgrounds
    pkgs.gnome-keyring
    pkgs.gnome-bluetooth
    pkgs.gnome-color-manager
    pkgs.gnome-remote-desktop
    pkgs.gnome-user-share
    pkgs.gnome-menus
    pkgs.gnome-shell
    pkgs.eog
    pkgs.dconf-editor
    pkgs.gnome-calendar
    pkgs.gnome-photos
    pkgs.gnome-music
    pkgs.gnome-boxes
    pkgs.gnome-contacts
    pkgs.gnome-characters
    pkgs.gnome-weather
    pkgs.gnome-maps
    pkgs.gnome-logs
    pkgs.gnome-clocks
    pkgs.gnome-screenshot
    pkgs.gnome-software
    pkgs.gnome-shell-extensions
    pkgs.gnome-backgrounds
    pkgs.gnome-keyring
    pkgs.gnome-bluetooth
    pkgs.gnome-color-manager
    pkgs.gnome-user-share
    pkgs.gnome-menus
    pkgs.eog
    pkgs.nautilus
    pkgs.dconf-editor
    pkgs.gnome-calendar
    pkgs.gnome-photos
    pkgs.gnome-music
    pkgs.gnome-boxes
  ];

  environment.gnome.excludePackages = with pkgs; [
    epiphany
  ];

  # Enable GNOME desktop environment
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Enable hardware acceleration (optional, but recommended)
  hardware.opengl.enable = true;

  # Enable sound
  hardware.pulseaudio.enable = false;

  # Enable networking applet
  programs.nm-applet.enable = true;

  # Enable Bluetooth support
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Enable printing support
  services.printing.enable = true;

  # Enable power management
  services.upower.enable = true;

  # Enable accessibility
  services.gnome.at-spi2-core.enable = true;

  # Enable GNOME keyring
  services.gnome.gnome-keyring.enable = true;

  # Enable tracker (file indexer)
  services.gnome.tracker-miners.enable = true;

  # Set a default background (optional)
  # services.xserver.desktopManager.pkgs.extraGSettingsOverrides = ''
  #   [org.pkgs.desktop.background]
  #   picture-uri='file:///etc/nixos/backgrounds/forest.jpg'
  # '';
  
  # Set a default background programmatically
  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
    [org.gnome.desktop.background]
    picture-uri='file:///etc/nixos/backgrounds/forest.jpg'
    picture-options='zoom'

    [org.gnome.desktop.interface]
    gtk-theme='Adwaita-dark'
    icon-theme='Adwaita'
    cursor-theme='Adwaita'
  '';
}
