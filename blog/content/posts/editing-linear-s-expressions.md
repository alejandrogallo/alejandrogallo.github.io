+++
title = "Editing linear s-expressions"
author = ["Alejandro Gallo"]
date = 2022-11-28T00:00:00+01:00
tags = ["orgmode", "emacs", "elisp"]
draft = false
+++

I have been wanting to edit some s-expressions on single lines,
like for instance to edit `org-mode` macros.

This is a very short blog post but I just wanted to share this function that allows
to edit a linearised s-expression quite trivially.

For instance in a certain buffer I have a local variable like this

```text { textarea="t" }
# Local Variables:
# eval: (add-hook 'after-save-hook (let ((name (buffer-name (current-buffer)))) (lambda () (message "Automatically committing %s" buffer-name) (ale/scratchpad/stage-and-commit))) nil t)
# End:
```

and of course this is extremely annoying to edit.
There are some ways around it but if you just want this to be like this, without external files
or more convoluted solutions, separedit can help you there.

From the website

[twlz0ne/separedit.el: Edit comment or string/docstring or code block inside them in separate buffer with your favorite mode](https://github.com/twlz0ne/separedit.el)

it is a wrapper over the edit-indirect mode.

You can write your own `C-c '` org functionality everywhere, which is great and I use it profusely
everywhere, for instance doing CPP macrology in an ergonomic way.

It is quite easy to extend, but let's go directly to the _tacheles_ part.

The function in question is here:

```emacs-lisp
(defun ale/separedit-sexp (&optional arg)
  (interactive "P")
  (let* ((begend (bounds-of-thing-at-point 'sexp))
         (block (separedit-mark-region (car begend)
                                       (cdr begend)
                                       'emacs-lisp-mode)))
    (when arg
      (plist-put block
                 :regexps
                 '(:delimiter-remove-fn
                   (lambda (_ &optional _)
                     (pp-buffer))
                   :delimiter-restore-fn
                   (lambda (&optional _)
                     (join-line nil
                                (point-min)
                                (point-max))))))
    (separedit-dwim-default block)))
```

So, it uses the `bounds-of-thing-at-point` builtin function to get an
s-expression from the position of your cursor.  It then creates a
separedit info block with information about the region. In this case
the `separedit-mark-region` is a deceptively simple interface to the
info block so I put some more sauce after that.

Without the universal argument, you can just edit the s-expression,
and go on with your life.
If you provide however the universal argument the block will get
two additional properties,
`:delimiter-remove-fn` and `:delimiter-restore-fn`.

The first is a callback that happens when you get your fresh indirect region
to edit, and the latter is when you save the indirect buffer that your editing
and it gets back to the original buffer.

You see, how easy it is just to create a function that pretty-prints the s-expression
using the builtin `pp-buffer` function, and when you're done editing
you just join all the lines.

Now, granted, this approach has some flaws, it is not idempotent.
Also in some cases, for instance, when you have multi-line strings,
the newlines will get lost. Well, I don't care but it's not much effort to update the function.

So for the example below, when I start editing it doing
`C-u M-x ale/separedit-sexp` I get a side buffer with the following content

```elisp
(add-hook 'after-save-hook
           (let
               ((name
                 (buffer-name
                  (current-buffer))))
             (lambda
               ()
               (message "Automatically committing %s" name)
               (stage-and-commit name)))
           nil t)
```

It is not a perfect indentation but it is much better
than the single line.

I hope you learnt something new, and if not maybe you know someone
that finds it interesting!
