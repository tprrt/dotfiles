;;; weekly-mode.el --- Major mode for custom weekly format

(defface weekly-title-face
  '((t :foreground "gray" :weight bold))
  "Face for highlighting title."
  :group 'weekly-mode)

(defface weekly-day-face
  '((t :foreground "deep sky blue"))
  "Face for highlighting days."
  :group 'weekly-mode)

(defface weekly-activity-face
  '((t :foreground "forest green"))
  "Face for highlighting activities."
  :group 'weekly-mode)

(defface weekly-category-face
  '((t :foreground "dark orange"))
  "Face for highlighting activity categories."
  :group 'weekly-mode)

(defface weekly-duration-face
  '((t :foreground "purple"))
  "Face for highlighting activity durations."
  :group 'weekly-mode)

(defvar weekly-mode-syntax-table
  (let ((syntax-table (make-syntax-table)))
    (modify-syntax-entry ?- "w" syntax-table)
    (modify-syntax-entry ?= ". 23b" syntax-table)
    (modify-syntax-entry ?* ". 23b" syntax-table)
    (modify-syntax-entry ?\n ">" syntax-table)
    syntax-table)
  "Syntax table for `weekly-mode`")
(defvar weekly-font-lock-keywords
  '(
    ("^\\(Report.*\\)$" . 'weekly-title-face)
    ("^\\(====*\\)$" . 'weekly-title-face)
    ("^\\(Monday\\|Tuesday\\|Wednesday\\|Thursday\\|Friday\\|Saturday\\|Sunday\\)$" . 'weekly-day-face)
    ("^\\( \\* [A-Za-z0-9 -]+:\\)$" . 'weekly-activity-face)
    ("^\\( \\* [A-Za-z0-9 -]+:\\) \\([0-9.]+d\\)$" (1 'weekly-activity-face) (2 'weekly-duration-face))
    ("^\\( \\* [A-Za-z0-9 -]+, \\)\\([A-Za-z0-9 -.]+:\\)$"
     (1 'weekly-activity-face) (2 'weekly-category-face))
    ("^\\( \\* [A-Za-z0-9 -]+, \\)\\([A-Za-z0-9 -.]+:\\) ?\\([0-9.]+d\\)?$"
     (1 'weekly-activity-face) (2 'weekly-category-face) (3 'weekly-duration-face))
    )
  "Font-lock keywords for `weekly-mode`")

(defun custom-report-indent-line ()
  (interactive)
  (save-excursion
    (beginning-of-line)
    (cond
     ;; Indent day of week lines
     ((looking-at "^\\(Monday\\|Tuesday\\|Wednesday\\|Thursday\\|Friday\\)$") (indent-line-to 0))
     ;; Indent * Activity lines
     ((looking-at "^ *\\* [A-Za-z0-9, -]+:.*$") (indent-line-to 1))
     ;; Indent report title and separation line
     ((looking-at "^\\(Report for.*\\|=+\\)$") (indent-line-to 0))
     ;; Default indentation
     (t (indent-line-to 3)))))

(defun insert-newline-without-indent ()
  (interactive)
  (newline))


(define-derived-mode weekly-mode text-mode "Weekly"
  "Major mode for editing custom weekly format."
  :syntax-table weekly-mode-syntax-table
  (setq font-lock-defaults '(weekly-font-lock-keywords))
  (setq-local indent-line-function #'custom-report-indent-line)
  (define-key weekly-mode-map (kbd "RET") 'insert-newline-without-indent)
  )

(defun weekly-fill-paragraph ()
  "Fill the current paragraph."
  (interactive)
  (let ((fill-prefix "   "))
    (fill-paragraph nil)))

(define-key weekly-mode-map (kbd "M-q") 'weekly-fill-paragraph)

;;;###autoload
(add-to-list 'auto-mode-alist '("week[0-9]*\\.txt\\'" . weekly-mode))

(provide 'weekly-mode)
