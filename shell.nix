{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    python37

    emacs
    # emacsPackages.org-plus-contrib
  ];
}
