;; --- Package Setup ---
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu"   . "https://elpa.gnu.org/packages/")))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; --- macOS Modifier Fix + Keybindings ---
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'super)
  (setq mac-option-modifier 'meta)

  (global-set-key (kbd "s-<backspace>") 'kill-whole-line)

  (defun select-current-line ()
    (interactive)
    (move-beginning-of-line nil)
    (set-mark (line-end-position)))
  (global-set-key (kbd "s-l") 'select-current-line)

  (global-set-key (kbd "M-DEL") 'backward-kill-word)
  (global-set-key (kbd "M-<backspace>") 'backward-kill-word))

;; --- Theme and Appearance ---
(use-package doom-themes
  :config
  (load-theme 'doom-one t))

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package all-the-icons
  :if (display-graphic-p))

;; --- Dashboard ---
(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner 'official)
  (setq dashboard-items '((recents  . 5)
                          (projects . 5))))

;; --- Parenthesis and Indentation ---
(show-paren-mode 1)
(setq show-paren-delay 0)
(electric-pair-mode 0)
(electric-indent-mode 1)

(use-package smartparens
  :hook (prog-mode . smartparens-mode)
  :config
  (require 'smartparens-config)

  (defun my-c-brace-newline-handler (&rest _ignored)
    "Insert newline after `{`, indent the current and next lines."
    (newline)
    (indent-according-to-mode)
    (save-excursion
      (newline)
      (indent-according-to-mode)))

  (sp-with-modes '(c-mode c++-mode)
    (sp-local-pair "{" nil
                   :post-handlers '((my-c-brace-newline-handler "RET"))
                   :actions '(insert wrap)))

  (sp-local-pair 'prog-mode "[" nil :actions '(insert wrap)))

(use-package highlight-parentheses
  :hook (prog-mode . highlight-parentheses-mode))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; --- Snippets ---
(use-package yasnippet
  :config (yas-global-mode 1))

(use-package yasnippet-snippets
  :after yasnippet)

;; --- Auto-completion ---
(use-package company
  :hook (after-init . global-company-mode)
  :config
  (setq company-backends '(company-capf))
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1))

(use-package company-box
  :hook (company-mode . company-box-mode))

;; --- Eglot (LSP Client) ---
(use-package eglot
  :ensure t
  :hook ((c-mode c++-mode) . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs
               '((c++-mode c-mode)
                 . ("/opt/homebrew/opt/llvm/bin/clangd")))
  ;; Optional: tweak eglot config
  (setq eglot-autoshutdown t)
  (setq eglot-extend-to-xref t))

;; --- Formatting ---
(use-package clang-format)

(defun my-c++-mode-hook ()
  (add-hook 'before-save-hook #'clang-format-buffer nil 'local))

(add-hook 'c++-mode-hook 'my-c++-mode-hook)

(setq clang-format-executable "/opt/homebrew/opt/llvm/bin/clang-format")

;; --- C/C++ Style ---
(setq-default c-default-style "linux"     ;; or "gnu", "k&r", etc.
              c-basic-offset 2
              indent-tabs-mode nil
              tab-width 2)


(defun my-c-style ()
  (c-set-offset 'substatement-open 0)
  (c-set-offset 'inline-open 0)
  (c-set-offset 'block-open 0))

(add-hook 'c++-mode-hook 'my-c-style)
(add-hook 'c-mode-hook 'my-c-style)

;; --- UI Tweaks ---
(menu-bar-mode 1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)
(column-number-mode 1)
(blink-cursor-mode 0)
(setq inhibit-startup-screen t)
(setq frame-title-format "%b")
(setq ring-bell-function 'ignore)

;; --- Smooth Scrolling ---
(when (boundp 'pixel-scroll-precision-mode)
  (pixel-scroll-precision-mode 1))

;; --- Fonts ---
(set-face-attribute 'default nil :font "JetBrainsMono Nerd Font" :height 130)

;; --- Helpful Key Display ---
(use-package which-key
  :init (which-key-mode))

;; --- Manual Indent Region Shortcut ---
(global-set-key (kbd "C-c i") #'indent-region)

;; --- Format Buffer Shortcut ---
(global-set-key (kbd "C-c C-f") #'clang-format-buffer)

;; --- Save Custom Vars ---
(custom-set-variables
 '(package-selected-packages
   '(all-the-icons clang-format company company-box dashboard
                   doom-modeline doom-themes eglot
                   highlight-parentheses rainbow-delimiters
                   smartparens treemacs which-key yasnippet
                   yasnippet-snippets)))
(custom-set-faces)
