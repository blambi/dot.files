;; GUI
(blink-cursor-mode -1)
(show-paren-mode t)
(column-number-mode t)
(global-hl-line-mode t)
(scroll-bar-mode -1)
(tool-bar-mode -1)

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

;; Hooks
(add-hook 'python-mode-hook
          '(lambda () (define-key python-mode-map "\C-m" 'newline-and-indent)))(global-hl-line-mode 1)

;; Safety function stolen from smiler's .emacs
(defun my-exit-from-emacs ()
  "My exit from Emacs"
  (interactive)
  (if (yes-or-no-p "Really quit Emacs? ")
      (save-buffers-kill-emacs)))

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
       (require 'zeal-at-point)
       (global-set-key "\C-cd" 'zeal-at-point)
       ))

;; Varibles
(setq c-default-style "stroustrup")
(setq tab-width 4)
(setq standard-indent 4)
(setq inhibit-startup-screen t)
;(c-set-offset 'substatement-open 0)
(setq-default indent-tabs-mode nil)
(c-set-offset 'case-label '+)

;; others
(add-to-list 'load-path "/home/blambi/elisp/")
(load-file "~/elisp/private.el")

;; Smooth-scrolling
(setq scroll-margin 1
      scroll-conservatively 0
      scroll-up-aggressively 0.01
      scroll-down-aggressively 0.01)
(setq-default scroll-up-aggressively 0.01
              scroll-down-aggressively 0.01)

;; irc 
(defun irc ()
  "Connect to IRC."  
  (interactive)
  (if (yes-or-no-p "have you prepared ssl: ")
      (progn
        (erc-select :server "localhost" :port 6667 :password freenode-passwd)
        (erc-select :server "localhost" :port 6668 :password mythos-passwd))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(custom-enabled-themes (quote (wombat)))
 '(menu-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
