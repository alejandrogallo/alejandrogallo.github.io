+++
title = "A simple youtube bookmark player with raku, mpv and dmenu"
author = ["Alejandro Gallo"]
date = 2021-02-11T00:00:00+01:00
tags = ["raku", "literate"]
draft = false
+++

## Introduction {#introduction}

This document explains in a pedagogical way how to write
a simple music/video bookmark player with the programming language [raku](https://raku.org).

I often find myself discovering nice music on youtube and wanting to recover
or replay it later.
Of course I could use a bookmark manager but I want an easy fuzzy searching
and storing the links in an [org-mode](https://orgmode.org) file.

Instead of writing quickly the script and adding it to my script collections,
I thought this time I can show how convenient and fun `raku` can be in scripting
these kind of small applications.

Do not worry if you don't understand everything here, it is also meant as
a teaser so that you go and learn some raku yourself! I think that raku at least
for scripting is highly underrated.

So let's get to it!


## Main {#main}

Raku lets you define a `MAIN` function globally where your program starts.
I like to do this in simple scripts and then it's out of the way.

```raku
#| A simple playlist manager
unit sub MAIN();
```

Notice that just with this line your application already has an argument parser
predefined, i.e., if I name the script `,yt`, as I have, then

```sh
,yt -h
```

results in

```text
Usage:
  ,yt -- A simple playlist manager
```

You can do much more with this default parser, but for our simple script we do not need it.

In my case, I will store the links to the songs or playlists in an `org-mode` file,
in your case you might decide otherwise.

I will store the location to my org file in the constant
`$ORG_LINK_FILE`:

```raku
constant $ORG_LINK_FILE = "%*ENV<HOME>/.config/org/yt-playlists.org";
```


## Links {#links}

We would like to parse the `org-mode` links appearing in the playlist file,
an _named_ `org-mode` link looks like this

```text
[[URL][My long and complicated title]]
```

Let us define a `Link` data structure in a class

```raku
class Link {
  has Str $.name;
  has Str $.url;
  has Str $.tags;
}
```

Raku has Regexes and Grammars as first-class citizens in the language, let us define a
simple regex for an `org-mode` link

```raku
my regex org-mode-link {
  "[["
    $<url> = <-[\]]>+
  "]["
    $<name> = <-[\]]>+
  "]]"
}
```

notice how convenient it is to define a named regular expression in raku.
`$<url>` and `$<name>` are a named-captures that will be helpful later on,
for more information consult the [raku documentation](https://docs.raku.org/language/regexes#index-entry-declarator_regex-Subrules).

However, in general I will have my url in a section's header, and in `org-mode`
you can add tags to headers. Therefore I would also like to parse these tags
so that I can match the titles easier, the general form of a title
in `org-mode` is

```text
 * [[url][My long and complicated title]]                            :some:tags:
```

A simple regular expression matching the tags ****for our purposes**** is simply

```raku
my regex org-tags {
  ":" .* ":" $$
}
```

where `$$` denotes the end of a line.


## Picking with dmenu {#picking-with-dmenu}

We will be using [dmenu](http://tools.suckless.org/dmenu/) as a pick tool, so we should write
a function that accepts a list of links and asks for user input
via dmenu returning a list of selected links.

We can define a function in raku using the `sub` keyword,
so in our case the function would look like this

```raku
sub dmenu-link (Link @links) of Array[Link] {
  <<dmenu-title>>
  <<dmenu-link-contents>>
}
```

This says, accept as an argument a list of `Link` and return an `Array`
of `Link`.

We can define an duck-typed helper function that takes
a `Link` as an input and returns the text that `dmenu` will
see and offer to the user, in raku we can simply write

`<<dmenu-title>>=`

```raku
my &dmenu-title = {"{.name} {.tags}"};
```

In order to feed the text to dmenu we can create a temporary
file where we will put all the titles of the entries
and then feed to the dmenu process its contents through
the `stdin` file descriptor:

`<<dmenu-link-contents>>=`

```raku
with "/tmp/,yt.in".IO.open: :rw {
  .say: @links».&dmenu-title.join: "\n";
  .close and .open; # we need to close and open, maybe improve?
  my Str $name = .out.slurp.chomp
                  given shell "dmenu -i", :in($_), :out;
  Array[Link].new: @links.grep: {.&dmenu-title eq $name}
}
```


## Parsing the `org-mode` link file {#parsing-the-org-mode-link-file}

Let us define the function that will parse the org file and return an `Array` of links.
In this function we use the [`gather`](https://docs.raku.org/syntax/gather%20take) syntax provided by raku, which simplifies
in this case the building of the resulting array.

Essentially, we simply go through the lines of `$ORG_LINK_FILE`
and `take` a `Link` only when the line matches

`<<parse-org-regex>>=`

```raku
<org-mode-link> [\s+ <org-tags>]?
```

Notice that in raku we can trigger the evaluation of a code
whenever a regular expression matches by
embedding the code inside the regular expression in a code block.
In this case this looks like this:

`<<parse-links-regex>>=`

```raku
/ <<parse-org-regex>>
  { take
      Link.new: |hash
        <name url tags>
        Z=>
        ( |$<org-mode-link><name url>
        , $<org-tags>
        )».&{.so ?? .Str !! ""}
  }
/
```

If this seems like [line noise](https://www.perl.com/pub/2000/01/10PerlMyths.html/#Perl_looks_like_line_noise) to you, it is normal and I am sorry.
However, I think it is part of the fun writing and learning raku.
Of course one should write differently if it is meant to be understood
by everyone in a team, but for your private short scripts like this one
you may experiment with what the language has to offer.
However, you can go ****way**** wilder than this..
I'll leave it as an exercise to decipher this bit!

With this, our parsing function looks simply like:

```raku
sub parse-links (--> Array[Link]) {
  Array[Link].new:
    gather
      for $ORG_LINK_FILE.IO.lines {
        .match:
        <<parse-links-regex>>
      }
}
```

or expanding all the code to see it in full

```raku
sub parse-links (--> Array[Link]) {
  Array[Link].new:
    gather
      for $ORG_LINK_FILE.IO.lines {
        .match:
        / <org-mode-link> [\s+ <org-tags>]?
          { take
              Link.new: |hash
                <name url tags>
                Z=>
                ( |$<org-mode-link><name url>
                , $<org-tags>
                )».&{.so ?? .Str !! ""}
          }
        /
      }
}
```


## Play the music! {#play-the-music}

We will be playing the videos and playlists with
[mpv](https://mpv.io/) which uses [youtube-dl](https://youtube-dl.org/) to stream the content directly.
A very simple function to play a `Link` will be

```raku
sub play-with-mpv (Link $l) {
  say "Playing {$l.name}";
  shell "mpv '{$l.url}'";
}
```

and therefore the main program is simply given by

```raku
.&play-with-mpv
  for dmenu-link parse-links;
```

Notice that in raku one can call a function in this way too,
akin to [the uniform function call syntax](https://en.wikipedia.org/wiki/Uniform_Function_Call_Syntax), so the following
two calls to `&my-function` are equivalent, i.e., they print
`Hello world`:

```raku
my &my-function = &say o (* ~ " world");
my-function "Hello";
"Hello".&my-function;
```


## Putting it all together {#putting-it-all-together}

```raku
#!/usr/bin/env raku
#| A simple playlist manager
unit sub MAIN();
constant $ORG_LINK_FILE = "%*ENV<HOME>/.config/org/yt-playlists.org";
class Link {
  has Str $.name;
  has Str $.url;
  has Str $.tags;
}
my regex org-mode-link {
  "[["
    $<url> = <-[\]]>+
  "]["
    $<name> = <-[\]]>+
  "]]"
}
my regex org-tags {
  ":" .* ":" $$
}
sub dmenu-link (Link @links) of Array[Link] {
  my &dmenu-title = {"{.name} {.tags}"};
  with "/tmp/,yt.in".IO.open: :rw {
    .say: @links».&dmenu-title.join: "\n";
    .close and .open; # we need to close and open, maybe improve?
    my Str $name = .out.slurp.chomp
                    given shell "dmenu -i", :in($_), :out;
    Array[Link].new: @links.grep: {.&dmenu-title eq $name}
  }
}
sub parse-links (--> Array[Link]) {
  Array[Link].new:
    gather
      for $ORG_LINK_FILE.IO.lines {
        .match:
        / <org-mode-link> [\s+ <org-tags>]?
          { take
              Link.new: |hash
                <name url tags>
                Z=>
                ( |$<org-mode-link><name url>
                , $<org-tags>
                )».&{.so ?? .Str !! ""}
          }
        /
      }
}
sub play-with-mpv (Link $l) {
  say "Playing {$l.name}";
  shell "mpv '{$l.url}'";
}
.&play-with-mpv
  for dmenu-link parse-links;
```
