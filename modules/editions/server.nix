{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    docker
    
  ];

  virtualisation.docker.enable = true;
  users.users.dadmin.extraGroups = [ "docker" ];

  networking.firewall.allowedTCPPorts = [ 80 81 443 ];

}
