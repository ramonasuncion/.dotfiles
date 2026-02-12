;; -*- lexical-binding: t; -*-
;; based on github.com/valignatev/dotemacs/

(global-unset-key (kbd "C-x C-c"))
(global-unset-key (kbd "C-h h"))

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
      pixel-scroll-precision-interpolate-page t
      dired-dwim-target t
      read-process-output-max (* 1024 1024)
      vc-follow-symlinks t
      require-final-newline t
      save-interprogram-paste-before-kill t
      warning-minimum-level :error
      gdb-many-windows t
      recentf-auto-cleanup 'never)

(setq-default indent-tabs-mode nil
              truncate-lines t
              truncate-partial-width-windows nil
              tab-width 2
              c-basic-offset 2
              js-indent-level 2
              python-indent-offset 4
              select-active-regions nil)

(setq display-line-numbers-type 'relative)
(add-hook 'after-init-hook
          (lambda ()
            (global-display-line-numbers-mode 1)
            (global-whitespace-mode 1)))

(add-hook 'dired-mode-hook (lambda () (whitespace-mode -1)))

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(blink-cursor-mode 0)
(show-paren-mode t)
(column-number-mode 1)
(setq recentf-max-saved-items 20
      recentf-exclude '("/tmp/" "COMMIT_EDITMSG" ".*-autoloads\\.el\\'" " recentf"
			"/build/" "/node_modules/" "/target/" "\\.o\\'" "\\.so\\'" "\\.dylib\\'"))

(defun my/silent-recentf-mode ()
  (let ((inhibit-message t))
    (recentf-mode 1)))

(run-with-idle-timer 2 nil #'my/silent-recentf-mode)
(winner-mode 1)
(global-auto-revert-mode t)
(pixel-scroll-precision-mode t)
(global-hl-line-mode t)

(setq use-short-answers t)
(advice-add #'display-startup-echo-area-message :override #'ignore)

(when (display-graphic-p)
  (set-face-attribute 'default nil :family "Source Code Pro" :height 140))

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
  :demand t
  :config
  (savehist-mode))

(use-package gcmh
  :init
  (setq gcmh-idle-delay 5
        gcmh-high-cons-threshold (* 100 1024 1024))  ; 100mb
  :hook (window-setup-hook . gcmh-mode))

(use-package ef-themes
  :demand t
  :init
  (setq ef-dream-palette-overrides
        '((bg-main      "#131015")
          (bg-hl-line   "#232224")
          (fg-mode-line "#f2ddcf")
          (bg-mode-line "#472b00")
          (yellow-cooler "#ff9f0a")))
  :config
  (load-theme 'ef-dream t))

(use-package which-key
  :ensure nil
  :config
  (which-key-mode))

(use-package corfu
  :hook (elpaca-after-init-hook . global-corfu-mode)
  :init
  (setq corfu-auto t
        corfu-auto-delay 0.2
        corfu-auto-prefix 2
        corfu-cycle t
        corfu-preselect 'prompt))

(use-package flymake
  :ensure nil
  :defer t)
(use-package transient
  :defer t)
(use-package jsonrpc
  :ensure nil
  :defer t)

(use-package evil
  :demand t
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
  (evil-set-initial-state 'dired-mode 'normal)
  (defalias #'forward-evil-word #'forward-evil-symbol)
  :hook (elpaca-after-init-hook . evil-mode))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode 1))

(use-package evil-exchange
  :after evil
  :config (evil-exchange-install))

(use-package multiple-cursors
  :commands (mc/edit-lines mc/mark-next-like-this mc/mark-previous-like-this
			   mc/mark-all-like-this mc/unmark-next-like-this mc/unmark-previous-like-this
			   mc/mark-all-like-this-dwim set-rectangular-region-anchor
			   mc/add-cursor-on-click mc/keyboard-quit)
  :config
  (setq mc/always-run-for-all t
        mc/insert-numbers-default 0))

(use-package vertico
  :hook (elpaca-after-init-hook . vertico-mode))

(use-package marginalia
  :hook (elpaca-after-init-hook . marginalia-mode))

(use-package orderless
  :demand t
  :config
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(use-package deadgrep
  :commands deadgrep)

(use-package consult
  :after vertico
  :config
  (setq xref-show-xrefs-function        #'consult-xref
        xref-show-definitions-function  #'consult-xref))

(use-package yasnippet
  :hook (prog-mode-hook . yas-minor-mode)
  :config
  (setq yas-snippet-revival nil
        yas-also-auto-indent-first-line nil
        yas-also-indent-empty-lines nil
        yas-choose-keys-first nil
        yas-choose-tables-first nil
        yas-triggers-in-field t
        yas-indent-line 'fixed
        yas-verbosity 0)
  (yas-reload-all))

(use-package eglot
  :ensure nil
  :defer t
  :hook ((python-mode-hook . eglot-ensure)
         (c-mode-hook . eglot-ensure)
         (c++-mode-hook . eglot-ensure)))

(use-package consult-eglot
  :after (consult eglot))

(add-to-list 'auto-mode-alist '("Pipfile\\'" . conf-toml-mode))
(add-to-list 'auto-mode-alist '("Pipfile\\.lock\\'" . js-mode))
(add-to-list 'auto-mode-alist '("requirements.txt\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.env\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.env\\.local\\'" . conf-mode))

(use-package rainbow-mode
  :hook ((css-mode-hook . rainbow-mode)
         (html-mode-hook . rainbow-mode))
  :config
  (setq rainbow-x-colors nil
        rainbow-html-colors t))

(use-package editorconfig
  :ensure nil
  :config
  (editorconfig-mode 1)
  (setq editorconfig-trim-whitespaces-mode nil))

;; Use GNU ls for dired (gls on macOS, ls on Linux)
(setq insert-directory-program (or (executable-find "gls") (executable-find "ls")))
(setq dired-use-ls-dired t)
(setq dired-listing-switches "-lha")

(use-package magit
  :commands (magit-status magit-blame magit-log magit-diff)
  :init
  (setq magit-diff-refine-hunk t
        git-commit-summary-max-length 73
        magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1
        magit-save-repository-buffers nil))

(add-hook 'elpaca-after-init-hook
          (lambda ()
            (global-set-key (kbd "C-x g") #'magit-status)
            (global-set-key (kbd "<f5>") #'deadgrep)
            (global-set-key (kbd "C-S-c") #'mc/edit-lines)
            (global-set-key (kbd "C-S-n") #'mc/mark-next-like-this)
            (global-set-key (kbd "C-S-p") #'mc/mark-previous-like-this)
            (global-set-key (kbd "C-S-a") #'mc/mark-all-like-this)
            (global-set-key (kbd "C->") #'mc/unmark-next-like-this)
            (global-set-key (kbd "C-<") #'mc/unmark-previous-like-this)
            (global-set-key (kbd "C-c C-<") #'mc/mark-all-like-this-dwim)
            (global-set-key (kbd "C-S-SPC") #'set-rectangular-region-anchor)
            (global-set-key (kbd "M-<mouse-1>") #'mc/add-cursor-on-click)
            (global-set-key (kbd "C-c s") #'consult-line)
            (global-set-key (kbd "C-c S") #'consult-grep)
            (global-set-key (kbd "C-c e") #'consult-recent-file)
            ;; Flymake error navigation (like ]d / [d in neovim)
            (with-eval-after-load 'evil
              (evil-define-key 'normal 'global
			       (kbd "]d") #'flymake-goto-next-error
			       (kbd "[d") #'flymake-goto-prev-error))
            (define-key minibuffer-local-map (kbd "M-A") #'marginalia-cycle)))

(use-package git-link
  :init
  (setq git-link-open-in-browser t))

(defun my/edit-init-file () (interactive) (find-file user-init-file))

(defun my/project-root-or-default-dir ()
  (if-let ((proj (project-current)))
      (project-root proj)
    default-directory))

(defvar my/terminal (cond ((eq system-type 'darwin) "open")
                          ((executable-find "alacritty") "alacritty")
                          ((executable-find "kitty") "kitty")
                          ((executable-find "gnome-terminal") "gnome-terminal")
                          ((executable-find "urxvt") "urxvt")
                          (t "xterm")))
(defvar my/terminal-args (when (eq system-type 'darwin) '("-a" "Terminal")))

(defun my/terminal-in-project-root (&optional arg)
  (interactive "P")
  (let ((default-directory (if arg default-directory
                             (my/project-root-or-default-dir))))
    (if my/terminal-args
        (apply #'start-process "terminal" nil my/terminal my/terminal-args)
      (start-process "terminal" nil my/terminal))))

(defun my/recompile ()
  (interactive)
  (let ((default-directory (my/project-root-or-default-dir)))
    (recompile)))

(defun my/build-project ()
  (interactive)
  (let ((default-directory (my/project-root-or-default-dir)))
    (cond
     ((file-exists-p "Makefile")
      (compile "make"))
     ((file-exists-p "CMakeLists.txt")
      (unless (file-exists-p "build")
        (make-directory "build"))
      (let ((default-directory (expand-file-name "build" default-directory)))
        (compile "cmake .. && make")))
     (t
      (message "No Makefile or CMakeLists.txt found")))))

(defun my/run-project ()
  (interactive)
  (let* ((project-dir (my/project-root-or-default-dir))
         (default-directory project-dir))
    (cond
     ;; Python
     ((file-exists-p "main.py")
      (async-shell-command "python main.py" "*run-output*"))
     ;; C/C++ executables
     ((and (file-exists-p "./main") (file-executable-p "./main"))
      (async-shell-command "./main" "*run-output*"))
     ((and (file-exists-p "./a.out") (file-executable-p "./a.out"))
      (async-shell-command "./a.out" "*run-output*"))
     ((and (file-exists-p "./build/main") (file-executable-p "./build/main"))
      (async-shell-command "./build/main" "*run-output*"))
     ;; Ask user for command
     (t
      (let ((command (read-string "Run command: ")))
        (async-shell-command command "*run-output*"))))))

(defun my/copy-file-name ()
  (interactive)
  (when-let ((f (buffer-file-name)))
    (kill-new f)
    (message "%s" f)))

(defun my/copy-pwd ()
  (interactive)
  (kill-new default-directory)
  (message "%s" default-directory))

(global-set-key (kbd "C-x C-m") #'execute-extended-command)
(global-set-key (kbd "C-x m")   #'execute-extended-command)
(global-set-key (kbd "C-c t")   #'my/terminal-in-project-root)
(global-set-key (kbd "<f7>")    #'my/recompile)
(global-set-key (kbd "C-c b")   #'my/build-project)
(global-set-key (kbd "C-c r")   #'my/run-project)
(global-set-key (kbd "C-c f")   #'my/copy-file-name)
(global-set-key (kbd "C-c d")   #'my/copy-pwd)

;; macOS-specific keybindings
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta
        mac-option-modifier 'super
        mac-right-command-modifier 'meta
        mac-right-option-modifier 'super)
  ;; Make Command+V work in terminal
  (setq xterm-extra-capabilities '("clipboard" "color" "sixel")))

(global-set-key (kbd "S-<wheel-up>")   (lambda () (interactive) (scroll-right 5)))
(global-set-key (kbd "S-<wheel-down>") (lambda () (interactive) (scroll-left 5)))

(use-package lua-mode
  :mode "\\.lua\\'"
  :interpreter "lua"
  :config
  (setq lua-indent-level 4))

