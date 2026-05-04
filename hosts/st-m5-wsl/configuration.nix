{ config, lib, pkgs, inputs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = config.machineSpecific.hostName;

  users.users = {
    ${config.machineSpecific.userName} = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };

  wsl = {
    enable = config.machineSpecific.isWSL;
    defaultUser = config.machineSpecific.userName;
    useWindowsDriver = true;
    ssh-agent = {
      enable = true;
      users = [ config.machineSpecific.userName ];
    };
  };
  environment.extraInit = ''
    export NIX_LD_LIBRARY_PATH="/usr/lib/wsl/lib:$NIX_LD_LIBRARY_PATH"
  '';  # wsl/lib is in path, but not when using nix-ld

  environment.systemPackages = with pkgs; [
    pkgs.zsh
    pkgs.tmux
    pkgs.git
    pkgs.nix-ld
    pkgs.neovim
  ];

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  programs.ssh.startAgent = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
    ];
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  system.stateVersion = "25.05";
}
