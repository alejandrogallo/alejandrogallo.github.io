+++
title = "Using p5js with org-mode in emacs"
author = ["Alejandro Gallo"]
date = 2022-10-14T00:00:00+02:00
tags = ["emacs", "elisp", "project"]
draft = false
+++

<iframe class="org-p5js"
                                         frameBorder='0'
                                         width="100%" height="220"
                                         src="data:text/html;base64,CjxodG1sPgo8aGVhZD4KICA8c2NyaXB0IHNyYz0iaHR0cHM6Ly9jZG4uanNkZWxpdnIubmV0L25w
bS9wNUAxLjQuMi9saWIvcDUuanMiPjwvc2NyaXB0PgogIDxzY3JpcHQ+CiAgICBsZXQgeHNwYWNp
bmcgPSAxNjsgLy8gRGlzdGFuY2UgYmV0d2VlbiBlYWNoIGhvcml6b250YWwgbG9jYXRpb24KbGV0
IHc7IC8vIFdpZHRoIG9mIGVudGlyZSB3YXZlCmxldCB0aGV0YSA9IDAuMDsgLy8gU3RhcnQgYW5n
bGUgYXQgMApsZXQgYW1wbGl0dWRlID0gNzUuMDsgLy8gSGVpZ2h0IG9mIHdhdmUKbGV0IHBlcmlv
ZCA9IDUwMC4wOyAvLyBIb3cgbWFueSBwaXhlbHMgYmVmb3JlIHRoZSB3YXZlIHJlcGVhdHMKbGV0
IGR4OyAvLyBWYWx1ZSBmb3IgaW5jcmVtZW50aW5nIHgKbGV0IHl2YWx1ZXM7IC8vIFVzaW5nIGFu
IGFycmF5IHRvIHN0b3JlIGhlaWdodCB2YWx1ZXMgZm9yIHRoZSB3YXZlCmxldCBhbmdsZVJvdGF0
ZSA9IDA7CgpmdW5jdGlvbiBzZXR1cCgpIHsKICAgIGNyZWF0ZUNhbnZhcyg3MTAsIDIwMCk7CiAg
ICB3ID0gd2lkdGggKyAxNjsKICAgIGR4ID0gKFRXT19QSSAvIHBlcmlvZCkgKiB4c3BhY2luZzsK
ICAgIHl2YWx1ZXMgPSBuZXcgQXJyYXkoZmxvb3IodyAvIHhzcGFjaW5nKSk7Cn0KCmZ1bmN0aW9u
IGRyYXcoKSB7CiAgICBiYWNrZ3JvdW5kKDI1NSk7CiAgICBjYWxjV2F2ZSgpOwogICAgcmVuZGVy
V2F2ZSgpOwp9CgpmdW5jdGlvbiBjYWxjV2F2ZSgpIHsKICAgIC8vIEluY3JlbWVudCB0aGV0YSAo
dHJ5IGRpZmZlcmVudCB2YWx1ZXMgZm9yCiAgICAvLyAnYW5ndWxhciB2ZWxvY2l0eScgaGVyZSkK
ICAgIHRoZXRhICs9IDAuMDIgKiBtb3VzZVggLyAxNTA7CgogICAgLy8gRm9yIGV2ZXJ5IHggdmFs
dWUsIGNhbGN1bGF0ZSBhIHkgdmFsdWUgd2l0aCBzaW5lIGZ1bmN0aW9uCiAgICBsZXQgeCA9IHRo
ZXRhOwogICAgZm9yIChsZXQgaSA9IDA7IGkgPCB5dmFsdWVzLmxlbmd0aDsgaSsrKSB7CiAgICAg
ICAgeXZhbHVlc1tpXSA9IHNpbih4KSAqIGFtcGxpdHVkZSAqICgxIC0gbW91c2VZIC8gaGVpZ2h0
KTsKICAgICAgICB4ICs9IGR4OwogICAgfQp9CgpmdW5jdGlvbiByZW5kZXJXYXZlKCkgewogICAg
bm9TdHJva2UoKTsKICAgIGZpbGwoMCk7CiAgICAvLyBBIHNpbXBsZSB3YXkgdG8gZHJhdyB0aGUg
d2F2ZSB3aXRoIGFuIGVsbGlwc2UgYXQgZWFjaCBsb2NhdGlvbgogICAgZm9yIChsZXQgeCA9IDA7
IHggPCB5dmFsdWVzLmxlbmd0aDsgeCsrKQogICAgICAgIGVsbGlwc2UoeCAqIHhzcGFjaW5nLCBo
ZWlnaHQgLyAyICsgeXZhbHVlc1t4XSwgMTYsIDE2KTsKfQogIDwvc2NyaXB0Pgo8L2hlYWQ+Cjxi
b2R5PgogIDxtYWluPjwvbWFpbj4KPC9ib2R5Pgo8L2h0bWw+Cg==">
                                         </iframe>

