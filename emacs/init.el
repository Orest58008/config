;;; CUSTOMIZING LOOKS
(tool-bar-mode -1)
(set-frame-font "monospace 11" nil t)
(add-hook 'org-mode-hook 'horizontal-scroll-bar-mode) ; TODO create automatic scroll bar plugin

;; Line numbers
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'org-mode-hook 'display-line-numbers-mode)


;;; PACKAGE MANAGEMENT SETUP
;; Bootstrap straight
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Enable use-package support
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)


;;; EXTENSIONS
;; Flexoki theme
(use-package flexoki-themes
  :config (load-theme 'flexoki-themes-dark t))

;; Dashboard
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

(defun dashboard-insert-config (list-size)
  (dashboard-insert-heading "Emacs config:")
  (insert "\n"))
(add-to-list 'dashboard-item-generators '(config . dashboard-insert-config))

(setq dashboard-items '((recents  . 5)
			(config . 5)))

(setq dashboard-startup-banner 'logo)

;; Vim bindings
(use-package evil
  :config
  (evil-mode 1)
  (evil-set-undo-system 'undo-redo)
  (evil-define-key 'insert 'global (kbd "C-p") 'yank)
  (evil-define-key 'normal 'global (kbd "C-o") 'find-file)
  (evil-define-key 'normal 'global (kbd "C-S-o") 'find-file-other-window)
  (evil-define-key 'normal 'global (kbd "C-v") 'vterm-other-window)
  (evil-define-key 'normal 'global (kbd "C-e") 'eval-buffer)
  (evil-define-key 'normal 'global (kbd "C-q") 'save-buffers-kill-emacs))

;; vterm
(use-package vterm
    :ensure t)

;; Language support and autocompletion
(use-package company
  :hook (prog-mode . company-mode))
(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package lsp-mode)
(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode))

(use-package go-mode
  :hook (go-mode . lsp))

(use-package rust-mode
  :hook (rust-mode . lsp))

(use-package org-tree-slide)

(use-package org-modern
  :hook (org-mode . org-modern-mode))
