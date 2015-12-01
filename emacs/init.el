;; Andrea Crotti(@andreacrotti) config:
;; https://www.youtube.com/watch?v=0cZ7szFuz18
;; Requisites: Emacs >= 24
(require 'package)
(package-initialize)

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)

;; Enable when needed to update
;; (package-refresh-contents)
(defun update-packages () ;; TODO
  (interactive)
  (package-refresh-contents)
  (list-packages)
  (package-menu-mark-upgrades)
  (package-menu-execute))

(defun install-if-needed (package)
  (unless (package-installed-p package)
    (package-install package)))

;; make more packages available with the package installer
(setq to-install
      '(python-mode magit yasnippet jedi auto-complete autopair find-file-in-repository flycheck haskell-mode))

(mapc 'install-if-needed to-install)

(require 'magit)
(global-set-key "\C-xg" 'magit-status)

(require 'auto-complete)
(require 'autopair)
(require 'yasnippet)
(require 'flycheck)
(global-flycheck-mode t)

(global-set-key [f7] 'find-file-in-repository)

; auto-complete mode extra settings
(setq
 ac-auto-start 2
 ac-override-local-map nil
 ac-use-menu-map t
 ac-candidate-limit 20)

;; ;; Python mode settings
(require 'python-mode)
(add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
(setq py-electric-colon-active t)
(add-hook 'python-mode-hook 'autopair-mode)
(add-hook 'python-mode-hook 'yas-minor-mode)
(add-hook 'python-mode-hook
  (lambda ()
    (linum-mode 1)))

;; ;; Jedi settings
(require 'jedi)
;; It's also required to run "pip install --user jedi" and "pip
;; install --user epc" to get the Python side of the library work
;; correctly.
;; With the same interpreter you're using.

;; if you need to change your python intepreter, if you want to change it
(setq jedi:server-command
      '("python3" "/home/andrea/.emacs.d/elpa/jedi-0.1.2/jediepcserver.py"))

(jedi:install-server)

(add-hook 'python-mode-hook
	  (lambda ()
	    ;;	    (jedi:install-server)
	    (rainbow-delimiters-mode)
	    (fci-mode)
	    (jedi:setup)
	    (jedi:ac-setup)
            (local-set-key "\C-cd" 'jedi:show-doc)
            (local-set-key (kbd "M-SPC") 'jedi:complete)
            (local-set-key (kbd "M-.") 'jedi:goto-definition)))


(add-hook 'python-mode-hook 'auto-complete-mode)

(ido-mode t)

;; -------------------- extra nice things --------------------
;; use shift to move around windows
(windmove-default-keybindings 'shift)
(show-paren-mode t)
 ; Turn beep off
(setq visible-bell t)

;; My config
;; Using CDLaTeX to enter math in orgmode
(add-hook 'org-mode-hook 'turn-on-org-cdlatex)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((dot . t)
   (ditaa . t))) ; this line activates dot

(defun my-org-confirm-babel-evaluate (lang body)
            (not (string= lang "ditaa")))  ; don't ask for ditaa
          (setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)


(require 'rainbow-delimiters)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(global-linum-mode t)
(column-number-mode t)

(setq backup-directory-alist '(("." . "~/emacs-backups"))); Put all backup files on this folder

;; Add a line to indicate column "limits"
(require 'fill-column-indicator)

;; Dark color theme
(require 'color-theme)
(color-theme-initialize)
(load-theme 'tangotango t)

;; Antlr
(add-hook 'antlr-mode-hook (lambda ()
			     (rainbow-delimiters-mode)
			     (yas-minor-mode)))

;; yasnippet collections
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"                 ;; personal snippets
	))

(yas-global-mode 1) ;; or M-x yas-reload-all if you've started YASnippet already.

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("5999e12c8070b9090a2a1bbcd02ec28906e150bb2cdce5ace4f965c76cf30476" "603a9c7f3ca3253cb68584cb26c408afcf4e674d7db86badcfe649dd3c538656" "40bc0ac47a9bd5b8db7304f8ef628d71e2798135935eb450483db0dbbfff8b11" "b2d6d3519462edc6373c02ea7c871fa7653f84e5dd6dba582b116ddf2c8c9af1" "3ed645b3c08080a43a2a15e5768b893c27f6a02ca3282576e3bc09f3d9fa3aaa" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "0820d191ae80dcadc1802b3499f84c07a09803f2cb90b343678bdb03d225b26b" "94ba29363bfb7e06105f68d72b268f85981f7fba2ddef89331660033101eb5e5" default)))
 '(doc-view-pdf->png-converter-function (quote doc-view-pdf->png-converter-mupdf))
 '(fci-rule-use-dashes t)
 '(fill-column 80)
 '(flycheck-python-pylint-executable "pylint3")
 '(haskell-compile-ghc-filter-linker-messages nil)
 '(haskell-font-lock-symbols t)
 '(haskell-interactive-popup-errors nil)
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(max-specpdl-size 2000)
 '(py-pylint-command "pylint3")
 '(py-pylint-command-args "--errors-only --unsafe-load-any-extension=y")
 '(py-shell-name "ipython3")
 '(pylint-command "pylint3")
 '(quote (desktop-save-mode nil))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Hack" :foundry "unknown" :slant normal :weight normal :height 113 :width normal))))
 '(org-link ((t (:background "#2e3436" :foreground "skyblue2" :underline "deep sky blue"))))
 '(rainbow-blocks-depth-1-face ((t (:foreground "white"))))
 '(rainbow-blocks-depth-2-face ((t (:foreground "orange"))))
 '(rainbow-blocks-depth-3-face ((t (:foreground "darkcyan"))))
 '(rainbow-blocks-depth-4-face ((t (:foreground "purple"))))
 '(rainbow-blocks-depth-5-face ((t (:foreground "yellow"))))
 '(rainbow-blocks-depth-6-face ((t (:foreground "brown"))))
 '(rainbow-blocks-depth-7-face ((t (:foreground "darkgreen"))))
 '(rainbow-blocks-depth-8-face ((t (:foreground "blue"))))
 '(rainbow-blocks-depth-9-face ((t (:foreground "red"))))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "white"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "orange"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "darkcyan"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "purple"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "yellow"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "brown"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "darkgreen"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "blue"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "red"))))
 '(underline ((t (:underline t)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Haskell                                                                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'haskell-interactive-mode)
(require 'haskell-process)

(add-hook 'haskell-mode-hook (lambda ()
			       (rainbow-delimiters-mode)
			       (interactive-haskell-mode)
			       (turn-on-haskell-indentation)
			       ;; (inf-haskell-mode)
			       (setq haskell-program-name "ghci")
			       (fci-mode)
			       ))
(eval-after-load "haskell-mode"
  '(progn
     (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
     (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-file)
     (define-key haskell-mode-map (kbd "C-c C-b") 'haskell-interactive-switch)
     (define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
     (define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
     (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
     (define-key haskell-mode-map (kbd "C-`") 'haskell-interactive-bring)
     (define-key haskell-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
     (define-key haskell-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
     (define-key haskell-mode-map (kbd "C-c c") 'haskell-process-cabal)
     (define-key haskell-mode-map (kbd "SPC") 'haskell-mode-contextual-space)
     (define-key haskell-mode-map (kbd "M-.") 'haskell-mode-jump-to-def)
     (define-key haskell-cabal-mode-map (kbd "C-`") 'haskell-interactive-bring)
     (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
     (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
     (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)))
