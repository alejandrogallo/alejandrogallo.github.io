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
             :htmlized-source t
             :language en
             :exclude ".*templates.*"
             :recursive t))))
      (message "\x1b[35m∀ Publishing site...\x1b[0m")
      (org-publish-current-project)
    )
  )
