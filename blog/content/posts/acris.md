+++
title = "Building a split keyboard with recycled switches"
author = ["Alejandro Gallo"]
date = 2020-11-29T00:00:00+01:00
tags = ["keyboards", "electronics", "haskell"]
draft = false
+++

So, the other day doing dumpster diving I found an interesting piece
of history, here are some crappy shots I took

{{< figure src="/blog/images/acris/38.jpg" width="500px" >}}

{{< figure src="/blog/images/acris/39.jpg" width="500px" >}}

{{< figure src="/blog/images/acris/40.jpg" width="500px" >}}

{{< figure src="/blog/images/acris/41.jpg" width="500px" >}}

{{< figure src="/blog/images/acris/42.jpg" width="500px" >}}

At first while in the dumpster I thought they switches
where some kind of KPT switches I saw once online, to my surprise
after desoldering the switches I found out they were actually
`Tec` switches and the only information I could find online was
in [deskthority](https://deskthority.net/wiki/TEC_switch).

Here is a show of the bare board without the keycps

{{< figure src="/blog/images/acris/9.jpg" width="500px" >}}

{{< figure src="/blog/images/acris/6.jpg" width="500px" >}}

and to my delight the keycaps turned out to be double-shot, in very
nice shape after a thorough clean-up

{{< figure src="/blog/images/acris/44.jpg" width="500px" >}}

{{< figure src="/blog/images/acris/58.jpg" width="500px" >}}

The switches are clicky and quite frankly not so good.
I have to say while in the board they sounded better, but in the
actual project they lost the hollow sound, but still.
You can hear [here](/blog/images/acris/5.mp4) how it sounded.

Anyways I wanted to build something with them, so I set out
to build a quick [atreus](https://atreus.technomancy.us/)-like keyboard but in split-mode.

In the future I want to tweak the layouts so I wanted
to have a simple a nice format for the coordinates
of every key and no existing solutions quite fit my needs.
I've been a fan of [asymptote](https://asymptote.sourceforge.io) for many years
but the language and the libraries haven't quite convinced me,
so I wrote a haskell script to do this using the excellent
[diagrams](https://archives.haskell.org/projects.haskell.org/diagrams/doc/manual.html) library.

The result is in [this repository](https://github.com/alejandrogallo/split-atreus). To do quickly a keyboard without
many tools I just bought some thin wood sheets and created
the first test for the layout:

{{< figure src="/blog/images/acris/Nammu-Tec-left.svg" >}}

In principle the idea is to drill holes where the **three**
switch's legs are and glue the bottom of the switch to the
wood (yes, I know is not the best way to go but well, at least
I'm recycling).

Here I am punching holes into the wood to have a guide
for the **hand drill**

{{< figure src="/blog/images/acris/100.jpg" width="500px" >}}

and after much work, this is what I got

{{< figure src="/blog/images/acris/62.jpg" width="500px" >}}

{{< figure src="/blog/images/acris/61.jpg" width="500px" >}}

which in total ends up looking like this

{{< figure src="/blog/images/acris/53.jpg" width="500px" >}}

{{< figure src="/blog/images/acris/4.jpg" width="500px" >}}

{{< figure src="/blog/images/acris/11.jpg" width="500px" >}}

Although we are almost there, it is not over.
It is not so nice to leave the sides open to dust
and other inconvenients, so I would like to cover them.
I bought some 3mm wood sticks to cover the sides
by gluing them together and some plexiglass to
have the front panel be able to shine light through.

Here you see the raw material and I cut
myself a bit cutting this plexiglass,
so be careful!

{{< figure src="/blog/images/acris/photo5339261905551863206.jpg" width="500px" >}}

Next time I will document better the process of
gluing everything together and so on, but since it was
so messy I kind of forget.
After sanding the edges it is a fair enough result.

{{< figure src="/blog/images/acris/photo5339261905551863203.jpg" width="500px" >}}

{{< figure src="/blog/images/acris/photo5339261905551863204.jpg" width="500px" >}}

{{< figure src="/blog/images/acris/photo5339261905551863207.jpg" width="500px" >}}

{{< figure src="/blog/images/acris/photo5339261905551863208.jpg" width="500px" >}}

{{< figure src="/blog/images/acris/photo5339261905551863211.jpg" width="500px" >}}

And that's all, if I find time and people are interested
I will at some point write a tutorial of how
to write from scratch a
[quantum mechanical keyboard](https://docs.qmk.fm/#/) configuration for
a hand-wired split keyboard.

If you have comments you
can take a look at this
reddit
[thread](https://www.reddit.com/r/MechanicalKeyboards/comments/k2za9a/handwired_split_mechanical_keyboard_with_recycles/).
