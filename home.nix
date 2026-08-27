{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "david";
  home.homeDirectory = "/home/david";



  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/david/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };


#My Personal nvim configuration
home.file.".config/nvim" = {
source = ./dotconfig/nvim;
recursive = true;
};


#XCompose configuration. For Emojis and Symbols
#home.file.".XCompose" = {
#source = ./dotconfig/xcompose/.XCompose;
#recursive = true;
#};



#Ghostty Config
home.file.".config/ghostty" = {
source = ./dotconfig/ghostty;
recursive = true;
};

#Hyprland Configuration
home.file.".config/hypr" = {
source = ./dotconfig/hypr;
recursive = true;
};


#Waybar Configuration
home.file.".config/waybar" = {
source = ./dotconfig/waybar;
recursive = true;
};


#Zathura
home.file.".config/zathura" = {
source = ./dotconfig/zathura;
recursive = false;
};


programs.yazi = {
  enable = true;

  settings = {
    opener = {
      pdf = [
        {
          run = ''zathura "$@"'';
          orphan = true;
        }
      ];

      edit = [
        {
          run = ''nvim "$@"'';
          block = true;
        }
      ];

      firefox = [
        {
          run = ''firefox "$@"'';
          orphan = true;
        }
      ];

      mpv = [
        {
          run = ''mpv "$@"'';
          orphan = true;
        }
      ];
    };

    open = {
      rules = [
        {
          mime = "application/pdf";
          use = "pdf";
        }

        {
          mime = "text/html";
          use = "firefox";
        }

        {
          mime = "text/*";
          use = "edit";
        }

        {
          mime = "video/*";
          use = "mpv";
        }
      ];
    };
  };
};


#Bashrc Config
  programs.bash = {
    enable = true;

    shellAliases = {
      ls = "ls --color=auto";
      grep = "grep --color=auto";
      envim = "NVIM_APPNAME=envim nvim";
    };

    initExtra = ''

    if [ -f "$HOME/dotfiles/secrets.txt" ]; then
      source "$HOME/dotfiles/secrets.txt"
    fi


      export EDITOR=nvim
      export VISUAL=nvim

      export PATH="$PATH:$HOME/.local/bin"
      export HYPRSHOT_DIR="$HOME/Pictures/hyprshot"

      PS1='[\u@\h \W]\$ '

      y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        command yazi "$@" --cwd-file="$tmp"
        IFS= read -r -d "" cwd < "$tmp"
        [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
        rm -f -- "$tmp"
      }
    '';
  };

#Mouse Cursor Setup
home.pointerCursor = {
  gtk.enable = true;
  package = pkgs.bibata-cursors;
  name = "Bibata-Modern-Ice";
  size = 22;
};

gtk ={
theme.name = "Dream-Color-Plasma";
iconTheme.name = "Slot-Spectrum-Light-Icons";
};

programs.git = {
 enable = true;
 settings = {
  user = {
   name = "David";
   email = "harmondrum@gmail.com";
  };

 init.defaultBranch = "main";
 };
};




#This does not like my display for some reason 

#services.hyprpaper.enable = true;
#services.hyprpaper.settings = {
#  splash = false;
#
#  wallpaper = [
#    {
#      Monitor = "eDP-1";
#      path = "$HOME/Pictures/wallpaper/active";
#      fit_mode = "cover";
#      timeout = 900;
#    }
#  ];
#};


#wallpaper {
#    monitor = eDP-1
#    path = $HOME/Pictures/wallpaper/active
#    recursive = true
#    fit_mode = cover
#    timeout = 900 
#}



  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
