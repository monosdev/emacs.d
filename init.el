;;; init.el begins

;; set up the package manager
(require 'package)
(package-initialize)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(add-to-list 'display-buffer-alist
             '("\\`\\*\\(Warnings\\|Compile-Log\\)\\*\\'"
               (display-buffer-no-window)
               (allow-no-window . t)))

;; system setup
(ido-mode t)
(setq ido-enable-flex-matching t)

;; disable gui chrome
(menu-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(scroll-bar-mode -1)
(horizontal-scroll-bar-mode -1)
(setq inhibit-startup-message t)

;; add number line
(column-number-mode)
(global-display-line-numbers-mode t)

;; config fonts
(let ((mono-spaced-font "Sarasa Mono TC")
      (cjk-font "Sarasa Mono TC"))
  (set-face-attribute 'default nil :family mono-spaced-font :height 150)
  (set-face-attribute 'fixed-pitch nil :family mono-spaced-font :height 1.0)
  (set-face-attribute 'variable-pitch nil :family mono-spaced-font :height 1.0)
  (dolist (charset '(han symbol cjk-misc bopomofo))
  (set-fontset-font t charset (font-spec :family cjk-font))))

;; efficient loading trick
(autoload 'zap-up-to-char "misc" t)

;; better buffer naming
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; remember cursor position
(save-place-mode 1)

;; keybinding changes
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "M-z") 'zap-up-to-char)

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

;; editing behavior improvements
(show-paren-mode 1)
(setq-default indent-tabs-mode nil)
(savehist-mode 1)

;; misc sensible defaults
(setq save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t
      require-final-newline t
      visible-bell t
      load-prefer-newer t
      backup-by-copying t
      frame-inhibit-implied-resize t
      read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t
      completion-ignore-case t
      ediff-window-setup-function 'ediff-setup-windows-plain
      custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load-file custom-file))

;; centralized backups
  (unless backup-directory-alist
    (setq backup-directory-alist `(("." . ,(concat user-emacs-directory
                                                   "backups")))))

;; org mode setting

; set up org
(require 'org)

; agenda knows to look for my files
(setq org-agenda-files '("~/org"))

; when todo set to a done state, record a timestamp
(setq org-log-done 'time)

; follow the links
(setq org-return-follows-link t)

; associate all org files with org mode
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

; Make the indentation look nicer
(add-hook 'org-mode-hook 'org-indent-mode)

; shortcuts for storing links, viewing the agenda, and starting a capture
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)

; hide the markers
(setq org-hide-emphasis-markers t)

; wrap the lines in org mode so that things are easier to read
(add-hook 'org-mode-hook 'visual-line-mode)

; org capture templete

; org journal config
(require 'org-journal)

(setq org-journal-dir "~/org/journal/"
      org-journal-file-format "%Y-%m-%d.org"
      org-journal-date-format "%A"
      org-journal-time-format "[%R] "
      org-journal-time-prefix "** "
      org-journal-enable-agenda-integration t
      org-journal-carryover-delete-empty-journal 'always
      org-journal-enable-cache t)

;;; init.el ends
