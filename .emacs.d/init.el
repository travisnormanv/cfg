(require 'package)
(setq package-enable-at-startup nil)
;; MELPA package repository
(add-to-list 'package-archives
	                  '("melpa-stable" . "https://stable.melpa.org/packages/") t)


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; no initial message at startup
(setq inhibit-startup-message t)

;; disable toolbar
(tool-bar-mode -1)

;; disable menubar
(menu-bar-mode -1)

;; backup setup (versioning)
(setq
 backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.saves/"))    ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)       ; use versioned backups

;; global set up
(require 'green-is-the-new-black-theme)
(global-set-key (kbd "C-c C-c") 'comment-line)
(setq-default tab-width 4)
(setq-default display-line-numbers 'relative)
(global-set-key (kbd "C-x d") 'dired-jump)
(global-company-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
	(projectile green-phosphor aggressive-indent yasnippet ya-snippet ace-window transpose-frame evil-org company tide web-mode ibus key-chord evil xresources-theme which-key-posframe lorem-ipsum helm-config popup async emacs-async which-key try base16-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0)))))

;; installed packages ==========

;; try packages without installing
(use-package try
  :ensure t)

;; display available keys combinations, during command entering
(use-package which-key
  :ensure t
  :config (which-key-mode))

;; display available keys combinations, during command entering
(use-package which-key
  :ensure t
  :config (which-key-mode))

;; aggresive-indents
(use-package aggressive-indent
  :ensure t
  :config
  (global-aggressive-indent-mode 1))

;; transpose-frame
(use-package transpose-frame
  :load-path "~/.emacs.d/elpa/git-packages/transpose-frame/")

(use-package ace-window
  :ensure t
  :init
  (progn
	(global-set-key [remap other-window] 'ace-window)
	(custom-set-faces
	 '(aw-leading-char-face
	   ((t (:inherit ace-jump-face-foreground :height 3.0))))
	)))

(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1)
  :config
  (setq yas-snippet-dirs
		'("~/.emacs.d/snippets"))
  (yas-reload-all)
  (add-hook 'js-mode-hook 'yas-minor-mode))

;; emacs-async, heml dependency
(use-package async
  :ensure t
  :config
  (autoload 'dired-async-mode "dired-async.el" nil t)
  (dired-async-mode 1))

;; popup.el, helm dependency
(use-package popup
  :ensure t)

;; helm
(use-package helm
  :load-path "~/.emacs.d/elpa/git-packages/helm/" 
  :init
  (require 'helm-config)
  :bind (("M-x" . helm-M-x)
	 ("C-x b" . helm-buffers-list)
	 ("C-x C-b" . helm-bookmarks)
	 ("C-x C-f" . helm-find-files)))
	
;; helm-swoop
(use-package helm-swoop
  :load-path "~/.emacs.d/elpa/git-packages/helm-swoop/")
 
;; keychord (needed to bind "jj" for evil mode)
(use-package key-chord
  :ensure t)

;; web mode
(use-package web-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (setq web-mode-engines-alist '(("django" . "\\.html\\'")))
  (setq web-mode-ac-sources-alist '(("css" . (ac-source-css-property))
									("html" . (ac-source-words-in-buffer ac-source-abbrev)))))

;; flycheck
(use-package flycheck
  :ensure t)

;; company
(use-package company
  :ensure t
  :config
  (setq company-show-numbers t))


;; tide (javascript intellisense)
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

(use-package tide
  :ensure t
  :config
  (setq company-tooltip-align-annotations t)
  (add-hook 'before-save-hook 'tide-format-before-save)
  ;;    (add-hook 'js2-mode-hook #'setup-tide-mode)
  (add-hook 'js-mode-hook #'setup-tide-mode)
  (add-hook 'typescript-mode-hook #'setup-tide-mode))

;; evil mode (to have vim commands)
(use-package evil
  :ensure t
  :config
  (setq key-chord-two-keys-delay 0.5)
  (key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
  (key-chord-mode 1)
  (define-key evil-normal-state-map (kbd "o")
	(lambda() (interactive) (evil-insert-newline-below)))
  (define-key evil-normal-state-map (kbd "O")
	(lambda() (interactive) (evil-insert-newline-above)))
  (define-key evil-normal-state-map (kbd "/")
	(lambda() (interactive) (helm-swoop-from-evil-search)))
  (define-key evil-normal-state-map (kbd "TAB") 'tab-to-tab-stop)
  (setq evil-shift-width 2)
  (evil-mode 1))

(use-package evil-org
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package projectile
  :ensure t
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (setq projectile-completion-system 'helm))
