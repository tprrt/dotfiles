(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(inhibit-startup-screen t)
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tooltip-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defun no-junk-please-were-unixish ()
  (let ((coding-str (symbol-name buffer-file-coding-system)))
    (when (string-match "-\\(?:dos\\|mac\\)$" coding-str)
      (set-buffer-file-coding-system 'unix))))

(add-hook 'find-file-hooks 'no-junk-please-were-unixish)

(add-hook 'prog-mode-hook
          (lambda () (add-to-list 'write-file-functions 'delete-trailing-whitespace)))

(require 'generic-x)
(define-generic-mode 'bootlin-weekly-mode
  nil                                                      ;; no syntax for comments
  '("Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Saturday")    ;; keywords
  '(("[01]\.[0-9]d$" . 'font-lock-warning-face)
    ("[01]d$" . 'font-lock-warning-face)
    ("^ \\* [A-Za-z0-9- ]+" . 'font-lock-function-name-face)
    ("^ \\* \\([A-Za-z0-9-, ]+\\)" . 'font-lock-comment-face)
    )
  '("week[0-9][0-9]\\.txt$")                               ;; file pattern
  nil                                                      ;; other functions to call
  "A mode for Bootlin weekly files"                        ;; description
  )
