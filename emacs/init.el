;;; CUSTOMIZING LOOKS
(tool-bar-mode -1)
(set-frame-font "monospace 11" nil t)
(global-display-line-numbers-mode)


;;; EXTENSIONS
;; Package list
(setq package-archives 
      '(("melpa" . "https://melpa.org/packages/")
	("elpa" . "https://elpa.gnu.org/packages/")))

;; Bootstrap use-package
(package-initialize)
(setq use-package-always-ensure t)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))

;; Vim bindings
(use-package evil
  :config
  (evil-mode 1)
  (evil-set-undo-system 'undo-redo)
  (evil-define-key 'insert 'global (kbd "C-p") 'yank)
  (evil-define-key 'normal 'global (kbd "C-e") 'eval-buffer)
  (evil-define-key 'normal 'global (kbd "C-q") 'save-buffers-kill-emacs))

;; Catppuccin theme
(use-package catppuccin-theme
  :config
  (load-theme 'catppuccin :no-confirm))

;; Language support and autocompletion
(use-package company
  :hook (prog-mode . company-mode))

(use-package go-mode
  :hook (go-mode-hook . eglot-ensure))

(use-package rust-mode
  :hook (rust-mode-hook . eglot-ensure))

;; Dashboard
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents  . 5)
			  (bookmarks . 5)
			  (agenda . 5)
			  (registers . 5))))

;; org-mode
(use-package org-tree-slide)

(use-package org-modern
  :hook (org-mode . org-modern-mode))


;;; CUSTOM-SET-VARIABLES
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(org-modern company go-mode dashboard catppuccin-theme evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
