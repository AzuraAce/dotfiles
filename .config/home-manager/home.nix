{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "oliver";
  home.homeDirectory = "/home/oliver";

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
  #  /etc/profiles/per-user/oliver/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "vim";
    BROWSER = "${pkgs.firefox}/bin/firefox";
    MOZ_USE_XINPUT2 = "1";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyFile = "$HOME/.bash_history";
    historyFileSize = 2000;
    historySize = 2000;
    initExtra = "complete -F _root_command doas\n";
    shellAliases = {
        ff = "fastfetch";
        ll = "ls -lah --color";
        ls = "ls --color";
        za = "zathura";
        format = "astyle -A3 -t8 -p -xg -H -j -xB";
        ter = "$TERMINAL >/dev/null 2>&1 & disown";
        dotfiles = "git --git-dir=\"$HOME/.dotfiles/\" --work-tree=\"$HOME\"";
        rebuild = "doas nixos-rebuild switch";
        rebuild-home = "home-manager switch -b backup";
        config = "doas $EDITOR /etc/nixos/configuration.nix";
        config-home = "$EDITOR $HOME/.config/home-manager/home.nix";
    };
    shellOptions = [
      "histappend"
      "extglob"
      "globstar"
      "checkjobs"
      "checkwinsize"
    ];
  };
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };
  programs.git = {
      enable = true;
      settings = {
        init = {
            defaultBranch = "main";
        };
        user = {
            name = "AzuraAce";
            email = "oliverjjst@proton.me";
        };
      };
  };
  programs.tmux = {
    enable = true;
    mouse = true;
    clock24 = true;
    terminal = "tmux-256color";
    extraConfig = ''set -g status-bg "#242424"
      set -g status-fg "#fffbf6"
      set -g status-right "#[bg=#3B3B3B] %Y-%m-%d #[bg=#525252] %H:%M "
    '';
  };

  home.pointerCursor = {
    enable = true;
    package = pkgs.adwaita-icon-theme;
    size = 48;
    name = "Adwaita";
    x11.enable = true;
    gtk.enable = true;
  };

  xresources = {
    extraConfig = ''#include "/home/oliver/themes/Xresources/iterm"
      #define GENTOO_PURPLE #54487A
      #define GENTOO_PURPLE_LIGHT #61538D
    '';
    properties = {
      "Xft.dpi" = 192;
      "*.selbordercolor" = "GENTOO_PURPLE";
      "*.selbgcolor" = "GENTOO_PURPLE";
      "dwm.font" = "Iosevka:size=14";
      "dwm.fontalt0" = "Symbols Nerd Font Mono:size=14";
      "dwm.borderpx" = 8;
      "dwm.dmenufont" = "Iosevka:size=14";
      "st.font" = "Iosevka:size=14";
      "st.fontalt0" = "Symbols Nerd Font Mono:size=14";
      "dmenu.font" = "Iosevka:size=14";
      "slock.bgimage" = "/home/oliver/wallpapers/nyacat.png";
    };
  };
}
