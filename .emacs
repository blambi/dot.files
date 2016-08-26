;; GUI
(blink-cursor-mode -1)
(show-paren-mode t)
(column-number-mode t)
(global-hl-line-mode t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
;(set-face-attribute 'default nil :font  "DejaVu Sans Mono-9" )
;(set-frame-font "DejaVu Sans Mono-9" nil t)
(server-start)

;; Bindings
(global-set-key "\C-cg" 'goto-line) ;; Hoppa till rad.
(global-unset-key "\C-z")           ;; Döda C-z
(global-set-key [C-tab] 'dabbrev-completion)
;(global-set-key "\C-z" 'expand-abbrev) ;; trevligare andvändning av C-z
(global-set-key "\C-c \C-c" 'comment-region) ;; Comment region
(global-set-key "\C-c \C-u" 'uncomment-region) ;; Uncomment region
(global-set-key "\C-x\C-c" 'my-exit-from-emacs)       ;; Exit function
(global-set-key "\C-xp" 'previous-multiframe-window) ;; Motsatsen till C-x o
(global-set-key "\C-cq" 'word-count-region) ;; Reverse the region
(global-set-key [f5] 'recompile) ;; Doing this quite a lot now days..
(global-set-key [f6] 'whitespace-cleanup) ;; Doing this quite a lot now days..
(global-set-key [f10] 'magit-status) ;; -""-

;; Hooks
(add-hook 'python-mode-hook
          '(lambda () (define-key python-mode-map "\C-m" 'newline-and-indent)))
(add-hook 'after-init-hook 'global-company-mode)
;; Safety function stolen from smiler's .emacs
(defun my-exit-from-emacs ()
  "My exit from Emacs"
  (interactive)
  (if (yes-or-no-p "Really quit Emacs? ")
      (save-buffers-kill-emacs)))

;; Missing link..
(defun insert-shell-command ()
  (interactive)
  (insert (shell-command-to-string (read-from-minibuffer "Command: "))))

;; Custom modules
(setq my-conf-own (file-directory-p "~/elisp/")) ;; do we have our own elisps?
(if my-conf-own
     (progn
       (add-to-list 'load-path "~/elisp")
       ;(load "skeletons")
       (load "markdown-mode")
       (load "d-mode")
       (load "web-mode")
       (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
       (add-to-list 'auto-mode-alist '("\\.md?\\'" . markdown-mode))
       (add-to-list 'load-path "~/elisp/jshint-mode")
       (require 'flymake-jshint)
       (add-hook 'javascript-mode-hook
                 (lambda () (flymake-mode t)))
       ))

;; Varibles
(setq c-default-style "stroustrup")
(setq tab-width 4)
(setq standard-indent 4)
(setq inhibit-startup-screen t)
;(c-set-offset 'substatement-open 0)
(setq-default indent-tabs-mode nil)
(c-set-offset 'case-label '+)
;(setq grep-find-command '("git grep " . 9))
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "/home/avraham/opt/bin/browser.sh"
      browse-url-generic-args '(""))
;; others
(add-to-list 'load-path "/home/blambi/elisp/")
(load-file "~/elisp/private.el")

;; meta + up/down/left/right for window navigation.
(windmove-default-keybindings 'meta)

;; Transparency
(set-frame-parameter (selected-frame) 'alpha '(96 96))
(add-to-list 'default-frame-alist '(alpha 96 96))

;; Smooth-scrolling
(setq scroll-margin 1
      scroll-conservatively 0
      scroll-up-aggressively 0.01
      scroll-down-aggressively 0.01)
(setq-default scroll-up-aggressively 0.01
              scroll-down-aggressively 0.01)

;; vbell
(set 'visible-bell nil)
(set 'ring-bell-function (lambda ()
     (invert-face 'mode-line)
     (run-with-timer 0.1 nil 'invert-face 'mode-line)))

;; Packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(setq package-enable-at-startup nil) ;; Hack to make projectile load..
(package-initialize)

;; Enable projectile
(require 'projectile)
(projectile-global-mode)

;; ERC
(require 'erc)
(if my-conf-own
    (progn
      (load "erc-extcmd")
      (load "erc-pik")
      (load "erc-bitlbee")
      (require 'erc-highlight-nicknames)
      (add-to-list 'erc-modules 'highlight-nicknames)
      (autoload 'erc-nick-notify-mode "erc-nick-notify"
        "Minor mode that calls `erc-nick-notify-cmd' when his nick gets mentioned in an erc channel" t)
      (eval-after-load 'erc '(erc-nick-notify-mode t))
      (setq erc-nick-notify-icon "/usr/share/gajim/icons/hicolor/32x32/categories/gajim-agent-irc.png")
      (erc-update-modules)
      ))

(eval-after-load "erc"
  (progn
    (set-face-foreground 'erc-input-face "DarkGrey")
    (set-face-foreground 'erc-prompt-face "DarkSlateBlue")
    ;(set-face-background 'erc-prompt-face "#08070D")
    (set-face-foreground 'erc-notice-face "#403C4D") ; joins etc
    ))

;;stuff to not show in modeline
(setq track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                            "324" "329" "332" "333" "353" "477"))

(setq-default erc-nick "blambi"
              erc-nick-uniquifier "-"
              erc-user-full-name "Avraham Lembke"
              erc-paranoid t
              erc-auto-query t ;; msg -> own buffer
              erc-prompt "-->")

(setq erc-header-line-format "[%t %m] %o") ;; header

;; change this to what you like.. default is 30,000
;; (setq erc-max-buffer-size 30000)
(setq erc-truncate-buffer-on-save t)

(defvar erc-insert-post-hook)
(add-hook 'erc-insert-post-hook
          'erc-truncate-buffer)

;; ERC
(defun irc ()
  "Connect to IRC."
  (interactive)
  (if (yes-or-no-p "have you prepared ssl: ")
      (progn
        (erc-tls :server "freenodeirc.macode.se" :port 7779 :password freenode-passwd)
        ;(erc-tls :server "irc.macode.se" :port 7779 :password mythos-passwd)

        ;; problematic faces
        (set-face-foreground 'erc-nick-default-face "Grey")
        (set-face-foreground 'erc-current-nick-face "YellowGreen")
        (set-face-foreground 'erc-timestamp-face "DimGrey")
        (set-face-foreground 'erc-pal-face "medium orchid")
        (set-face-foreground 'erc-keyword-face "medium orchid")
        )))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/autosaves/\\1" t))))
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
 '(blink-cursor-mode nil)
 '(custom-enabled-themes (quote (grandshell)))
 '(custom-safe-themes
   (quote
    ("9ff70d8009ce8da6fa204e803022f8160c700503b6029a8d8880a7a78c5ff2e5" "b7ba8bd70d2c954e326144c5bf11eecffd55683dfa76aa16bc53572a6184bc1d" "0371ea3962f89505580bb2f346f96decfd7c2147e0ee6811951b1239d2ebddcc" "f0d8af755039aa25cd0792ace9002ba885fd14ac8e8807388ab00ec84c9497d7" "28ec8ccf6190f6a73812df9bc91df54ce1d6132f18b4c8fcc85d45298569eb53" default)))
 '(fci-rule-color "#151515")
 '(grep-find-command (quote ("git grep " . 9)))
 '(jshint-mode-node-program "nodejs")
 '(menu-bar-mode nil))

;; create the autosave dir if necessary, since emacs won't.
(make-directory "~/.emacs.d/autosaves/" t)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#0b0b0b" :foreground "#f6f3e8" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 80 :width normal :foundry "misc" :family "fixed")))))


;; Better looking hl-mode
(set-face-background 'hl-line "#0D0D0D")
(set-face-foreground 'highlight nil)
(set-face-foreground 'hl-line nil)
(set-face-underline 'hl-line nil)
