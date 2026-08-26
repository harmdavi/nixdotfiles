# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

# The following will delete any generations that are older than 30 days.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

#The following only allows for 7 generations to be seen from the boot menu
  boot.loader.systemd-boot.configurationLimit = 7;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

#***This is required for flake.nix ***
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Boise";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  #login Manager 
  services.displayManager.sddm = {
  enable = true;
  wayland.enable = true;
  };

  # Enable the Cinnamon Desktop Environment.
#  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;

  # Configure keymap in X11
#  services.xserver.xkb = {
#    layout = "us";
#    variant = "";
#  };


  #Hyprland 
  programs.hyprland = {
enable = true;
xwayland.enable = true;
withUWSM = true;
  };



  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.david = {
    isNormalUser = true;
    description = "David";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:


#stylix.enable = true;
#  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
#stylix.polarity = "dark";
#stylix.image = ./now.png;
#stylix.autoEnable = false;


  fonts.packages = with pkgs; [
#  noto-fonts
#  noto-fonts-cjk-sans
#  noto-fonts-color-emoji
  nerd-fonts.jetbrains-mono

  ];

  # $ nix search wget

  environment.systemPackages = with pkgs; [

#*** BEGIN NVIM INSTALLATION ***
(import ./appbuild/nvim.nix { inherit pkgs;})
(import ./appbuild/treesittercli.nix { inherit pkgs;})

#** LSP **
     pkgs.tree-sitter
     pkgs.lua-language-server
     pkgs.stylua
     pkgs.ltex-ls-plus

#** LATEX **
     pkgs.texliveFull
     pkgs.biber
     pkgs.texlab
     pkgs.textidote
     pkgs.ltex-ls 
     pkgs.texlab
     pkgs.harper
     pkgs.jdk
     pkgs.zotero

     pkgs.ripgrep 
     pkgs.luarocks

#** PDF Viewer ** 
     pkgs.zathura

#*** END NVIM INSTALLATION ***


#*** BEGIN PROGRAMS *** 
     pkgs.python3
     pkgs.w3m
     pkgs.gcc
     pkgs.gnumake
     pkgs.yt-dlp
     pkgs.freecad
     pkgs.keepassxc
     pkgs.localsend
     pkgs.inkscape
     pkgs.libreoffice
     pkgs.mpv
#used for GPG encryption
     pkgs.gnupg
#     pkgs.kicad
#*** END PROGRAMS *** 

#*** BEGIN HYPERLAND TOOLS ***
     pkgs.ghostty
     pkgs.mpv
     pkgs.yazi
     pkgs.git
     pkgs.hyprpaper
     pkgs.hyprlauncher
     pkgs.hyprshot
     pkgs.hyprlang
     pkgs.hyprlock
     pkgs.wl-clipboard
     pkgs.waybar
     pkgs.slurp 
     pkgs.kdePackages.dolphin
     # Note that hypridle is how you can make your screen lock after a certian amount of time
     pkgs.hypridle
     pkgs.brightnessctl

#*** END HYPERLAND TOOLS ***


#*** BEGIN CINNAMON TOOLS ***
     pkgs.xdotool
     pkgs.xclip
#     pkgs.rofi
#*** END CINNAMON TOOLS ***

#*** BEGIN AUX TOOLS ***
#     pkgs.kooha
#     pkgs.grim 
     pkgs.stow
     pkgs.unzip

#Note. The following is here in case I break my neovim and it breaks and need to use vim
     #pkgs.vim-full
#*** END AUX TOOLS ***

  ];

#The following is to set my multi-key to right alt for emojis
services.xserver.xkb.options = "compose:ralt";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

  #***David Added Settings***


  nix.settings.experimental-features = ["nix-command" "flakes"];

}
