{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-23.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixpkgs-unstable, ... }@inputs: {
    # Please replace wolfden with your hostname
    nixosConfigurations.wolfden = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./system.nix

        # make home-manager as a module of nixos
        # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          # TODO replace shidil with your own username
          home-manager.users.shidil = import ./home.nix;

          # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
          home-manager.extraSpecialArgs = specialArgs;
        }
      ];

      specialArgs = {
         pkgs-latest = import nixpkgs-unstable {
            inherit system;
            # enable non-free packages
            config.allowUnfreePredicate = (pkg: builtins.elem (pkg.pname or (builtins.parseDrvName pkg.name).name) [
              "obsidian"
              "slack"
              "google-chrome"
            ]);
         };
      };
    };
  };
}