This week I wanted to do some tests with the
cool project [`p5js`](https://p5js.org/) and I wanted to use it from [`org-mode`](https://orgmode.org).

Regrettably, there is no package I could find that allows
to use [`p5js`](https://p5js.org/) in an [`org-mode`](https://orgmode.org) document.
What's worse however is that apparently you can't have two sketches in a
single `html` file. Of course, to be fair, maybe this is my assessment
of the library. As far as I can tell [`p5js`](https://p5js.org/) can only deal with a
single

```html
<main></main>
```

tag. So I decided to let the good-old `<iframe></iframe>` save the day.
But of course, I would like to simply write code and let `org-mode`
handle the output automatically, i.e., I want to write

```org
#+begin_src p5js
function setup() {
  // ...
}
function draw() {
  // ...
}
#+end_src
```

sit back and enjoy my interactive `html` document.
So you have already seen the eye candy at the beginning of the document,
and you can do everything that [`p5js`](https://p5js.org/) can, which is
trivially use `WEBGL`

<center><iframe class="org-p5js"
                                         frameBorder='0'
                                         width="100%" height="220"
                                         src="data:text/html;base64,CjxodG1sPgo8aGVhZD4KICA8c2NyaXB0IHNyYz0iaHR0cHM6Ly9jZG4uanNkZWxpdnIubmV0L25w
bS9wNUAxLjQuMi9saWIvcDUuanMiPjwvc2NyaXB0PgogIDxzY3JpcHQ+CiAgICBmdW5jdGlvbiBz
ZXR1cCgpIHsKICBjcmVhdGVDYW52YXMoNTAwLCAyMDAsIFdFQkdMKTsKfQpmdW5jdGlvbiBkcmF3
KCkgewogIGJhY2tncm91bmQoMjU1KTsKICBwdXNoKCk7CiAgYW1iaWVudExpZ2h0KG1vdXNlWCk7
CiAgbm9ybWFsTWF0ZXJpYWwoKTsKICByb3RhdGVaKGZyYW1lQ291bnQgKiAwLjAxKTsKICByb3Rh
dGVYKGZyYW1lQ291bnQgKiAwLjAxKTsKICByb3RhdGVZKGZyYW1lQ291bnQgKiAwLjAxKTsKICBi
b3goNzAsIDcwLCA3MCk7CiAgcG9wKCk7Cn0KICA8L3NjcmlwdD4KPC9oZWFkPgo8Ym9keT4KICA8
Y2VudGVyPjxtYWluPjwvbWFpbj48L2NlbnRlcj4KPC9ib2R5Pgo8L2h0bWw+Cg==">
                                         </iframe></center>

where you can just write

```org
#+begin_src p5js :height 200 :center t
function setup() {
  createCanvas(500, 200, WEBGL);
}
function draw() {
  background(255);
  push();
  normalMaterial();
  rotateZ(frameCount * 0.01);
  rotateX(frameCount * 0.01);
  rotateY(frameCount * 0.01);
  box(70, 70, 70);
  pop();
}
#+end_src
```

export to `html` and get that nice rotating cube.


## Installing {#installing}

Below follows the implementation of the package in a literate
programming fashion.  If you are interested to see how easy it is to
implement these kinds of packages just read on.

For the moment the development of this package
happens over at <https://github.com/alejandrogallo/ob-p5js>.

As of <span class="timestamp-wrapper"><span class="timestamp">[2022-10-14 Fri] </span></span> I am going to submit the package to `melpa`,
otherwise you can just simply copy the `ob-p5js.el` file
where you can require it.


## Implementation {#implementation}

The defaults for every src block are given by

```emacs-lisp
(defcustom org-babel-default-header-args:p5js
  '((:exports . "results")
    (:results . "verbatim html replace value")
    (:eval . "t")
    (:width . "100%"))
  "P5js default header arguments")
```

where the most notable one is the `:results`,
in that it creates an `html` export block.

The custom block arguments are the `width` and `height`
for the `iframe` where the [`p5js`](https://p5js.org/) is embedded in,
and also a `center` boolean field in order to insert
**both** the `iframe` and the `main` tag inside an `html`
`center` element.

```emacs-lisp
(defcustom org-babel-header-args:p5js
 '((width . :any)
   (height . :any)
   (center . :any))
  "p5js-specific header arguments.")
```

We need to include the script in the `iframe` environment,
and you can customize where you want to get your `p5js`
from. By default it points to the default one from the website

```emacs-lisp
(defcustom p5js-src "https://cdn.jsdelivr.net/npm/p5@1.4.2/lib/p5.js"
  "The source of p5js")
```

and I also give every `iframe` the class `org-p5js` by default,
so that you can customize it via `css` or `js`.

```emacs-lisp
(defcustom p5js-iframe-class "org-p5js"
  "Default class for iframes containing a p5js sketch")
```

The body of the input for the `iframe` is a minimal
`html` document containing the src script for [`p5js`](https://p5js.org/)
and yours:

```emacs-lisp
(defun p5js--create-sketch-body (params body)
  (format "
<html>
<head>
  <script src=%S></script>
  <script>
    %s
  </script>
</head>
<body>
  %s
</body>
</html>
" p5js-src body (p5js--maybe-center params "<main></main>")))

(defun p5js--maybe-center (params body)
  (if (alist-get :center params)
      (format "<center>%s</center>" body)
    body))
```

Now an important aspect arises, how do we embed the
`html` document containing the sketch into the `iframe`.
From all my testing I found that including the whole script
as a base64 encoding hunk works best, so this is the approach I took

```emacs-lisp
(defun p5js--create-iframe (params body &optional width height)
  (let ((sketch (base64-encode-string (p5js--create-sketch-body params body))))
    (p5js--maybe-center params
                        (format "<iframe class=\"%s\"
                                         frameBorder='0'
                                         %s
                                         src=\"data:text/html;base64,%s\">
                                         </iframe>"
                                p5js-iframe-class
                                (concat (if width
                                            (format "width=\"%s\" " width)
                                          "")
                                        (if height
                                            (format "height=\"%s\" " height)
                                          ""))
                                sketch))))
```

Last but not least, comes the part that tells `org-babel`
how to execute `p5js` blocks, which entails simply defining
a function prefixed by `orb-babel-execute` with the name of the
src block.

```emacs-lisp
(defun org-babel-execute:p5js (body params)
  (let ((width (alist-get :width params))
        (height (alist-get :height params)))
    (p5js--create-iframe params body width height)))
```

And we want to inherit all the javascript goodness
when working in `p5js` src blocks, this is

```emacs-lisp
(define-derived-mode p5js-mode
    js-mode "p5js"
    "Major mode for p5js")

(provide 'ob-p5js)
```


## Conclusion {#conclusion}

And this is pretty much everything there is to it.
I hope you have some more motivation to use it in your
blog posts and provide interesting content to the community
and to you.

For the future I would like to add some autocompletion
or documentation checking for the mode, that would
make the whole experience a little bit more painless.


## References {#references}

-   The example sketches are adapted from [examples | p5.js](https://p5js.org/examples/).
