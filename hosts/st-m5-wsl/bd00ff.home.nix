{ config, osConfig, lib, pkgs, inputs, ... }: {

  home = {
    username = osConfig.machineSpecific.userName;
    homeDirectory = "/home/${osConfig.machineSpecific.userName}";
  };

  programs.zsh.enable = true;

  programs.git = {
    enable = true;
    # settings = {
    #   user = {  # because userName when .gitconfig is already a toml is stupid
    #     name = "BeliefDiviner";
    #     email = "41856345+BeliefDiviner@users.noreply.github.com";
    #   };
    #   core.editor = "nvim";
    #   init.defaultBranch = "main";
    #   pull.rebase = true;
    #   push.autoSetupRemote = true;
    #   rerere.enable = true;
    # };
    #
    # ignores = [
    #   "*.swp"
    #   "Thumbs.db"
    # ];
  };
  home.file.".config/git" = {
    source = ../../git;
  };

  programs.tmux.enable = true;

  programs.neovim = {
    enable = true;
    withPython3 = false;
    withRuby = false;
    defaultEditor = true;
  };

  home.stateVersion = "25.05";
}
