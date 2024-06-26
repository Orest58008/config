                                        ; NATIVE SETTINGS
;; tabs
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; disable annoying bars
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; fill column
(setopt fill-column 95)
(global-display-fill-column-indicator-mode)

;; font
(set-frame-font "monospace 13" nil t)

;; hooks
(add-hook 'prog-mode-hook 'electric-pair-mode)
(add-hook 'org-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

;; minimize garbage collection during startup
(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'emacs-startup-hook (lambda ()
				                (setq gc-cons-threshold (expt 2 32))))

;; numbers
(global-display-line-numbers-mode)
(column-number-mode)

                                        ; PACKAGE SETUP
;; straight.el
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

;;; enable straight-use-package
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

                                        ; PACKAGES
;; company
(use-package company
  :hook (prog-mode . company-mode))

;; dashboard
(use-package dashboard
  :config (dashboard-setup-startup-hook)
  :custom
  (dashboard-startup-banner 'logo)
  (dashboard-show-shortcuts t))

;; elcord
(use-package elcord
  :config (elcord-mode))

;; evil
(use-package evil
  :config (evil-mode 1)
  :custom (evil-undo-system 'undo-redo))

;; flexoki-themes
(use-package flexoki-themes
  :config (load-theme 'flexoki-themes-dark t))

;; hl-todo
(use-package hl-todo
  :hook ((org-mode prog-mode)
         . hl-todo-mode))

;; ligature
(use-package ligature
  :config
  (ligature-set-ligatures 't '("ff" "fi" "ffi"))
  (ligature-set-ligatures 't '("|||>" "<|||" "<==>" "<!--" "<!---->" "####" "~~>" "***" "||="
                               "||>" ":::" "::=" "=:=" "===" "==>" "=>>" "=<<" "=/=" "!=="
                               "=!=" "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---"
                               "-<<" "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<"
                               "<->" "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_("
                               "..<" "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@"
                               "~=" "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
                               "[|" "]#" "::" ":*" ":+" ":^" ":-" ":~" ":=" ":>" "::>" ":<"
                               "$>" "==" "=>" "!=" "!!" ">:" ">=" ">>" ">-" "-~" "-|" "->" "--"
                               "-<" "<~" "<*" "<|" "<:" "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{"
                               "}#" "#[" "]#" "#:" "#=" "#!" "##" "#(" "#?" "#_" "%%" ".=" ".-"
                               ".." ".?" "+>" "++" "?:" "?=" "?." "??" ";;" "/*" "/**" "/="
                               "/>" "//" "__" "~~" "(*" "*)" "\\\\" "://" "}}" "{{" ">=" "<="
                               "[TODO)" "todo))" ))
  :hook (conf-mode . ligature-mode)
  :hook (org-mode . ligature-mode)
  :hook (prog-mode . ligature-mode))

;; projectile
(use-package projectile
  :init (projectile-mode +1))

;; rainbow-mode
(use-package rainbow-mode)

										; LANGUAGES
;; LSP
(use-package lsp-mode
  :hook ((go-mode typescript-mode)
         . lsp-mode))

;; Go
(use-package go-mode)

;; sxhkd
(add-to-list 'auto-mode-alist '("sxhkdrc\\'" . conf-mode))

;; TypeScript
(use-package typescript-mode)
