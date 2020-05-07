#!/usr/bin/env raku
unit sub MAIN();

my &post-item = { qq!
    <li>
      <a href="$^a">
        $^a
      </a>
    </li>
  !
}

say qq!

<h1>
  Table of contents
</h1>

{ [~] map &post-item, qqx{ make print-the-posts }.words.grep({.IO ~~ :e}) }

!

