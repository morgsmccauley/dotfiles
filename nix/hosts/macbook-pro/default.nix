{ config, pkgs, ... }: {
  imports = [
    ../../modules/system/defaults.nix
    ../../modules/system/aerospace.nix
    ./homebrew.nix
  ];

  environment.systemPackages = [
    pkgs.neovim
  ];

  nix.settings.experimental-features = "nix-command flakes";

  users.users.morganmccauley = {
    name = "morganmccauley";
    home = "/Users/morganmccauley";
  };

  security.pam.enableSudoTouchIdAuth = true;

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.morganmccauley = import ../../modules/home;
  };

  system.stateVersion = 5;
  nixpkgs.hostPlatform = "aarch64-darwin";
}
