+++
title = "Convert energy into Hartree energy in emacs"
author = ["Alejandro Gallo"]
date = 2023-05-18T00:00:00+02:00
tags = ["emacs", "elisp", "chemistry"]
draft = false
+++

There is a neat program in emacs which is called [(GNU Emacs Calc Manual)](https://www.gnu.org/software//emacs/manual/html_node/calc/).
Up to now in order to do energy conversion I always wrote small scripts
in whatever language to do this.

Now I discovered that you do these conversions also in emacs,
you can do `M-x calc`, insert an algebraic form typing `'`
followed by `1.5 ev`, which inputs 1.5 electron volt into the stack
of the calculator.

Now you can change the units of this, by typing `u c`.
You can change it to Kelvin for instance by typing `Ken` as the new units.
Quantum chemists and physicists use often the units of
[Hartree atomic units - Wikipedia](https://en.wikipedia.org/wiki/Hartree_atomic_units)  which is quite convenient for atomic systems.

There is no Hartree units in emacs calc, but you can write a simple function
to define units,

```emacs-lisp
(defun blog/define-unit (symbol def description)
  (setq math-additional-units
        (cons (list symbol def description)
              math-additional-units)
        math-units-table nil)
  (calc-invalidate-units-table))

(blog/define-unit 'ha "27.21139664130791 ev" "Hartree atomic units energy")
```

Now you can convert from `eV` to `Ha` from you beloved emacs!
