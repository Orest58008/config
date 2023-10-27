;;; CONSTS
(defconst emacs-dir (expand-file-name "~/.config/emacs/")
  "Emacs config directory")


;;; CUSTOMIZING LOOKS
(tool-bar-mode -1)
(set-frame-font "monospace 11" nil t)
(global-display-line-numbers-mode)
(horizontal-scroll-bar-mode)


;;; PACKAGE MANAGEMENT SETUP
;; Install elpaca
(defvar elpaca-installer-version 0.5)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil
                              :files (:defaults (:exclude "extensions"))
                              :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (< emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                 ((zerop (call-process "git" nil buffer t "clone"
                                       (plist-get order :repo) repo)))
                 ((zerop (call-process "git" nil buffer t "checkout"
                                       (or (plist-get order :ref) "--"))))
                 (emacs (concat invocation-directory invocation-name))
                 ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                       "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                 ((require 'elpaca))
                 ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (load "./elpaca-autoloads")))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

;; Install use-package support
(elpaca elpaca-use-package
  (elpaca-use-package-mode)
  (setq elpaca-use-package-by-default t))
(elpaca-wait)

;;; EXTENSIONS
;; Catppuccin theme
(use-package catppuccin-theme
  :config (enable-theme 'catppuccin))

;; Dashboard
(use-package dashboard
  :elpaca t
  :config
  (add-hook 'elpaca-after-init-hook #'dashboard-insert-startupify-lists)
  (add-hook 'elpaca-after-init-hook #'dashboard-initialize)
  (dashboard-setup-startup-hook))

(setq dashboard-items '((recents . 5)))

;; Vim bindings
(use-package evil
  :config
  (evil-mode 1)
  (evil-set-undo-system 'undo-redo)
  (evil-define-key 'insert 'global (kbd "C-p") 'yank)
  (evil-define-key 'normal 'global (kbd "C-o") 'find-file)
  (evil-define-key 'normal 'global (kbd "C-e") 'eval-buffer)
  (evil-define-key 'normal 'global (kbd "C-q") 'save-buffers-kill-emacs))

;; Language support and autocompletion
(use-package company
  :hook (prog-mode . company-mode))

(use-package go-mode
  :hook (go-mode . eglot-ensure))

(use-package rust-mode
  :hook (rust-mode . eglot-ensure))

(use-package org-tree-slide)

(use-package org-modern
  :hook (org-mode . org-modern-mode))
