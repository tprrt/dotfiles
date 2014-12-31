(custom-set-variables
 ;; custom-set-variables was added byoctave-core Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(inhibit-startup-screen t)
 '(size-indication-mode t)
 '(tooltip-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "ARGBBB000000" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 90 :width normal :foundry "bitstream" :family "Bitstream Vera Sans Mono")))))

;; python
(autoload 'python-mode "python-mode.el" "Python mode." t)
(setq auto-mode-alist (append '(("/*.\.py$" . python-mode)) auto-mode-alist))

;; php
(autoload 'php-mode "php-mode.el" "Php mode." t)
(setq auto-mode-alist (append '(("/*.\.php[345]?$" . php-mode)) auto-mode-alist))

;; lua
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(setq auto-mode-alist (cons '("\.lua$" . lua-mode) auto-mode-alist))

;; caml
(setq auto-mode-alist
      (cons '("\\.ml[iylp]?$" . caml-mode) auto-mode-alist))
(autoload 'caml-mode "caml" "Major mode for editing Caml code." t)
(autoload 'run-caml "inf-caml" "Run an inferior Caml process." t)

(if window-system (require 'caml-font))

;; dot
(load-file "/home/pantoufle/.emacs.d/graphviz-dot-mode.el") 

;; git
(require 'git)
(require 'git-blame)

;;multi maj mode on one buffer
;;(require 'mmm-mode) ;;(require 'mmm-auto)
;;(setq mmm-global-mode 'maybe)
;;(setq load-path (cons "/usr/share/emacs/site-lisp/mmm-mode" load-path))

;; config
;;(menu-bar-mode -1)
;;(add-hook 'write-file-hooks 'time-stamp)
;;(tool-bar-mode -1)
(global-font-lock-mode 1)
;;(mwheel-install)
(setq selection-coding-system 'compound-text-with-extensions)

;; utf8
(setq locale-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
