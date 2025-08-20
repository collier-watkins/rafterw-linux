{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vlc #image viewer
    wofi  #App launcher
    wl-clipboard #clipboard for hyprland
    sddm-chili-theme
    sway
    waybar
    swaybg #Wallpaper changer
    swaylock #Desktop locker
    pavucontrol #volume control GUI
    qutebrowser #vim-like browser for fun and training
    kitty
    #screenshot stuff
    grim 
    slurp 
    swappy
    wev #key capture tool
    feh
    qiv
    imagemagick
    vscode
    firefox
    signal-desktop 
  ];

  # Sway config
  programs.sway = {
    enable = true;
    extraSessionCommands = ''
      export WLR_LOG=1
      export WLR_DEBUG=1
      export XDG_CURRENT_DESKTOP=sway
    '';
  };

  programs.thunar.enable = true;

  # Put in laptop and media?
  hardware.graphics = {
    enable = true;
  };
  
  
}
