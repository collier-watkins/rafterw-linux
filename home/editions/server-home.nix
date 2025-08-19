{ config, pkgs, ... }:
{
  # Add more server-specific dotfiles here
  xsession.enable = false;

  home.packages = with pkgs; [
    speedtest-cli
    docker
  ];
}
