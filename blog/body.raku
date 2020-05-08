#!/usr/bin/env raku
unit sub MAIN();

use YAMLish;

sub post-item (Str $index-path) { qq!
    <li class="list-group-item">
      <a href="$index-path">
      {
        load-yaml(.IO.slurp)<head>.grep({<title> ∈ .keys})[0]<title>
        given
        $index-path.IO.dirname.IO ~ "/info.yaml"
      }
      </a>
    </li>
  !
}

say qq!

<h1>
  Table of contents
</h1>

<ul class="list-group">
{ [~] map &post-item, qqx{ make print-the-posts }.words.grep({.IO ~~ :e}) }
</ul>

!
