{
  description = "My Coding Standard for PHP_CodeSniffer";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];
    in
    {
      devShells = nixpkgs.lib.genAttrs systems (
        system:
        let
          inherit (nixpkgs.legacyPackages.${system}) mkShell;
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = mkShell {
            packages = with pkgs; [
              php
              php.packages.composer
            ];

            shellHook = ''
              echo "PHP $(php --version | head -1)"
              echo "Composer $(composer --version)"
            '';
          };
        }
      );
    };
}
