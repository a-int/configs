(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(global-set-key "\C-x\ \C-g" 'recentf-open-files)
(setq redisplay-dont-pause t
      scroll-margin 5
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)

(eval-when-compile (require 'use-package))

(use-package auto-complete
  :ensure t)

(use-package slime
  :ensure t
  :commands slime
  :init (setq inferior-lisp-program "sbcl"))

(use-package ac-slime
  :ensure t
  :after slime
  :hook ((slime-mode . set-up-slime-ac)
	 (slime-repl-mode . set-up-slime-ac)
	 (slime-mode . auto-complete-mode)
	 (slime-repl-mode . auto-complete-mode))
  :config (eval-after-load "auto-complete"
   '(add-to-list 'ac-modes 'slime-repl-mode)))

(use-package haskell-mode
  :ensure t
  :mode ("\\.hs\\'" . haskell-mode))

(use-package lsp-haskell
  :ensure t
  :hook ((haskell-mode . lsp)
	 (haskell-literate-mode . lsp)))

(use-package rust-mode
  :ensure t)

(use-package tree-sitter
  :ensure t
  :config (global-tree-sitter-mode))

(use-package tree-sitter-langs
  :ensure t
  :after tree-sitter
  :hook ((c-mode c++-mode rust-mode) . tree-sitter-hl-mode))

;; LSP
(use-package lsp-mode
  :ensure t
  :commands lsp
  :custom
  (gc-cons-threshold 100000000)
  (read-process-output-max (* 1024 1024))
  (lsp-idle-delay 0.100)
  (lsp-log-io nil)
  :hook ((c-mode . lsp)
	 (c++-mode . lsp)
	 (rust-mode . lsp)))

(use-package lsp-ui
  :ensure t
  :after lsp-mode
  :custom
  (lsp-ui-doc-show-with-cursor t))

;; Company - text completion framework
(use-package company
  :ensure t
  :init (global-company-mode)
  :bind (:map company-active-map
	 ("<tab>" . company-select-next)
	 ("<backtab>" . company-select-previous))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.01))

(use-package vertico
  :ensure t
  :init
  (vertico-mode))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package ace-jump-mode
  :ensure t
  :bind ("C-c SPC" . ace-jump-mode))

(use-package all-the-icons
  :ensure t
  :custom
  (all-the-icons-scale-factor 1.0)
  :if (display-graphic-p))

(use-package dashboard
  :ensure t
  :custom
  (dashboard-center-content t)
  (dashboard-set-heading-icons t)
  (dashboard-set-file-icons t)
  :config
  (dashboard-setup-startup-hook))

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode))

;; Example configuration for Consult
(use-package consult
  :ensure t
  :bind (
         ;; M-g bindings (goto-map)
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ;; M-s bindings (search-map)
         ("M-s d" . consult-find)
         ("M-s D" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s m" . consult-multi-occur)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
))

(use-package orderless
 :ensure t
 :init
 (setq completion-styles '(orderless)
   completion-category-defaults nil
   completion-category-overrides '((file (styles . (partial-completion))))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-default-style
   '((java-mode . "java")
     (awk-mode . "awk")
     (other . "linux")))
 '(custom-enabled-themes '(atom-one-dark))
 '(custom-safe-themes
   '("171d1ae90e46978eb9c342be6658d937a83aaa45997b1d7af7657546cae5985b" default))
 '(global-display-line-numbers-mode t)
 '(indent-tabs-mode nil)
 '(menu-bar-mode nil)
 '(package-selected-packages
   '(atom-one-dark-theme orderless consult avy projectile visual-regexp dap-mode ivy lsp-ui dashboard ac-slime slime rust-mode lsp-haskell neotree company flycheck powerline all-the-icons use-package))
 '(recentf-mode t)
 '(scroll-bar-mode nil)
 '(tab-bar-mode t)
 '(tab-width 4)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 108 :width normal :foundry "JB  " :family "JetBrainsMono Nerd Font Mono")))))
