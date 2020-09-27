{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    python37

    emacs26
    emacs26Packages.org-plus-contrib
  ];
}
