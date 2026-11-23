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

;;; enable sticky scroll on programming modes
(semantic-mode 1)
(global-semantic-stickyfunc-mode 1)
;;; Sticky Scroll (keep function definitions on top)
(defun sticky-scroll ()
  "Enable Sticky-Scroll."
  (semantic-mode 1)
  (semantic-stickyfunc-mode 1))

;;; Clang stuff
(use-package clang-format
    :ensure t)
(setq clang-format-style "file")

;;; AucTeX
(use-package auctex
  :ensure t
  :mode ("\\.tex\\'" . LaTeX-mode)
  :config
  (setq TeX-view-program-selection
        '((output-pdf "Zathura"))
        TeX-source-correlate-start-server t
        font-latex-fontify-script nil)
  (add-hook 'TeX-after-compilation-finished-functions
            #'TeX-revert-document-buffer))

;;; Version-Control (git)
(use-package magit
  :ensure t
  :bind
  (("C-x g" . magit-status)
   ("C-c g l" . magit-log-current)
   ("C-c g b" . magit-blame)))

;;; PDF Tools
;(use-package pdf-tools
;    :ensure t
;    :init 
;    (pdf-tools-install))

;;; only vertical buffers
;(setq split-height-threshold nil)
;(setq split-width-threshold 0)

;;; delete selected text on insertion
(use-package delsel
  :ensure nil ; no need to install it as it is built-in
  :hook (after-init . delete-selection-mode))

;;; LLDB
(global-set-key (kbd "C-c d") #'lldb)

;;; CMake
(use-package cmake-mode
  :ensure t)
;; compile
(defun cmake-build ()
  "Configure and build the current CMake project."
  (interactive)
  (let* ((root (or (locate-dominating-file default-directory
                                           "CMakeLists.txt")
                   (user-error "No CMakeLists.txt found")))
         (build-type (completing-read
                      "Build type: "
                      '("Debug" "Release")
                      nil t nil nil "Debug"))
         (build-dir (expand-file-name "build" root))
         (compile-db (expand-file-name "compile_commands.json" root))
         (build-db (expand-file-name "compile_commands.json" build-dir))
         (default-directory root)
         (command
          (format
           "cmake -S %s -B %s -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=%s && ln -sf %s %s && cmake --build %s"
           (shell-quote-argument root)
           (shell-quote-argument build-dir)
           (shell-quote-argument build-type)
           (shell-quote-argument build-db)
           (shell-quote-argument compile-db)
           (shell-quote-argument build-dir))))
    (compile command)))

;;; look of emacs
;; disable menu and tool bar
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(show-paren-mode 1)
(electric-pair-mode 1)

(setq-default mode-line-format nil)
;; enable relative line numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

(setq-default inhibit-splash-screen t
              make-backup-files nil
              tab-width 4
              indent-tabs-mode nil
              compilation-scroll-output 'first-error
              compilation-always-kill t
              visible-bell t)

;; disable word wrapping
(setq-default truncate-lines t)

;;; mouse support
(xterm-mouse-mode 1)
(setq mouse-wheel-tilt-scroll t
      mouse-wheel-flip-direction t)

;;; font
(add-to-list 'default-frame-alist `(font . "SF Mono-14"))

;;; theme
(use-package doom-themes
  :ensure t
  :config
  ;(load-theme 'doom-xcode t))
  (load-theme 'doom-gruvbox t))

;(use-package gruber-darker-theme
;  :ensure t
;  :config
;  (load-theme 'gruber-darker :no-confirm-loading))

;; italics comments
(set-face-attribute 'font-lock-comment-face nil :slant 'italic)
(set-face-attribute 'font-lock-comment-delimiter-face nil :slant 'italic)

;;; Move Text
(use-package move-text
  :ensure t
  :bind (("M-p" . move-text-up)
         ("M-n" . move-text-down)))

;;; configure minibuffer
;(ido-mode)
;(ido-everywhere)
;
;(use-package ido-completing-read+
;    :ensure t
;    :hook (after-init . ido-ubiquitous-mode))

;;; vertico (alternative to ido)
 (use-package vertico
   :ensure t
   :init
   (vertico-mode 1))

;;; nice list of M-x options
;(use-package amx
;    :ensure t
;    :hook (after-init . amx-mode))

;;; smex (alternative to amx)
;(use-package smex
;    :ensure t
;    :init 
;    (smex-initialize)
;    (global-set-key (kbd "M-x") 'smex)
;    (global-set-key (kbd "M-X") 'smex-major-mode-commands))

;;; consult better isearch
; (use-package consult
;   :ensure t
;   :bind (("M-s r" . consult-ripgrep)))

;;; command annotations
(use-package marginalia
  :init
  (marginalia-mode 1))


;;; better command search
(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides nil))

(use-package savehist
  :init
  (savehist-mode))

;;; LSP client
(use-package eglot
  :hook ((python-mode . eglot-ensure)
         (rust-mode . eglot-ensure)
         (c++-mode . eglot-ensure)
         (c-mode . eglot-ensure))
  :config
  (add-to-list 'eglot-server-programs
              '((c-mode c++-mode c-ts-mode c++-ts-mode)
                . ("clangd")))
  ;; Disable inlay hints by default
  (add-hook 'eglot-managed-mode-hook (lambda () (eglot-inlay-hints-mode -1)))
  (setq eglot-stay-out-of '(flymake)
        eglot-ignored-server-capabilities '(:inlayHintProvider)))

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
  (require 'dired-x)
  (setq dired-recursive-copies 'always
        dired-recursive-deletes 'always
        delete-by-moving-to-trash t
        dired-omit-files
        (concat dired-omit-files "\\|^\\..+$")
        dired-dwim-target t
        dired-listing-switches "-alh"
        dired-mouse-drag-files t))

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
  (setq trashed-action-confirmer 'y-or-n-p
        trashed-use-header-line t
        trashed-sort-key '("Date deleted" . t)
        trashed-date-format "%Y-%m-%d %H:%M:%S"))

;;; move between split windows with SHIFT-<arrow key>
(windmove-default-keybindings)
