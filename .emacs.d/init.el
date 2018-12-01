;; init.el --- Emacs Configuration

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("b9e9ba5aeedcc5ba8be99f1cc9301f6679912910ff92fdf7980929c2fc83ab4d" default)))
 '(package-selected-packages
   (quote
    (monokai-theme sml-mode smart-mode-line-powerline-theme material-theme magit evil-commentary dracula-theme blacken better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; INSTALL PACKAGES
;; ------------------------------

(require 'package)

(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar package-list
  '(better-defaults
    evil
    evil-commentary
    magit
    org
    blacken
    sml-mode
    powerline
    monokai-theme))

(dolist (p package-list)
  (when (not (package-installed-p p))
    (package-install p)))


;; BASIC CUSTOMIZATION
;; ------------------------------

;; disable the startup screen
(setq inhibit-startup-message t)

;; disable tool bar
(tool-bar-mode -1)

;; disable menu bar
(menu-bar-mode -1)

;; enable line numbers globally
(global-linum-mode t)

;; enable visual line mode
(global-visual-line-mode t)

;; delete trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; set theme
(load-theme 'monokai t)


;; EVIL CONFIGURATION
;; -----------------------------

;; enable evil mode
(evil-mode t)

;; enable evil-commentary
(evil-commentary-mode t)


;; POWERLINE CONFIGURATION
;; ------------------------------

(require 'powerline)
(powerline-center-evil-theme)


;; PYTHON CONFIGURATION
;; ------------------------------

;; enable format on save
(add-hook 'python-mode-hook 'blacken-mode)


;; SML CONFIGURATION
;; ------------------------------

(defun my-sml-mode-hook ()
    "Local defaults for sml mode"
    ;; fix indentation problems
    (setq electric-indent-chars '()))

(add-hook 'sml-mode-hook 'my-sml-mode-hook)
