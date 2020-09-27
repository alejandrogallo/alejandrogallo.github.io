
(defun publish-blog ()
  (interactive)
  (let* ((blog-file-path (file-name-directory (buffer-file-name)))
         (org-publish-project-alist
          '(("blog"
             :base-directory blog-file-path
             :publishing-directory blog-file-path
             :section-numbers nil
             :table-of-contents nil
             :publishing-function org-html-publish-to-html
             :htmlized-source t
             :recursive t))))
      ;(org-publish-current-project)
    )
  )
