{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    #Media specific apps
    ungoogled-chromium
    vlc
    fuzzel
    firefox
    android-tools
  ];

  users.users.media = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    password = "watchbluey";
  };

  users.extraGroups.android = {
    members = [ "media" ];
  };

  # System-level udev rules
  services.udev.packages = [ pkgs.android-udev-rules ];

  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.theme = "sddm-sugar-dark";
  services.xserver.displayManager.sddm.settings = {
    General = { Numlock = "on"; };
    X11 = { ServerArguments = "-dpi 192"; };
  };


  # Wayland support
  services.xserver.displayManager.sddm.wayland.enable = true;
  
}
