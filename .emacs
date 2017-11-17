;; Global customizations
(tool-bar-mode -1)
(setq visible-bell t)
(global-visual-line-mode t)


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


;; Org
(use-package org
  :ensure t
  :config
  (define-key global-map "\C-cl" 'org-store-link)
  (define-key global-map "\C-ca" 'org-agenda)
  (setq org-log-done t)
  (setq org-agenda-files (list (file-expand-wildcards "~/org/School/*.org")
				(file-expand-wildcards "~/org/Work/*.org")
				(file-expand-wildcards "~/org/Home/*.org"))))

;; Helm
(use-package helm
  :ensure t
  :config
  (require 'helm-config)
  (global-set-key (kbd "M-x") 'helm-M-x)
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (global-set-key (kbd "C-x C-b") 'helm-buffers-list)
  (helm-mode t))


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
  (global-set-key (kbd "C-x M-g" 'magit-dispatch-popup)))


;; Evil
(use-package evil
  :ensure t
  :config
  (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
  (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)

  (use-package evil-leader
    :ensure t
    :config
    (global-evil-leader-mode)
    (evil-leader/set-key
      "b" 'switch-to-buffer
      "f" 'helm-find-files
      "x" 'helm-M-x
      "t" 'org-insert-todo-heading
      "g" 'magit-status))

  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode))

  (evil-mode t))


;; Themes
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :config
  (load-theme 'sanityinc-tomorrow-eighties t))

(use-package smart-mode-line
  :ensure t
  :config
  (sml/setup t)
  (setq sml/theme 'dark))
