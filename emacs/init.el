; NATIVE SETTINGS
;; font
(set-frame-font "monospace 13" nil t)
;; hooks
(add-hook 'prog-mode-hook 'electric-pair-mode)
; (add-hook 'prog-mode-hook 'flyspell-prog-mode)
;; numbers
(global-display-line-numbers-mode)
(column-number-mode)
;; tool-bar
(tool-bar-mode -1)

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
  :config (evil-mode 1))

;; flexoki-themes
(use-package flexoki-themes
  :config (load-theme 'flexoki-themes-dark t))

;; hl-todo
(use-package hl-todo
  :hook (org-mode . hl-todo-mode)
  :hook (prog-mode . hl-todo-mode))

;; ligature
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

;; page-break-lines
(use-package page-break-lines
  :config (global-page-break-lines-mode))
