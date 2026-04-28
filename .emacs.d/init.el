;;; store auto-generated configs in seperate file
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :no-error-if-file-is-missing)

;;; set up package manager
(require 'package)
(package-initialize)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
;;; install use-package if not on version 29 or later
(when (< emacs-major-version 29)
  (unless (package-installed-p 'use-package)
    (unless package-archive-contents
      (package-refresh-contents))
    (package-install 'use-package)))

;;; hide install warnings
(add-to-list 'display-buffer-alist
             '("\\`\\*\\(Warnings\\|Compile-Log\\)\\*\\'"
               (display-buffer-no-window)
               (allow-no-window . t)))

;;; AucTeX
(use-package auctex
    :ensure t)

;;; PDF Tools
(use-package pdf-tools
    :ensure t
    :init 
    (pdf-tools-install))

;;; only vertical buffers
(setq split-height-threshold nil)
(setq split-width-threshold 0)

;;; delete selected text on insertion
(use-package delsel
  :ensure nil ; no need to install it as it is built-in
  :hook (after-init . delete-selection-mode))

;;; look of emacs
;; disable menu and tool bar
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(show-paren-mode 1)
;; enable relative line numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

(setq-default inhibit-splash-screen t
              make-backup-files nil
              tab-width 4
              indent-tabs-mode nil
              compilation-scroll-output t
              visible-bell t)

;; disable word wrapping
(setq-default truncate-lines t)

;;; mouse support
(xterm-mouse-mode 1)
(setq mouse-wheel-tilt-scroll t)
(setq mouse-wheel-flip-direction t)

;;; font
(add-to-list 'default-frame-alist `(font . "Iosevka-14"))
;; (let ((mono-spaced-font "Iosevka")
;;       (proportionately-spaced-font "Sans"))
;;   (set-face-attribute 'default nil :family mono-spaced-font :height 100)
;;   (set-face-attribute 'fixed-pitch nil :family mono-spaced-font :height 1.0)
;;   (set-face-attribute 'variable-pitch nil :family proportionately-spaced-font :height 1.0))

;;; theme
(use-package gruber-darker-theme
  :ensure t
  :config
  (load-theme 'gruber-darker :no-confirm-loading))

;;; Evil (vim bindings)
;; ;; download Evil
;; (unless (package-installed-p 'evil)
;;   (package-install 'evil))
;; ;; enable Evil
;; (require 'evil)
;; (evil-mode 1)

;;; Move Text
(use-package move-text
    :ensure t)
(global-set-key (kbd "M-p") 'move-text-up)
(global-set-key (kbd "M-n") 'move-text-down)

;;; Major Modes
;; c-mode
(setq-default c-basic-offset 4
              c-default-style '((java-mode . "java")
                                (awk-mode . "awk")
                                (other . "bsd")))
(add-hook 'c-mode-hook (lambda ()
                         (interactive)
                         (c-toggle-comment-style -1)))
;; LaTeX
(setq TeX-view-program-selection '((output-pdf "PDF Tools"))
      TeX-source-correlate-start-server t)
(add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)
(setq font-latex-fontify-script nil)

;;; lsp-mode
;;(use-package lsp-mode
;;  :ensure t
;;  :config
;;  (add-hook 'c++-mode-hook #'lsp)
;;  (setq lsp-clients-clangd-args '("-j=4" "-background-index" "-log=error")))
;;
;;(use-package xref
;;  :ensure t)

;;; configure minibuffer
(ido-mode)
(ido-everywhere)

(use-package ido-completing-read+
    :ensure t
    :hook (after-init . ido-ubiquitous-mode))

;; ivy (alternative to ido)
;(use-package ivy
;    :ensure t)
;    :hook (after-init . ivy-mode)

;; nice list of M-x options
;(use-package amx
;    :ensure t
;    :hook (after-init . amx-mode))

;; smex (alternative to amx)
(use-package smex
    :ensure t
    :init 
    (smex-initialize)
    (global-set-key (kbd "M-x") 'smex)
    (global-set-key (kbd "M-X") 'smex-major-mode-commands))

;; vertico (alternative to ido)
; (use-package vertico
;   :ensure t
;   :init
;   (vertico-mode)
;   (vertico-flat-mode))

;; consult better isearch
; (use-package consult
;   :ensure t
;   :bind (("M-s r" . consult-ripgrep)))

;; command annotations
;(use-package marginalia
;  :ensure t
;  :hook (after-init . marginalia-mode))

;; better command search
(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic))
  (setq completion-category-defaults nil)
  (setq completion-category-overrides nil))

(use-package savehist
  :init
  (savehist-mode))

;; completion
;(use-package corfu
;  :ensure t
;  :hook (after-init . global-corfu-mode)
;  :bind (:map corfu-map ("<tab>" . corfu-complete))
;  :config
;  (setq tab-always-indent 'complete)
;  (setq corfu-preview-current nil)
;  (setq corfu-min-width 20)
;
;  (setq corfu-popupinfo-delay '(1.25 . 0.5))
;  (corfu-popupinfo-mode 1) ; shows documentation after `corfu-popupinfo-delay'
;
;  ;; Sort by input history (no need to modify `corfu-sort-function').
;  (with-eval-after-load 'savehist
;    (corfu-history-mode 1)
;    (add-to-list 'savehist-additional-variables 'corfu-history)))

;;; 'dired' file manager
(use-package dired
  :ensure nil
  :commands (dired)
  :config
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always)
  (setq delete-by-moving-to-trash t)
  (setq dired-omit-files
      (concat dired-omit-files "\\|^\\..+$"))
  (setq-default dired-dwim-target t)
  (setq dired-listing-switches "-alh")
  (setq dired-mouse-drag-files t))

(use-package dired-subtree
  :ensure t
  :after dired
  :bind
  ( :map dired-mode-map
    ("<tab>" . dired-subtree-toggle)
    ("TAB" . dired-subtree-toggle)
    ("<backtab>" . dired-subtree-remove)
    ("S-TAB" . dired-subtree-remove))
  :config
  (setq dired-subtree-use-backgrounds nil))

(use-package trashed
  :ensure t
  :commands (trashed)
  :config
  (setq trashed-action-confirmer 'y-or-n-p)
  (setq trashed-use-header-line t)
  (setq trashed-sort-key '("Date deleted" . t))
  (setq trashed-date-format "%Y-%m-%d %H:%M:%S"))

;;; move between split windows with SHIFT-<arrow key>
(windmove-default-keybindings)
