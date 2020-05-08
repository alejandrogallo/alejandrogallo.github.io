#!/usr/bin/env raku
unit sub MAIN(Str $body);
# vim-run: raku % posts/acris/index.html

use YAMLish;
use lib 'tools/lib';
use Header;

my %local-info = load-yaml .IO.slurp given $body.IO.dirname ~ "/info.yaml";
my %global-info = load-yaml "info.yaml".IO.slurp;

my @head = %global-info<head>, %local-info<head>;

say
  qq:to/HTML/;
<!DOCTYPE html>
<html lang="en">
<head>
  { header @head[*;*]; }
</head>
<body>
  { $body.IO.slurp }
</body>
HTML

