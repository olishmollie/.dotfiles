(require 'package)
(setq package-archives '(("melpa" . "http://melpa.org/packages/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")
			 ("gnu" . "http://elpa.gnu.org/packages/")))

(defun asm-mode-init ()
  "Initialize asm mode."
  (setq tab-width 4)
  (setq indent-line-function 'insert-tab)
  (setq asm-indent-level 4))

(defun c-mode-init ()
  "Initialize cc mode."
  (local-set-key (kbd "C-c C-f") 'clang-format-buffer)
  (setq c-default-style "k&r")
  (setq c-basic-offset 4))

(defun go-mode-init ()
  "Initialize go mode."
  (setq tab-width 4)
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook #'gofmt-before-save))

(defun python-mode-init ()
  "Initialize python mode."
  (setq tab-width 4)
  (setq elpy-rpc-python-command "python3")
  (add-hook 'before-save-hook #'elpy-black-fix-code))

(defun tex-mode-init ()
  "Initialize tex mode."
  (setq tab-width 2))

(defun verilog-mode-init ()
  "Initialize verilog mode."
  (setq verilog-auto-newline nil)
  (setq verilog-tab-always-indent nil))

(defun vterm-mode-init ()
  (display-line-numbers-mode 0))

;; Add mode hooks
(add-hook 'c-mode-common-hook #'c-mode-init)
(add-hook 'asm-mode-hook #'asm-mode-init)
(add-hook 'vterm-mode-hook #'vterm-mode-init)
(add-hook 'before-save-hook #'delete-trailing-whitespace)
(add-hook 'after-init-hook #'global-company-mode)
(add-hook 'verilog-mode-hook #'verilog-mode-init)

;; Disable *Messages* buffer on startup
(setq-default message-log-max nil)
(kill-buffer "*Messages*")

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/emacs-libvterm")
(require 'vterm)

(eval-when-compile
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))
  (require 'use-package)
  (setq use-package-always-ensure t))

(use-package auctex
  :hook
  (tex-mode-hook . tex-mode-init)
  :defer t)

(use-package clang-format)

(use-package company
  :bind (:map company-active-map
              ("C-n" . company-select-next-or-abort)
              ("C-p" . company-select-previous-or-abort)))

(use-package elpy
  :hook
  (elpy-mode-hook . python-mode-init)
  :init
  (use-package py-autopep8)
  (elpy-enable))

(use-package evil
  :init
  (evil-mode t)
  (evil-set-initial-state 'vterm-mode 'emacs)
  (use-package evil-magit)
  (use-package evil-commentary
    :init (evil-commentary-mode t)))

(use-package exec-path-from-shell
  :init (exec-path-from-shell-initialize))

(use-package flycheck
  :init
  (global-flycheck-mode)
  (setq flycheck-python-pycompile-executable "python3"))

(use-package go-mode
  :hook
  (go-mode-hook . go-mode-init))

(use-package magit
  :bind ("C-x g" . magit-status))

(use-package monokai-theme
  :init (load-theme 'monokai t))

(use-package shell-pop)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-revert-use-notify nil)
 '(electric-pair-mode t)
 '(global-auto-revert-mode t)
 '(global-display-line-numbers-mode t)
 '(indent-tabs-mode nil)
 '(make-backup-files nil)
 '(menu-bar-mode nil)
 '(package-selected-packages
   (quote
    (py-autopep8 elpy company rust-mode monokai-theme exec-path-from-shell auctex clang-format evil evil-magit evil-commentary flycheck go-mode use-package shell-pop magit)))
 '(ring-bell-function (quote ignore))
 '(safe-local-variable-values (quote ((flycheck-gcc-language-standard . c++11))))
 '(shell-pop-shell-type
   (quote
    ("vterm" "*vterm*"
     (lambda nil
       (vterm shell-pop-term-shell)))))
 '(shell-pop-universal-key "M-'")
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
