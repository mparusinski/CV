{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    tex = (pkgs.texlive.combine {
      inherit (pkgs.texlive) scheme-small
        textpos # For arbitary box positions
        biblatex; # Sophisticated Bibliographies in Latex
      });
    deps = with pkgs; [
      tex
    ];
  in {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = deps;
      shellHook = ''
        echo "Welcome to your CV builder"
      '';
    };
    # packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;
    # packages.x86_64-linux.default = self.packages.x86_64-linux.hello;
  };
}
