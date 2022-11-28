(require 'ox-hugo)

(defun blog-make ()
  (interactive)
  (unless (buffer-narrowed-p)
    (error "You should be in a narrowed place to do this"))
  (org-hugo-export-to-md))


(defun blog-new (fname)
  (interactive "sFile name: \n")
  (org-set-property "EXPORT_FILE_NAME" fname)
  (org-set-property "EXPORT_DATE" (with-temp-buffer
                                    (org-time-stamp-inactive)
                                    (buffer-string))))
