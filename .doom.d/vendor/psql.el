;;; ../dotfiles/link/doom.d/vendor/psql.el -*- lexical-binding: t; -*-
(defun db-cfg ()
  (interactive)
  (save-excursion
    (let (p1 p2 dbcon)
      (search-backward "---- db:")
      (setq p1 (point))
      (setq p2 (line-end-position))
      (substring (buffer-substring-no-properties p1 p2) 8 ))))


(defun run-sql ()
  (interactive)
  (save-excursion
    (let (p1 p2 dbcon)
      (search-backward "----")
      (setq p1 (point))
      (search-forward "----")
      (search-forward "----")
      (setq p2 (point))

      (let (cmd cfg output)
        (setq cmd (buffer-substring-no-properties p1 p2))
        (setq cfg (db-cfg))
        (write-region p1 p2 "/tmp/epsql.sql")
        (cond
         ((equal "psql" (car (split-string cfg)))
          (setq cmd (format "%s -f /tmp/epsql.sql -o /tmp/epsqlresp.sql" (db-cfg) cmd)))
         ((equal "mysql" (car (split-string cfg)))
          (setq cmd (format "%s < /tmp/epsql.sql | grep -v \"Using a password\"  > /tmp/epsqlresp.sql" (db-cfg) cmd))))
        (setq output (shell-command-to-string cmd))
        (message output)
        (with-output-to-temp-buffer "sql-result"
          (save-current-buffer
            (set-buffer "sql-result")
            (funcall (intern "sql-mode"))
            (insert-file-contents "/tmp/epsqlresp.sql" nil nil nil t)
            (insert
             (format "----------- Result ------------\n%s-----------  End   ------------\n\n\n" output))))))))

(provide 'psql)
