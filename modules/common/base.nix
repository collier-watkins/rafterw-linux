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
    services.openssh.enable = true;

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
        git
        wget
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
}