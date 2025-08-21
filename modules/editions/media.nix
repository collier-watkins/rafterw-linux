{ config, pkgs, lib, ... }:

{
  imports = [
    ./dev.nix
  ];

  networking.hostName = lib.mkForce "rafter-w-media";

  environment.systemPackages = with pkgs; [
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

  services.getty.autologinUser = "collier";
}
