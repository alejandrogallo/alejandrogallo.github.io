{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    python3
    hugo

    emacs
    # emacsPackages.org-plus-contrib
  ];
}
