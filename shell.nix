{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    python37
    hugo

    emacs
    # emacsPackages.org-plus-contrib
  ];
}
