
;; Redirect the custom-set-variables to custom.el
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file t)

;;#########################
;;                        #
;;    Visual clean-up     #
;;                        #
;;#########################

(setq inhibit-startup-message t) ;  No startup message. Thanks but no thanks.

(scroll-bar-mode -1) ; Disable scrollbar
(tool-bar-mode -1)   ; Disable toolbar
(tooltip-mode -1)    ; Disable tooltip
(set-fringe-mode 10) ; Give some space
(menu-bar-mode -1)   ; Disable the menu bar

;; Typo
(set-face-attribute 'default nil :font "Fira Code Retina" :height 100) ; /!\ Needs to be installed on the computer FIRST

;; enable line highlight, line number and column number
(global-hl-line-mode t)                ; Enable line number at the left
(global-display-line-numbers-mode t)   ; Enable display of line number (at the bottom)
(column-number-mode t)                 ; Enable column number  (at the bottom)

;; Disable line mode for some modes
(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))


;;#########################
;;                        #
;;    PACKAGE MANAGING    #
;;                        #
;;#########################

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")
			 ("org" . "htps://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package command-log-mode) ;; shows what I press (basically)

;; Ivy set-up
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done) 
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

;; Ivy-rich
(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

;; Ivy-enhanced version of common Emacs commands
;; It is simply a kind of better default
(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))

;; Use helpful to get a better help mode in Emacs
;; Kind of better default help mode
(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 40)))

(use-package doom-themes
  :init (load-theme 'doom-dracula t))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Shows all keybindings with 1 second delay
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

;; First time this is loaded on a new machine, needs to run :
;; M-x all-the-icons-install-fonts
(use-package all-the-icons)

;; Benchmark Emacs start-up time :)
(unless (package-installed-p 'esup)
    (package-refresh-contents)
    (package-install 'esup))


;;#########################
;;                        #
;;    KEYBINDING SETUP    #
;;                        #
;;#########################

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Using general-define-key for a better (and cleaner) rebind
(use-package general)

(general-define-key
 "C-x p" 'counsel-switch-buffer    ; Make C-x p use the counsel-switch-buffer
 "C-s" 'counsel-grep-or-swiper)



;;#########################
;;                        #
;;     EVIL-MODE SETUP    #
;;                        #
;;#########################

;; So evil is cool :
;; It introduces the "states" idea from VIM.
;; I just need to figure out how to keep Emacs binding
;; to make Evil-mode act like it only import the states
;; from VIM and not all the VIM keybinding.


;;#########################
;;                        #
;;    IDE/CODE SETUP      #
;;                        #
;;#########################

;; Python set-up with elpy
;; Not yet finished
(use-package elpy
  :ensure t
  :init
  (elpy-enable))

;; Ocaml
"emacs-tuareg"