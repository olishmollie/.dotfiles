;; Global customizations
(tool-bar-mode -1)
(global-visual-line-mode t)
(global-set-key (kbd "C-c o") 'occur)
(add-hook 'occur-hook
          '(lambda ()
             (switch-to-buffer-other-window "*Occur*")))

;; Settings
(setq visible-bell t)
(setq c-basic-offset 4)

;; Package.el
(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(setq package-enable-at-startup nil)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; Sublimity
(use-package sublimity
  :ensure t
  :config
  (require 'sublimity-scroll)
  (require 'sublimity-attractive)
  (sublimity-mode))

;; Flycheck
(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode))

;; Org
(use-package org
  :ensure t
  :config
  (define-key global-map "\C-cl" 'org-store-link)
  (define-key global-map "\C-ca" 'org-agenda)
  (setq org-log-done t)
  (setq org-agenda-files (list "~/org/School/"
			       "~/org/Home/"
			       "~/org/Work/")))

;; Helm
(use-package helm
  :ensure t
  :config
  (helm-mode t)
  (global-set-key (kbd "M-x") 'helm-M-x)
  (define-key helm-find-files-map "\t" 'helm-execute-persistent-action))

;; Auto-complete
(use-package auto-complete
  :ensure t
  :config
  (ac-config-default))

;; Projectile
(use-package projectile
  :ensure t
  :config
  (projectile-mode t))

;; Magit
(use-package magit
  :ensure t
  :config
  (global-set-key (kbd "C-x g") 'magit-status)
  (global-set-key (kbd "C-x M-g") 'magit-dispatch-popup))

;; Evil
(use-package evil
  :ensure t
  :config
  (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
  (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
  (define-key evil-ex-map "b " 'helm-mini)
  (define-key evil-ex-map "e " 'helm-find-files)
  (define-key helm-map (kbd "C-j") 'helm-next-line)
  (define-key helm-map (kbd "C-k") 'helm-previous-line)
  (define-key helm-map (kbd "C-h") 'helm-next-source)
  (define-key helm-map [escape] 'helm-keyboard-quit)

  (use-package evil-leader
    :ensure t
    :config
    (global-evil-leader-mode)
    (evil-leader/set-key
      "g" 'magit-status))

  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode))

  (use-package evil-magit
    :ensure t)

  (evil-add-hjkl-bindings occur-mode-map 'emacs
    (kbd "/")       'evil-search-forward
    (kbd "n")       'evil-search-next
    (kbd "N")       'evil-search-previous
    (kbd "C-d")     'evil-scroll-down
    (kbd "C-u")     'evil-scroll-up
    (kbd "C-w C-w") 'other-window)

  (evil-add-hjkl-bindings package-menu-mode-map 'emacs)
  (evil-mode t))

;; Themes
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :config
  (load-theme 'sanityinc-tomorrow-eighties t))
