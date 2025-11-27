;; -*- lexical-binding: t; -*-
;; based on github.com/valignatev/dotemacs/

(setq package-enable-at-startup nil)

(global-unset-key (kbd "C-x C-c"))
(global-unset-key (kbd "C-h h"))
(global-set-key (kbd "C-l") #'recenter-top-bottom)

(setq inhibit-startup-message t
      inhibit-startup-echo-area-message user-login-name
      inhibit-startup-screen t
      inhibit-default-init t
      use-dialog-box nil
      create-lockfiles nil
      ring-bell-function #'ignore
      confirm-kill-processes nil
      echo-keystrokes 0.5
      auto-window-vscroll nil
      scroll-conservatively 101
      mouse-wheel-progressive-speed nil
      mouse-wheel-scroll-amount '(3)
      frame-inhibit-implied-resize t
      pixel-scroll-precision-interpolate-page t
      pixel-scroll-precision-mode t
      dired-dwim-target t
      read-process-output-max (* 1024 1024)
      vc-follow-symlinks t
      require-final-newline t
      save-interprogram-paste-before-kill t
      warning-minimum-level :error
      gdb-many-windows t)

(setq-default indent-tabs-mode nil
              truncate-lines t
              truncate-partial-width-windows nil
              tab-width 2
              select-active-regions nil)

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(blink-cursor-mode 0)
(show-paren-mode t)
(column-number-mode 1)
(recentf-mode 1)
(winner-mode 1)
(global-auto-revert-mode t)
(pixel-scroll-precision-mode t)
(global-hl-line-mode t)

(defalias 'yes-or-no-p #'y-or-n-p)
(advice-add #'display-startup-echo-area-message :override #'ignore)

(defun my/get-monitor-dpi () 96)

(defvar font-name "Source Code Pro")
(defvar font-size
  (let ((dpi (my/get-monitor-dpi)))
    (cond ((> dpi 180) 18)
          ((> dpi 130) 16)
          (t 14))))

(add-to-list 'default-frame-alist `(font . ,(format "%s-%d" font-name font-size)))

(when (display-graphic-p)
  (set-frame-font (format "%s-%d" font-name font-size) nil t))

(defun my/disable-bold-and-italic (theme &optional _no-confirm _no-enable)
  (mapc #'disable-theme (remq theme custom-enabled-themes))
  (when (fboundp 'set-face-italic) (set-face-italic 'italic nil))
  (when (fboundp 'set-face-bold)   (set-face-bold 'bold nil)))
(advice-add 'load-theme :after #'my/disable-bold-and-italic)

(defvar elpaca-installer-version 0.11)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1 :inherit ignore
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (<= emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let* ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                  ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                  ,@(when-let* ((depth (plist-get order :depth)))
                                                      (list (format "--depth=%d" depth) "--no-single-branch"))
                                                  ,(plist-get order :repo) ,repo))))
                  ((zerop (call-process "git" nil buffer t "checkout"
                                        (or (plist-get order :ref) "--"))))
                  (emacs (concat invocation-directory invocation-name))
                  ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                        "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                  ((require 'elpaca))
                  ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (let ((load-source-file-function nil)) (load "./elpaca-autoloads"))))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

(elpaca bind-key)
(elpaca use-package :demand t)
(setq use-package-hook-name-suffix nil)
(elpaca elpaca-use-package
  (elpaca-use-package-mode)
  (setq elpaca-use-package-by-default t))
(elpaca-wait)

(use-package no-littering
  :config
  (require 'no-littering)
  (savehist-mode))

(use-package ef-themes
  :init
  (setq ef-dream-palette-overrides
        '((bg-main      "#131015")
          (bg-hl-line   "#232224")
          (fg-mode-line "#f2ddcf")
          (bg-mode-line "#472b00")
          (yellow-cooler "#ff9f0a")))
  :config
  (load-theme 'ef-dream t))

(use-package flymake)
(use-package transient)
(use-package jsonrpc)

(use-package evil
  :init
  (setq evil-default-state 'emacs
        evil-want-C-w-in-emacs-state t
        evil-want-C-w-delete nil
        evil-want-Y-yank-to-eol t
        evil-want-C-u-scroll t
        evil-vsplit-window-right t
        evil-split-window-below t
        evil-undo-system 'undo-redo
        evil-symbol-word-search t
        evil-kill-on-visual-paste nil)
  :config
  (evil-set-initial-state 'prog-mode 'normal)
  (evil-set-initial-state 'text-mode 'normal)
  (evil-set-initial-state 'conf-mode 'normal)
  (evil-set-initial-state 'fundamental-mode 'normal)
  (evil-set-initial-state 'git-commit-mode 'emacs)
  (defalias #'forward-evil-word #'forward-evil-symbol)
  :hook (elpaca-after-init-hook . evil-mode))

(use-package evil-surround 
	     :after evil 
	     :config (global-evil-surround-mode 1))

(use-package evil-exchange 
	     :after evil 
	     :config (evil-exchange-install))

(use-package vertico 
	     :init 
	     (vertico-mode))

(use-package marginalia
  :bind (:map minibuffer-local-map
	      ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))

(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(use-package consult
  :after (vertico xref)
  :config
  (setq xref-show-xrefs-function        #'consult-xref
        xref-show-definitions-function  #'consult-xref))

(use-package consult-eglot 
	     :after (consult eglot))
(use-package eglot)

(use-package magit
  :bind (("C-x g" . magit-status))
  :init
  (setq magit-diff-refine-hunk t
        git-commit-summary-max-length 73
        magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1
        magit-save-repository-buffers nil))

(use-package git-link
  :init 
  (setq git-link-open-in-browser t))

(defun my/edit-init-file () (interactive) (find-file user-init-file))

(defun my/project-root-or-default-dir ()
  (if-let ((proj (project-current)))
      (project-root proj)
    default-directory))

(defvar my/terminal "urxvt")
(defvar my/terminal-args nil)

(defun my/terminal-in-project-root (&optional arg)
  (interactive "P")
  (let ((default-directory (if arg default-directory
                             (my/project-root-or-default-dir))))
    (if my/terminal-args
        (apply #'start-process "terminal" nil my/terminal my/terminal-args)
      (start-process "terminal" nil my/terminal))))

(defun my/recompile ()
  (interactive)
  (cd (my/project-root-or-default-dir))
  (recompile))

(defun my/copy-file-name ()
  (interactive)
  (when-let ((f (buffer-file-name)))
    (kill-new f)
    (message "%s" f)))

(defun my/copy-pwd ()
  (interactive)
  (kill-new default-directory)
  (message "%s" default-directory))

(global-set-key (kbd "C-x t")   #'my/terminal-in-project-root)
(global-set-key (kbd "<f7>")    #'my/recompile)
(global-set-key (kbd "C-c f")   #'my/copy-file-name)
(global-set-key (kbd "C-c d")   #'my/copy-pwd)

(global-set-key (kbd "S-<wheel-up>")   (lambda () (interactive) (scroll-right 5)))
(global-set-key (kbd "S-<wheel-down>") (lambda () (interactive) (scroll-left 5)))

(add-to-list 'default-frame-alist '(background-color . "#131015"))
(add-to-list 'default-frame-alist '(foreground-color . "#ffffff"))

(provide 'init)

