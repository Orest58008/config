;; Fonts
(add-to-list 'default-frame-alist
             ; '(font . "monospace-11")
			 '(font . "Maple Mono-11")
			 '(font . "CaskaydiaCove Nerd Font-11"))
;;; ENVVARS
(setenv "XDG_CONFIG_HOME" (concat (getenv "HOME") "/.config"))
(setenv "XDG_DATA_HOME" (concat (getenv "HOME") "/.local/share"))
(setenv "XDG_BIN_HOME" (concat (getenv "HOME") "/.local/bin"))
(setenv "PATH" (concat (getenv "PATH") path-separator (getenv "XDG_BIN_HOME")))
(add-to-list 'exec-path (getenv "XDG_BIN_HOME")) ;

;;; PACKAGE MANAGEMENT SETUP
(require 'package)

;; Package list
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

;; Bootstrap use-package
(package-initialize)
(setq use-package-always-ensure t)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))

;;; EXTENSIONS
;; Dashboard
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

(setq dashboard-items '((recents . 20)
						(projects . 8)))
(setq dashboard-startup-banner 'logo)

;; Flexoki theme
(use-package flexoki-themes
  :demand t
  :init (load-theme 'flexoki-themes-dark t))

;; Nyanmacs
(use-package nyan-mode
  :config
  (nyan-mode)
  (nyan-start-animation))

;; vterm
(use-package vterm
  :defer t)

;; TO​DO highlighting
(use-package hl-todo
  :hook (org-mode . hl-todo-mode)
  :hook (prog-mode . hl-todo-mode))

;; Projectile
(use-package projectile
  :defer t
  :hook (prog-mode . projectile-mode)
  :config
  (projectile-update-project-type 'go
								  :run "go run .")
  (projectile-update-project-type 'make
								  :compile "make compile"
								  :run "make run"
								  :test "make test")
  (projectile-update-project-type 'ocaml-dune
								  :run "dune exec")
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
  (projectile-register-project-type 'deno "deno.json"
									:project-file "deno.json"
									:run "deno run main.ts")
  (projectile-update-project-type 'dub :precedence 'high))

;; Company
(use-package company
  :hook (prog-mode . company-mode))
(use-package company-shell
  :after (company)
  :config (add-to-list 'company-backends '(company-shell
										   company-shell-env
										   company-fish-shell)))

;; Spell checking
(setq ispell-program-name "hunspell")

;; Syntax highlighting
(use-package tree-sitter
  :hook (prog-mode . tree-sitter-mode)
  :hook (tree-sitter-after-on . tree-sitter-hl-mode))
(use-package tree-sitter-langs)


;; Language support
(use-package d-mode :disabled)

(use-package go-mode :disabled)
(setenv "GOPATH" (concat (getenv "XDG_DATA_HOME") "/go"))
(setenv "PATH" (concat (getenv "PATH") path-separator (getenv "GOPATH") "/bin"))
(add-to-list 'exec-path (concat (getenv "GOPATH") "/bin"))

(use-package haskell-mode :disabled)
(use-package lsp-haskell :disabled)
(setenv "CABAL_DIR" (concat (getenv "XDG_DATA_HOME") "/cabal"))
(setenv "CABAL_CONFIG" (concat (getenv "XDG_CONFIG_HOME") "/cabal/config"))

(use-package lox-mode)

(use-package nim-mode :disabled)
(setenv "NIMBLE_DIR" (concat (getenv "XDG_DATA_HOME") "/nimble"))
(setenv "PATH" (concat (getenv "PATH") path-separator (getenv "NIMBLE_DIR") "/bin"))
(add-to-list 'exec-path (concat (getenv "NIMBLE_DIR") "/bin"))

(use-package rust-mode :disabled)
(setenv "CARGO_HOME" (concat (getenv "XDG_DATA_HOME") "/cargo"))
(setenv "PATH" (concat (getenv "PATH") path-separator (getenv "CARGO_HOME") "/bin"))
(add-to-list 'exec-path (concat (getenv "CARGO_HOME") "/bin"))

(use-package tuareg)
(setenv "OPAMROOT" (concat (getenv "XDG_DATA_HOME") "/opam"))
(setenv "PATH" (concat (getenv "PATH") path-separator (getenv "OPAMROOT") "/default/bin"))
(add-to-list 'exec-path (concat (getenv "OPAMROOT") "/default/bin"))
(add-to-list 'auto-mode-alist '("dune-project" . lisp-mode))
(let ((opam-share (ignore-errors (car (process-lines "opam" "var" "share"))))) ;; Merlin support
  (when (and opam-share (file-directory-p opam-share))
	(add-to-list 'load-path (expand-file-name "emacs/site-lisp" opam-share)) ;; Register Merlin
	(autoload 'merlin-mode "merlin" nil t nil)
	(add-hook 'tuareg-mode-hook 'merlin-mode t) ;; Automatically start it in OCaml buffers
	(add-hook 'caml-mode-hook 'merlin-mode t)
	(setq merlin-command 'opam))) ;; Use opam switch to lookup ocamlmerlin binary

(use-package typescript-mode)

(use-package zig-mode :disabled)

(use-package org-tree-slide :disabled)

(use-package org-modern
  :defer t
  :hook (org-mode . org-modern-mode))

;; LSP
(use-package lsp-mode
  :defer t
  :hook (c-mode . lsp)
  :hook (d-mode . lsp)
  :hook (go-mode . lsp)
  :hook (haskell-mode . lsp)
  :hook (java-mode . lsp)
  :hook (nim-mode . lsp)
  :hook (rust-mode . lsp)
  :hook (tuareg-mode . lsp)
  :hook (typescript-mode . lsp)
  :hook (zig-mode . lsp))

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
  ; (evil-define-key 'normal 'global (kbd "C-t")   'treemacs)
  (evil-define-key 'normal 'global (kbd "M-c")   'projectile-compile-project)
  (evil-define-key 'normal 'global (kbd "M-r")   'projectile-run-project)
  (evil-define-key 'normal 'global (kbd "M-t")   'projectile-test-project)
  (evil-define-key 'normal 'global (kbd "M-/")   'projectile-repeat-last-command)
  )

;; langmap
(use-package reverse-im
  :ensure t
  :custom
  (reverse-im-input-methods '("ukrainian-computer"))
  :config
  (reverse-im-mode t))

;; Font ligatures
(use-package ligature
  :config
  (ligature-set-ligatures 't '("ff" "fi" "ffi"))
  (ligature-set-ligatures 't '("|||>" "<|||" "<==>" "<!--" "<!---->" "####" "~~>" "***" "||="
							   "||>" ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
							   "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<" "<~~"
							   "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->" "<--" "<-<"
							   "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<" "..." "+++" "/=="
							   "///" "_|_" "www" "&&" "^=" "~~" "~@" "~=" "~>" "~-" "**" "*>"
							   "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|" "[|" "]#" "::" ":*" ":+"
							   ":^" ":-" ":~" ":=" ":>" "::>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
							   ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:" "<$"
							   "<=" "<>" "<-" "<<" "<+" "</" "#{" "}#" "#[" "]#" "#:" "#=" "#!"
							   "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:" "?="
							   "?." "??" ";;" "/*" "/**" "/=" "/>" "//" "__" "~~" "(*" "*)"
							   "\\\\" "://" "}}" "{{" ">=" "<=" "[TODO)" "todo))" ))
  :hook (prog-mode . ligature-mode)
  :hook (conf-mode . ligature-mode))

;; Discord RPC
(use-package elcord)
(elcord-mode)


;;; INTERNAL CUSTOMIZATION
;; Looks
(tool-bar-mode -1)
(setq inhibit-startup-screen t)
(setq-default tab-width 4)

;; Modes
(add-hook 'org-mode-hook  'flyspell-mode)
(add-hook 'org-mode-hook  'visual-line-mode)
(add-hook 'prog-mode-hook 'electric-pair-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(global-display-line-numbers-mode)
(column-number-mode)

;;---------;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(## xterm-color vterm typescript-mode tuareg tree-sitter-langs rust-mode reverse-im org-modern nyan-mode lsp-mode lox-mode ligature json-snatcher hl-todo go-mode flexoki-themes evil elcord dashboard d-mode company-shell)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
