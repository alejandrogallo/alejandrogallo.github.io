(require 'package)

(setq package-enable-at-startup nil)
(setq package-archives
  '(("gnu"   . "http://elpa.gnu.org/packages/")
    ("melpa" . "http://melpa.org/packages/"   )))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(use-package htmlize
             :ensure t)

(use-package raku-mode
             :ensure t)

(require 'org)

(use-package org-src
  :config
  (setq org-src-fontify-natively t
        org-src-preserve-indentation t
        org-src-tab-acts-natively t))

(load-theme 'tsdh-light)

(defun publish-site ()
  (interactive)
  (let* ((site-file-path (file-name-directory (buffer-file-name)))
         (org-publish-project-alist
          `(("site"
             :base-directory ,site-file-path
             :publishing-directory ,site-file-path
             :section-numbers nil
             :table-of-contents t
             :publishing-function org-html-publish-to-html
             ;;:publishing-function org-html-export-to-html
             :htmlized-source nil
             :language en
             :exclude ".*templates.*"
             :recursive t))))
      (message "\x1b[35m∀ Publishing site now...\x1b[0m")
      (org-publish-current-project)))
