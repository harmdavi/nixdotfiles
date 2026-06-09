



# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];






  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

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


stylix.enable = true;
#  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
stylix.polarity = "dark";
stylix.image = ./now.png;
stylix.autoEnable = false;


  fonts.packages = with pkgs; [
#  noto-fonts
#  noto-fonts-cjk-sans
#  noto-fonts-color-emoji
  nerd-fonts.jetbrains-mono

  ];

  # $ nix search wget
  environment.systemPackages = with pkgs; [
(import ./appbuild/nvim.nix { inherit pkgs;})

     pkgs.vim-full
     pkgs.tree-sitter
     pkgs.lua-language-server
     pkgs.textidote
     pkgs.texlab
     pkgs.stylua
     pkgs.ripgrep 
     pkgs.python3
     pkgs.gcc
     pkgs.gnumake
     pkgs.luarocks
     pkgs.xdotool
     pkgs.biber
     pkgs.kicad
     pkgs.texliveFull


     pkgs.yazi
     # The following is used to play vidoes
     pkgs.mpv
     pkgs.ghostty
#     pkgs.git
     pkgs.yt-dlp
     pkgs.xclip
     pkgs.freecad
     pkgs.kooha

     pkgs.hyprpaper
     pkgs.hyprlang
     pkgs.hyprlock
     pkgs.hypridle
     pkgs.rofi
     pkgs.grim 
     pkgs.slurp 
     pkgs.waybar
     pkgs.kdePackages.dolphin
     pkgs.hyprlauncher
     pkgs.keepassxc
     pkgs.localsend
     pkgs.inkscape
     pkgs.hyprshot
     pkgs.wl-clipboard
     pkgs.zathura

  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];

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
