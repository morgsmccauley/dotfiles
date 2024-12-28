{
  description = "Example nix-darwin system flake";

  inputs = {
    # NOTE: Fix for broken lua_ls package https://github.com/NixOS/nixpkgs/pull/368248
    nixpkgs.url = "github:nixos/nixpkgs/1a9767900c410ce390d4eee9c70e59dd81ddecb5";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }: {
    darwinConfigurations."Morgans-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [
        ({ ... }: {
          # NOTE: Override config instead of passing in `self` argument
          system.configurationRevision = self.rev or self.dirtyRev or null;
        })
        ./hosts/macbook-pro
        home-manager.darwinModules.home-manager
      ];
    };
  };
}
