(require 'package)
(setq package-archives '(("melpa" . "http://melpa.org/packages/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")
			 ("gnu" . "http://elpa.gnu.org/packages/")))

(defun c-mode-init ()
  "Initializes cc-mode."
  (setq c-default-style "k&r")
  (setq c-basic-offset 4))

(defun go-mode-init ()
  "Initializes go-mode."
  (setq tab-width 4)
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook #'gofmt-before-save))

(defun python-mode-init ()
  "Initialize python mode."
  (setq tab-width 4)
  (setq elpy-rpc-python-command "python3")
  (add-hook 'before-save-hook #'elpy-black-fix-code))

;; Basic config
(electric-pair-mode t)
(add-hook 'c-mode-common-hook #'c-mode-init)
(global-display-line-numbers-mode t)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(eval-when-compile
  (unless (package-installed-p 'use-package)
   (package-refresh-contents)
    (package-install 'use-package))
  (require 'use-package)
  (setq use-package-always-ensure t))


(use-package elpy
  :init
  (use-package py-autopep8)

  (elpy-enable)
  (add-hook 'elpy-mode-hook 'python-mode-init))

(use-package projectile
  :init (projectile-mode 1))

(use-package smart-tab
  :init (global-smart-tab-mode t))

(use-package shell-pop)

(use-package magit
  :init (global-set-key (kbd "C-x g") 'magit-status))

(use-package zenburn-theme
  :init (load-theme 'zenburn t))

(use-package flycheck
  :init
  (global-flycheck-mode)
  (setq flycheck-python-pycompile-executable "python3"))

(use-package go-mode
  :init (add-hook 'go-mode-hook #'go-mode-init))

(use-package evil
  :init
  (evil-mode t)
  (evil-set-initial-state 'term-mode 'emacs)
  
    (use-package evil-magit)
    (use-package evil-commentary
      :init (evil-commentary-mode t)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (elpy projectile smart-tab evil-magit evil-commentary zenburn-theme flycheck go-mode use-package shell-pop magit)))
 '(shell-pop-shell-type
   (quote
    ("ansi-term" "*ansi-term*"
     (lambda nil
       (ansi-term shell-pop-term-shell)))))
 '(shell-pop-universal-key "C-t"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

