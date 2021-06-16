{
  description = "simple Discord snowflake parser in Nim";

  inputs = {
    nixpkgs = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
    let pkgs = nixpkgs.legacyPackages.${system}; in {
      devShell = import ./shell.nix { inherit pkgs; };
    }
  );
}
