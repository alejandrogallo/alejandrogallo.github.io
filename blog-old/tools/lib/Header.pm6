#!/usr/bin/env raku
unit module Header;

my &pair-to-keyval = { S/(\S+) \s* "=>" \s* (.*) /$0="$1"/ };

sub mk-element (%elem) of Str is export {
  qq!<%elem<tag> ! 
  ~ ( .join(" ") given ( .&pair-to-keyval
                         for %elem.grep({.key !~~ <tag>})».gist
                       )
    )
  ~ (%elem<tag> eq <link> ?? q{/>} !! qq{></%elem<tag>>})
}

sub header (@head) of Str is export { join "\n", @head.map(&mk-element) }
