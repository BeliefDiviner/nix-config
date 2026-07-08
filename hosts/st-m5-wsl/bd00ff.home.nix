{
  config,
  osConfig,
  lib,
  pkgs,
  inputs,
  ...
}:
{

  home = {
    username = osConfig.machineSpecific.userName;
    homeDirectory = "/home/${osConfig.machineSpecific.userName}";
  };

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    font-awesome
    gnupg
  ];

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    colors = {
      bg = "-1";
      "bg+" = "#3c3836";
      fg = "#ebdbb2";
      "fg+" = "#ebdbb2";
      hl = "#fabd2f";
      "hl+" = "#fabd2f";
      info = "#83a598";
      prompt = "#bdae93";
      spinner = "#fabd2f";
      pointer = "#83a598";
      marker = "#fe8019";
      header = "#665c54";
    };
  };

  home.file.".zsh/config" = {
    source = ../../dotfiles/zsh;
    recursive = true;
  };
  programs.zsh = {
    enable = true;

    # Replace defaults with plugins.
    enableCompletion = false;
    autosuggestion.enable = false;
    syntaxHighlighting.enable = false;

    # A duplicate of a setting set in initContent.
    # Remove when zsh package can be configured to
    # made to generate no config for history.
    history = {
      size = 10000;
      path = "$HOME/.zsh_history";
    };

    # Add extra config through initContent for order controllability.
    initContent = lib.mkOrder 1000 ''
      source $HOME/.zsh/config/p10k.zsh
      source $HOME/.zsh/config/colours.zsh
      source $HOME/.zsh/config/aliases.zsh
      source $HOME/.zsh/config/navigation.zsh
      source $HOME/.zsh/config/history.zsh
      source $HOME/.zsh/config/completion.zsh
      ${lib.optionalString osConfig.machineSpecific.isWSL ''
        source $HOME/.zsh/config/wsl.zsh
      ''}
    '';

    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.fetchFromGitHub {
          owner = "aloxaf";
          repo = "fzf-tab";
          rev = "v1.3.0";
          sha256 = "sha256-8atbysoOyCBW2OYKmdc91x9V/Mk3eyg3hvzvhJpQ32w=";
        };
      }
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.1";
          sha256 = "sha256-vpTyYq9ZgfgdDsWzjxVAE7FZH4MALMNZIFyEOBLm5Qo=";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.8.0";
          sha256 = "sha256-iJdWopZwHpSyYl5/FQXEW7gl/SrKaYDEtTH9cGP7iPo=";
        };
      }
    ];
  };

  home.file.".ssh" = {
    source = ../../ssh;
    recursive = true;
  };

  home.file.".config/git" = {
    source = ../../dotfiles/git;
    recursive = true;
  };
  programs.git.enable = true;

  home.file.".config/jj" = {
    source = ../../dotfiles/jj;
    recursive = true;
  };
  programs.jujutsu.enable = true;

  home.file.".config/tmux" = {
    source = ../../dotfiles/tmux;
    recursive = true;
  };
  home.file.".config/tmux/plugins/tpm/" = {
    source = pkgs.fetchFromGitHub {
      owner = "tmux-plugins";
      repo = "tpm";
      rev = "v3.1.0";
      sha256 = "sha256-CeI9Wq6tHqV68woE11lIY4cLoNY8XWyXyMHTDmFKJKI=";
    };
    recursive = true;
  };
  programs.tmux.enable = true;

  # NeoVim requirements.
  home.file.".config/vale" = {
    source = ../../dotfiles/vale;
    recursive = true;
  };
  programs.ripgrep.enable = true;
  programs.fd.enable = true;

  home.file.".config/nvim" = {
    source = ../../dotfiles/nvim;
    recursive = true;
  };
  programs.neovim = {
    enable = true;
    withPython3 = true;
    withNodeJs = true;
    withRuby = false;
    defaultEditor = true;
    extraPackages = with pkgs; [
      python3
      nodejs
      unzip

      # TreeSitter parsers.
      gcc
      tree-sitter

      # LSP wrapper for formatters.
      efm-langserver

      # LaTeX.
      texlab
      tectonic
      tex-fmt

      # Lua.
      lua-language-server
      stylua

      # Markdown.
      taplo
      vale
      vale-ls
      markdown-oxide
      prettierd

      # Nix Language.
      nil
      nixfmt

      # Typst.
      tinymist
      typstyle
      websocat # Required by typst-preview.
    ];
    # For plugins that download pre-compiled binaries.
    plugins = with pkgs.vimPlugins; [
      blink-cmp
    ];
  };

  home.stateVersion = "25.05";
}
