{
  description = "configured (neo)vim wrapper using nix";

  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      lastModifiedDate = self.lastModifiedDate or self.lastModified or "19700101";
      version = builtins.substring 0 8 lastModifiedDate;

      supportedSystems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      # Helper function to generate attrset '{ x86_64-linux = f "x86_64-linux"; ... }'.
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      # Nixpkgs instantiated for supported system types.
      nixpkgsFor = forAllSystems (
        system:
        import nixpkgs {
          inherit system;
          overlays = [ self.overlay ];
        }
      );
    in
    {
      overlay = final: prev: {
        neovim = with final; callPackage ./neovim.nix { inherit version; };
      };

      packages = forAllSystems (system: {
        inherit (nixpkgsFor.${system}) neovim;
      });

      defaultPackage = forAllSystems (system: self.packages.${system}.neovim);

      nixosModules.neovim =
        { pkgs, ... }:
        {
          nixpkgs.overlays = [ self.overlay ];
          environment.systemPackages = [ pkgs.neovim ];
        };

      # checks = forAllSystems (
      #   system: with nixpkgsFor.${system}; {
      #     inherit (self.packages.${system}) neovim;
      #     test = stdenv.mkDerivation {
      #       name = "neovim-test-${version}";
      #       buildInputs = [ neovim ];
      #       unpackPhase = "true";
      #       buildPhase = ''
      #         echo 'running some integration tests'
      #         [[ $(hello) = 'Hello Nixers!' ]]
      #       '';
      #       installPhase = "mkdir -p $out";
      #     };
      #   }
      # );
    };
}
