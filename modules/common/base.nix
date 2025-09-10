{ config, pkgs, ... }:

{
    imports = [];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    nixpkgs.config.allowUnfree = true; #Trying to keep this to nvidia drivers 
    system.stateVersion = "25.05";

    # User initialization
    users.users.dadmin = {
        password = "howdy";
        isNormalUser = true;
        description = "Dadmin";
        extraGroups = [ "networkmanager" "wheel" "dadmin"];
    };

    users.users.collier = {
        password = "howdy";
        isNormalUser = true;
        description = "Collier";
        extraGroups = [ "networkmanager" "wheel" "collier"];
    };

    # Networking
    networking.networkmanager.enable = true;
    networking.hostName = "rafter-w-os";
    services.openssh = {
      enable = true;
      settings = {
          PermitRootLogin = "no";
          PrintMotd = true;
      };
    };

    # Localization
    time.timeZone = "America/Chicago";
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
        LC_ALL = "en_US.UTF-8";
    };

    #System-wide packages
    environment.systemPackages = with pkgs; [
        cowsay
        networkmanager # Neccessary?
        pciutils
        git
        wget
        curl
        unzip
        gnugrep
        coreutils
        zsh
        zsh-powerlevel10k
        tree
        neofetch
        neovim
        gcc #dependency for lazyvim
        ripgrep #dependency for lazyvim
        fd
        htop
        lshw
        speedtest-cli
    ];

    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;

    # Enhanced TTY login message with colors and ASCII art
    environment.etc."issue".text = ''
        \e[1;32m _      _      _   
        (_)   _(_)_   (_)  
        (_)  (_) (_)  (_)  
        (_) (_) _ (_) (_)  
        (_)   _(_)_   (_)  
        (_)  (_) (_)  (_)  
        (_)_(_)   (_)_(_)  
          (_)       (_)    
        \e[0m
    '';
   # Enable Docker if not already enabled
  virtualisation.docker.enable = true;

      # Create the MOTD script
  environment.etc."motd-script.sh" = {
    source = pkgs.writeScript "motd-script" ''
      #!/bin/sh
      # Green ANSI color code
      GREEN="\033[0;32m"
      RESET="\033[0m"

      # ASCII Art in green
      echo -e "$GREEN"
      echo "  ____ ___ _     ___  ____  "
      echo " / ___|_ _| |   / _ \/ ___| "
      echo " \___ \| || |  | | | \___ \ "
      echo "  ___) | || |__| |_| |___) |"
      echo " |____/___|_____\___/|____/ "
      echo -e "$RESET"

      echo "Welcome to NixOS!"

      # Last login information
      echo "Last login:"
      ${pkgs.utillinux}/bin/last -1 $USER | ${pkgs.coreutils}/bin/head -n 1

      # Docker containers
      echo -e "\nRunning Docker Containers:"
      ${pkgs.docker}/bin/docker ps
    '';
    mode = "0755"; # Ensure the script is executable
  };

}
