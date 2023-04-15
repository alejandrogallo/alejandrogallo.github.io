{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    python3
    hugo

    (emacsWithPackages (epkgs: with epkgs; [
      use-package
      raku-mode
      htmlize
    ]))

  ];
}
