+++
title = "Install maxima to use in common lisp"
author = ["Alejandro Gallo"]
date = 2022-09-03T00:00:00+02:00
tags = ["lisp", "maxima"]
draft = false
+++

One of the nice things of common lisp is that it allows you to use
very high quality libraries like [maxima](https://maxima.sourceforge.io/).
It might not be clear for everyone how to install [maxima](https://maxima.sourceforge.io/) in an easy
way to use from common lisp maybe through quicklisp.
This short post shows just a way of doing it.

In principle you can just clone the [maxima](https://maxima.sourceforge.io/) repository
and compile it like an autotools project, provided you pass
to the configure script the lisp implementation that you are going to use.
So for instance if we cloned the [maxima repo](https://git.code.sf.net/p/maxima/code) to `$folder`
we would just do

```sh
test -x configure || ./bootstrap
./configure --with-sbcl=sbcl
make
```

Then at least with [sbcl](https://sbcl.org) everything should work.
We can now link the directory to the default `~/common-lisp`
directory

```sh
ln -frs $folder ~/common-lisp/maxima
```

and then from a common lisp shell it is even `quickloadable`

```sh
CL-USER> (ql:quickload 'maxima)
To load "maxima":
  Load 1 ASDF system:
    maxima
; Loading "maxima"
[package pregexp].................................
[package cl-info].................................
[package command-line]............................
[package getopt]..................................
[package cl-sloop]................................
[package maxima]..................................
[package mt19937].................................
[package bigfloat-impl]...........................
[package bigfloat]................................
[package intl]....................................
..................................................
..................................................
..................................................
[package f2cl-lib]................................
[package slatec]..................................
..................................................
etc..
```

Now you can do nice things like expanding expressions
and so on, for instance you can use the
`#$ expr $` reader macro to build up maxima expressions

```lisp
(in-package :maxima)
(let ((e #$ expand((a + b + c) ^ 2) $))
  e)
```

```text
((MPLUS SIMP) ((MEXPT SIMP) $A 2) ((MTIMES SIMP) 2 $A $B) ((MEXPT SIMP) $B 2)
 ((MTIMES SIMP) 2 $A $C) ((MTIMES SIMP) 2 $B $C) ((MEXPT SIMP) $C 2))
```

and you can use a host of maxima functions written in lisp or write
maxima functions and call them from lisp, for instance,

```lisp
(in-package :maxima)
(let ((e #$ f(a, b, c) := expand((a + b + c) ^ 2) $))
  (mcall '$f 1 1 1))
```

```text
9 (4 bits, #x9, #o11, #b1001)
```

I hope this helps you get started, certainly it would have helped me!


## The script {#the-script}

```sh
#!/usr/bin/env bash

url=https://git.code.sf.net/p/maxima/code
folder="$HOME/software/maxima"

install_maxima () {
    url=$1
    folder=$2
    set -eux
    mkdir -p $folder
    test -f $folder/bootstrap ||
        git clone --depth=1 $url $folder

    cd $folder
    test -x configure || ./bootstrap
    ./configure --with-sbcl=sbcl
    make

    ln -frs $folder ~/common-lisp/maxima
}

install_maxima $url $folder

cat <<EOF

  Now do

    (ql:quickload :maxima)

  and enjoy!

EOF
```


## References {#references}

-   [Maxima – Maxima and Lisp](https://maxima.sourceforge.io/lisp.html)
-   [Maxima – user interface tips](https://maxima.sourceforge.io/ui-tips.html)
