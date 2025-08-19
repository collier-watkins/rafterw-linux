{
  description = "Cross-platform NixOS flake with editions, hardware profiles, and per-edition Home Manager configs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];

      mkSystem = { system, modules, edition }: 
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = modules ++ [
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              # Load base home config + edition-specific home config
              home-manager.users.collier = {
                imports = [
                  ./home/common/base-home.nix
                  ./home/editions/${edition}-home.nix
                ];
              };
            }
          ];
        };

      editions = {
        server = ./modules/editions/server.nix;
        dev    = ./modules/editions/dev.nix;
        gnome  = ./modules/editions/gnome.nix;
        media  = ./modules/editions/media.nix;
      };

      hardwareProfiles = {
        laptop = ./modules/hardware/laptop.nix;
        lenovo = ./modules/hardware/lenovo.nix;
      };

      mkConfigs =
        nixpkgs.lib.foldl'
          (acc: hardwareName:
            nixpkgs.lib.foldl'
              (acc2: editionName:
                let
                  name = "${hardwareName}-${editionName}";
                in
                  acc2 // {
                    ${name} = mkSystem {
                      system = "x86_64-linux"; # adjust if some are aarch64
                      modules = [
                        ./modules/common/base.nix
                        hardwareProfiles.${hardwareName}
                        editions.${editionName}
                      ];
                      edition = editionName;
                    };
                  }
              )
              acc
              (builtins.attrNames editions)
          )
          {}
          (builtins.attrNames hardwareProfiles);

    in {
      nixosConfigurations = mkConfigs;
    };
}
