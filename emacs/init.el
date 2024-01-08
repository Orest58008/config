;;; INTERNAL CUSTOMIZATION
;; Looks
(tool-bar-mode -1)
(set-frame-font "monospace 11" nil t)
(setq inhibit-startup-screen t)
(setq-default tab-width 4)

;; Modes
(add-hook 'org-mode-hook  'visual-line-mode)
(add-hook 'org-mode-hook  'display-line-numbers-mode)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'prog-mode-hook 'electric-pair-mode)

;; envvars
(setenv "XDG_CONFIG_HOME" (concat (getenv "HOME") "/.config"))
(setenv "XDG_DATA_HOME" (concat (getenv "HOME") "/.local/share"))

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
;; Dashboard
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

(setq dashboard-items '((recents . 12)
						(projects . 9)))
(setq dashboard-startup-banner 'logo)

;; treemacs
(use-package treemacs
  :hook
  (treemacs-mode . treemacs-project-follow-mode))
(use-package treemacs-evil
  :after (treemacs evil))
(use-package treemacs-projectile
  :after (treemacs projectile))

;; Flexoki theme
(use-package flexoki-themes
  :config (load-theme 'flexoki-themes-dark t))


;; Nyanmacs
(use-package nyan-mode
  :config
  (nyan-mode)
  (nyan-start-animation))

;; vterm
(use-package vterm
  :ensure t)

;; Magit
(use-package magit)

;; TO​DO highlighting
(use-package hl-todo
  :hook (org-mode . hl-todo-mode)
  :hook (prog-mode . hl-todo-mode))

;; Vim bindings
(use-package evil
  :demand
  :config
  (evil-mode 1)
  (evil-set-undo-system 'undo-redo)
  (evil-define-key 'insert 'global (kbd "C-S-v") 'yank)
  (evil-define-key 'normal 'global (kbd "C-o")   'find-file)
  (evil-define-key 'normal 'global (kbd "C-S-o") 'find-file-other-window)
  (evil-define-key 'normal 'global (kbd "C-v")   'vterm-other-window)
  (evil-define-key 'normal 'global (kbd "C-e")   'eval-buffer)
  (evil-define-key 'normal 'global (kbd "C-t")   'treemacs)
  (evil-define-key 'normal 'global (kbd "M-c")   'projectile-compile-project)
  (evil-define-key 'normal 'global (kbd "M-r")   'projectile-run-project)
  (evil-define-key 'normal 'global (kbd "M-t")   'projectile-test-project)
  (evil-define-key 'normal 'global (kbd "M-/")   'projectile-repeat-last-command)
  )

;; Font ligatures
(use-package ligature
  :config
  (ligature-set-ligatures 't '("ff" "fi" "ffi"))
  (ligature-set-ligatures 'prog-mode '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||="
									   "||>" ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<"
									   "=/=" "!==" "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>"
									   "-->" "---" "-<<" "<~~" "<~>" "<*>" "<||" "<|>" "<$>"
									   "<==" "<=>" "<=<" "<->" "<--" "<-<" "<<=" "<<-" "<<<"
									   "<+>" "</>" "###" "#_(" "..<" "..." "+++" "/==" "///"
									   "_|_" "www" "&&" "^=" "~~" "~@" "~=" "~>" "~-" "**" "*>"
									   "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|" "[|" "]#" "::"
									   ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:" ">=" ">>"
									   ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:" "<$"
									   "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
									   "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++"
									   "?:" "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~"
									   "(*" "*)" "\\\\" "://"))
  :hook (prog-mode . ligature-mode))
;; Projectile
(use-package projectile
  :hook (prog-mode . projectile-mode)
  :config
  (projectile-update-project-type 'go
								  :run "go run .")
  (projectile-update-project-type 'make
								  :compile "make compile"
								  :run "make run"
								  :test "make test")
  (projectile-register-project-type 'zig '("build.zig")
									:project-file "build.zig"
									:src-dir "src/"
									:compile "zig build src/main.zig"
									:run "zig run src/main.zig"
									:test "zig test src/main.zig")
  (projectile-register-project-type 'dub '("dub.json" "dub.sdl")
									:project-file '("dub.json" "dub.sdl")
									:src-dir '("src/" "source/")
									:compile "dub build"
									:run "dub run"
									:test "dub test")
  :custom
  (projectile-indexing-method 'alien))

;; Company
(use-package company
  :hook (prog-mode . company-mode))
(use-package company-shell
  :after (company)
  :config (add-to-list 'company-backends '(company-shell company-shell-env company-fish-shell)))

;; LSP
(use-package lsp-mode
  :hook (c-mode . lsp-mode)
  :hook (d-mode . lsp-mode)
  :hook (go-mode . lsp-mode)
  :hook (java-mode . lsp-mode)
  :hook (nim-mode . lsp-mode)
  :hook (rust-mode . lsp-mode)
  :hook (zig-mode . lsp-mode))

;; Language support
(setq ispell-program-name "hunspell")

(use-package reformatter)

(use-package d-mode)

(use-package go-mode)
(setenv "GOPATH" (concat (getenv "XDG_DATA_HOME") "/go"))
(setenv "PATH" (concat (getenv "PATH") path-separator (getenv "GOPATH") "/bin"))
(add-to-list 'exec-path (concat (getenv "GOPATH") "/bin"))

(use-package lsp-java)
(setenv "_JAVA_OPTIONS" (concat "-Djava.util.prefs.userRoot=" (getenv "XDG_CONFIG_HOME") "/java"))
(setenv "GRADLE_USER_HOME" (concat (getenv "XDG_DATA_HOME") "/gradle"))

(use-package nim-mode)
(setenv "NIMBLE_DIR" (concat (getenv "XDG_DATA_HOME") "/nimble"))
(setenv "PATH" (concat (getenv "PATH") path-separator (getenv "NIMBLE_DIR") "/bin"))
(add-to-list 'exec-path (concat (getenv "NIMBLE_DIR") "/bin"))

(use-package rust-mode)
(setenv "CARGO_HOME" (concat (getenv "XDG_DATA_HOME") "/cargo"))
(setenv "PATH" (concat (getenv "PATH") path-separator (getenv "CARGO_HOME") "/bin"))
(add-to-list 'exec-path (concat (getenv "CARGO_HOME") "/bin"))

(use-package zig-mode)

(use-package org-tree-slide)

(use-package org-modern
  :hook (org-mode . org-modern-mode))
