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
    # Custom wrapper script for Chromium with VAAPI and Wayland flags
    (writeShellScriptBin "chromium-vaapi" ''
      ${chromium}/bin/chromium \
        --enable-features=VaapiVideoDecoder,VaapiVideoEncoder \
        --ignore-gpu-blocklist \
        --enable-gpu-rasterization \
        --enable-accelerated-video-decode \
        --use-gl=egl \
        --ozone-platform=wayland \
        "$@"
    '')
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
