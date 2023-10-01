;;; CUSTOMIZING LOOKS
(tool-bar-mode -1)
(set-frame-font "monospace 11" nil t)
(display-line-numbers-mode)


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
  (evil-define-key 'normal 'global (kbd "C-e") 'eval-buffer)
  (evil-define-key 'normal 'global (kbd "C-q") 'save-buffers-kill-emacs))

;; Catppuccin theme
(use-package catppuccin-theme
  :config
  (load-theme 'catppuccin :no-confirm))

;; Autocomplete
(use-package auto-complete
  :config
  (ac-config-default))

;; Tree sitter
(use-package tree-sitter)
(use-package tree-sitter-langs)


;;; CUSTOM-SET-VARIABLES
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(ligature fira-code-mode tree-sitter-langs tree-sitter auto-complete catppuccin-theme evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
