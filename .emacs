;; Load CEDET.
;; See cedet/common/cedet.info for configuration details.
;; IMPORTANT: Tou must place this *before* any CEDET component
;; gets activated by another package (Gnus, auth-source, ...).
(load-file "~/.devtools/cedet-repo/cedet-devel-load.el")

;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/") 

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(column-number-mode t)
 '(custom-enabled-themes (quote (manoj-dark)))
 '(fringe-mode 6 nil (fringe))
 '(inhibit-startup-screen t)
 '(linum-format " %7d ")
 '(main-line-color1 "#191919")
 '(main-line-color2 "#111111")
 '(powerline-color1 "#191919")
 '(powerline-color2 "#111111")
 '(show-paren-mode t)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify)))

;(set-frame-font '-*-fixed-*-*-normal--14-*-*-*-*-*-iso8859-1 nil t)
;(set-face-font  'default "-*-fixed-*-*-normal--10-*-*-*-*-*-iso8859-1")

;; apt install msttcorefonts
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :slant normal :weight normal :height 83 :width normal :foundry "PfEd")))))

(column-number-mode)

(setq suggest-key-bindings 't)

;(prefer-coding-system 'utf-8-dos)
;(setq-default buffer-file-coding-system 'utf-8-dos)
;(set-default-coding-systems 'utf-8-dos)


;;
;; Tab settings: pick one tab-always-indent below
;;

;; make tab key always call a indent command.
(setq-default tab-always-indent t)

;; make tab key call indent command or insert tab character, 
;; depending on cursor position
;(setq-default tab-always-indent nil)

;; make tab key do indent first then completion.
;(setq-default tab-always-indent 'complete)


;; M-x set-variable RET c-basic-offset RET 8
(setq c-basic-offset 8)

; I don't know what these do...
;(setq tab-width 8)
;(setq-default tab-width 8)

;(defvaralias 'c-basic-offset 'tab-width)

; Auto-indent upon newline
(add-hook 'list-mode-hook '(lambda ()
   (local-set-key (kbd "RET") 'newline-and-indent)))

; Python-specific stuff
(setq python-indent 4)
(add-hook 'python-mode-hook 'guess-style-guess-tabs-mode)
;(require 'smart-tabs)
;(require 'guess-style)
;(smart-tabs-advice python-indent-line-1 python-indent)
(add-hook 'python-mode-hook (lambda ()
                              (when indent-tabs-mode
                                (guess-style-guess-tab-width))))


; Highlighting
(global-hi-lock-mode 1)
(global-hl-line-mode 1)
;(set-face-background 'hl-line "#3e4446")
;(set-face-background 'hl-line "#3f003f")
; Shades of dark red vvv
;(set-face-background 'hl-line "#990000")
(set-face-background 'hl-line "#330000")
(set-face-foreground 'hl-line nil)

;(defun highlight-todos (font-lock-add-keywords nil
;             '(("\\<\\(FIXME\\|TODO\\|BUG\\|XXXX\\):" 1 font-lock-warning-face t))))
;(add-hook 'text-mode-hook 'highlight-todos)

;(add-hook 'c-mode-common-hook
;               (lambda ()
;                (font-lock-add-keywords nil
;                 '(("\\<\\(FIXME\\|TODO\\|BUG\\|XXXX\\):" 1 font-lock-warning-face t)))))
;(add-hook 'text-mode-hook 'highlight-todos)

(autoload 'whitespace-mode "whitespace" "Toggle whitespace visualization." t)


(require 'xcscope)

; M-x cscope-set-initial-directory
; M-x cscope-find-this-symbol

;(cd "<project path>")
;(setq default-directory "<path>")

;(require 'ido)
;(setq ido-enable-flex-matching t)
;(setq ido-everywhere t)
;(ido-mode t)

(defun dos2unix ()
  "Convert a DOS formatted text buffer to UNIX format."
  (interactive)
  (set-buffer-file-coding-system 'undecided-unix nil))

(defun unix2dos ()
  "Convert a UNIX formatted text buffer to DOS format."
  (interactive)
  (set-buffer-file-coding-system 'undecided-dos nil))

(defun remove-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))

;(add-hook 'text-mode-hook 'remove-dos-eol)
;(add-hook 'c-mode-hook   'remove-dos-eol)
;(add-hook 'c++-mode-hook 'remove-dos-eol)

(defun open-new-line( ) (interactive) (end-of-line) (newline-and-indent))
(defun c-return( ) (interactive) (c-indent-line) (newline-and-indent))
(defun java-return( ) (interactive) (c-indent-line) (newline-and-indent))
(defun prolog-return( ) (interactive) (prolog-indent-line) (newline-and-indent))
(defun scheme-return( ) (interactive) (scheme-indent-line) (newline-and-indent))
(defun delete-whole-line( ) (interactive) (beginning-of-line) (kill-line))
(defun join-lines( ) (interactive) (end-of-line) (kill-line))
(defun front( ) (interactive) (beginning-of-buffer))
(defun quit( ) (interactive) (save-buffers-kill-emacs))
(defun exchange-mp( ) (interactive) (exchange-point-and-mark))
(defun split( ) (interactive) 
    (split-window-vertically)
    (other-window 1))

(defun kill-something( ) (interactive)
    (if (and mark-active transient-mark-mode)
        (kill-region (point) (mark)) 
        (delete-backward-char 1)
    )
)

(add-hook 'c-mode-hook
   '(lambda() 
        (local-set-key [13] 'c-return)        ;;; RET with automatic indent
        (local-set-key "\ep" 'indent-all)     ;;; Esc-p pretty-prints file
        (c-set-style "k&r")                   ;;; Kernihan & Richie's style
        (setq c-basic-offset 4)               ;;; 4 spaces for indentations
        (c-set-offset 'substatement-open 0)   ;;; No indent for open bracket
    )
)
;;; c++-mode
(add-hook 'c++-mode-hook
   '(lambda() 
        (local-set-key [13] 'c-return)        ;;; RET with automatic indent
        (local-set-key "\ep" 'indent-all)     ;;; Esc-p pretty-prints file
        (c-set-style "Ellemtel")                   ;;; Kernihan & Richie's style
        (setq c-basic-offset 4)               ;;; 4 spaces for indentations
        (c-set-offset 'substatement-open 0)   ;;; No indent for open bracket
        (c-set-offset 'statement-cont 0)      ;;; for earlier emacs 19
    )
)
;;; prolog-mode
(add-hook 'prolog-mode-hook
   '(lambda() 
        (local-set-key [13] 'prolog-return)   ;;; RET with automatic indent
        (local-set-key "\ep" 'indent-all)     ;;; Esc-p pretty-prints file
    )
)
;;; scheme-mode
;;; This mode is not entirely to my liking because I prefer to place
;;; the closing parenthesis on a line of its own, lined up under its
;;; corresponding closing parenthesis. The modification of this mode
;;; to support that programming style is on my to-do list.
(add-hook 'scheme-mode-hook
   '(lambda() 
        (local-set-key [13] 'scheme-return)   ;;; RET with automatic indent
        (local-set-key "\ep" 'indent-all)     ;;; Esc-p pretty-prints file
        (setq lisp-indent-offset 4)           ;;; 4 spaces for indentation
    )
)

;;
;; C development help
;;

;; ----------------------- Based on cedet INSTALL file ------------------

;; CEDET was loaded at the top of this file

;; Add further minor-modes to be enabled by semantic-mode.
;; See doc-string of `semantic-default-submodes' for other things
;; you can use here.
(add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode t)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode t)
(add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode t)

(add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode)  
(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)  
(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)  
(add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)  
(add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode)  


;(global-semantic-idle-scheduler-mode)
;(global-semanticdb-minor-mode 1)
;(global-semantic-idle-completions-mode)
;(global-semantic-decoration-mode)
;(global-semantic-highlight-func-mode)

; causes excessive underlining in red
;(global-semantic-show-unmatched-syntax-mode)

;; Enable Semantic
(semantic-mode 1)

;; Enable EDE (Project Management) features
(global-ede-mode 1)

;; Semantic auto-complete
(require 'semantic/ia)


; start speedbar if we're using a window system
;(require 'speedbar)
;(when window-system (speedbar 1))
;(speedbar 1)
(speedbar)

;; ggtags
;(require 'ggtags)
;(add-hook 'c-mode-common-hook
;          (lambda ()
;            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
;              (ggtags-mode 1))))

;; or gtags ???
;(use-package gtags :ensure t :defer t)

;(define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
;(define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
;(define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
;(define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
;(define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
;(define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)

;(define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)

;; Useful; first create this file!
; (load-file "~/.emacs.d/cedet-projects.el")
