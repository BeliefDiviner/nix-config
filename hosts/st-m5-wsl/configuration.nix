{ config, lib, pkgs, inputs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = config.machineSpecific.hostName;

  time.timeZone = "Asia/Yerevan";

  programs.zsh.enable = true;
  users.users = {
    ${config.machineSpecific.userName} = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      shell = pkgs.zsh;
    };
  };

  programs.ssh.startAgent = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
    ];
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

  system.stateVersion = "25.05";
}
