{ config, pkgs, ... }:

{
  home.username = "shidil";
  home.homeDirectory = "/home/shidil";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # essentials
    firefox
    tree
    jq
    gcc13
    gnumake
    cmake

    # window manager customization
    fuzzel
    libnotify
    swaynotificationcenter
    waybar
    slurp
    grim

    # shell
    alacritty # gpu accelerated terminal
    fish # shell for the cultured
    zoxide # convenient cd alternative
    fd # fast find alternative
    eza # convenient ls alternative
    ripgrep # ultra fast grep
    sd # convenient sd alternative
    starship # stylish prompt
    fzf # fuzzy finder

    # sound
    pavucontrol

    # gaming
    gamemode
    mangohud

    # archives
    zip
    unzip

    # system tools
    pciutils # lspci
    usbutils # lsusb
    htop  # replacement of top
    iftop # network monitoring

    # networking tools
    dnsutils  # `dig` + `nslookup`

    # productivity
    glow # markdown previewer in terminal

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Shidil Eringa";
    userEmail = "4880359+shidil@users.noreply.github.com";
    signing = {
      signByDefault = true;        
      key = null;
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
