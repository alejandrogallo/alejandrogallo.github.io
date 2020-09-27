(defun publish-blog ()
  (interactive)
  (let* ((blog-file-path (file-name-directory (buffer-file-name)))
         (org-publish-project-alist
          `(("blog"
             :base-directory ,blog-file-path
             :publishing-directory ,blog-file-path
             :section-numbers nil
             :table-of-contents nil
             :publishing-function org-html-publish-to-html
             :htmlized-source t
             :recursive t))))
      (message "\x1b[35m∀ Publishing...\x1b[0m")
      (org-publish-current-project)
    )
  )
