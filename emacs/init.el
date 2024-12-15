;; -*- lexical-binding: t; -*-

                                        ; VISUAL SETTINGS
;; Display line and column numbers
(column-number-mode)
(global-display-line-numbers-mode)

;; Disable annoying bars
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; Set monospace font
(set-frame-font "monospace 12" nil t)

                                        ; EDITING SETTINGS
;; Automatch brackets
(add-hook 'prog-mode-hook 'electric-pair-mode)

;; Disable tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 3)

;; Set up spellchecking
(add-hook 'org-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

;; Set up text width
(setopt fill-column 99)
(global-display-fill-column-indicator-mode)

                                        ; PACKAGE SETUP
;; Set up straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Set up use-package
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

                                        ; PACKAGES
;; company
(use-package company
  :commands company-mode
  :hook (prog-mode . company-mode))

;; dashboard
(use-package dashboard
  :config (dashboard-setup-startup-hook)
  :custom (dashboard-items '((recents  . 5)
                             (projects . 5)
                             (agenda   . 5)))
  :custom (dashboard-startup-banner 'logo))

;; elcord
(use-package elcord
  :config (elcord-mode))

;; evil
(use-package evil
  :config (evil-mode 1))

;; flexoki-themes
(use-package flexoki-themes
  :config (load-theme 'flexoki-themes-dark t)
  :custom (flexoki-themes-use-bold-builtins t)
  :custom (flexoki-themes-use-bold-keywords t))

;; flycheck
(use-package flycheck
  :hook (prog-mode . flycheck-mode))

;; git-gutter
(use-package git-gutter
  :hook (prog-mode . git-gutter-mode))

;; ligature
(use-package ligature
  :commands ligature-mode
  :config (ligature-set-ligatures 'prog-mode '("!=" "!==" "!===" "(*" "*)" "*+" "*/" "*=" "+*" "++"
                                               "+++" "--->" "-->" "-<" "-<-" "-<<" "->" "->-" "->>"
                                               "-|" ".>" "/*" "/=" "/>" "/\\" "::" ":::" ":=" ":>"
                                               "<!--" "<!---" "<*" "<*>" "<-" "<--" "<---" "<---->"
                                               "<--->" "<-->" "<->" "<." "<.>" "</" "</>" "<:"
                                               "<<-" "<<=" "<=" "<==" "<===" "<====>" "<===>"
                                               "<==>" "<=>" "<>" "<|" "<|>" "<~~" "=!=" "=*" "=/="
                                               "=:" "=<" "=<<" "=<=" "==" "===" "===>" "==>" "=>"
                                               "=>=" "=>>" ">-" ">=" ">>-" ">>=" "[|" "\\/" "__"
                                               "{|" "|-" "|>" "|]" "|}" "~=" "~~>" )) ; Iosevka
  :hook (prog-mode . ligature-mode))

;; projectile
(use-package projectile
  :custom (projectile-indexing-method 'alien)
  :init (projectile-mode +1))

                                        ; LANGUAGES
;; LSP
(use-package lsp-mode
  :commands lsp
  :hook ((python-mode ; python-lsp-server
          ) . lsp))

;; Tree-sitter
;;; Define tree-sitter languages
(setq major-mode-remap-alist '((python-mode     . python-ts-mode)
                               (typescript-mode . typescript-ts-mode)
                               ))

;; Emacs Lisp
;;; Disable certain modes
(defun disable-prog-modes ()
  "Disable modes commonly linked to `prog-mode`."
  (flycheck-mode -1))
(add-hook 'emacs-lisp-mode-hook #'disable-prog-modes)
