(load-file "~/.devtools/cedet-repo/cedet-devel-load.el")

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/") 

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(column-number-mode t)
 '(custom-enabled-themes (quote (manoj-dark)))
 '(custom-safe-themes
   (quote
    ("5990b62c6624b397fb2a2f81b76d4513a872c24bc4ee1c6a89ff043c53c8fa77" "60bb7e2d647eda1ecab8bfe4afc21852d993b38a87ed50e4561bcf87c9adf84c" "eea6a64305cc34c2cc113652566c06e41c09d1d1fdc4efc017acfac5c84f505d" "da54d392eff55fe55e64211909ae4cb884a0026d1abcc3e0678281879386030f" "8fcbb734e7e8bb240299fb3d52628f13e1af6dda931ced3e1df7a0eb41309608" "d6032e0ae07e02c9e1cddedfaf678e1845441432d4c7fb8a8dac11046ed5aa0c" "d7ad8092aa1b790f780e2e216610a5fd76960ea586b2ded178d3290030754e89" "f50bc9643db18450ebee565fa670013667dc34521202be89c368b37ee2059bc5" "53baec177cd4b21dbc313e2db38c2f5914277c3da82b5a5da818a465dc8f8927" "63b7b8a45190b2e7362a975067bd76b55ae548c00e9088d12b4133eb0525a604" "cc5af45ea370950dfc8a205a4ab8c78964e2bcfc04ab093b6a1adda37cef3f35" "2daf79d4048f0f7280f6e6b763c8c81f8cef96ef8444b42ea0eb3023fe387eac" "5c64430cb8e12e2486cd9f74d4ce5172e00f8e633095d27edd212787a4225245" "6aae2eb39ce5d67379a4718cdb295b819c4100ddda8d07fa8eab53289a0b7551" default)))
 '(ede-project-directories
   (quote
    ("/home/matt/proj/mw-cbb/comms_chan/rump_comms/rump-xenevent/src-netbsd/sys/rump/dev/lib/libxenevent")))
 '(fringe-mode 6 nil (fringe))
 '(linum-format " %7d ")
 '(main-line-color1 "#191919")
 '(main-line-color2 "#111111")
 '(powerline-color1 "#191919")
 '(powerline-color2 "#111111")
 '(show-paren-mode t)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Courier New" :slant normal :weight normal :height 100 :width normal)))))

(column-number-mode)

(setq suggest-key-bindings 't)

;(prefer-coding-system 'utf-8-dos)
;(setq-default buffer-file-coding-system 'utf-8-dos)
;(set-default-coding-systems 'utf-8-dos)

; Disable tabs, thus allowing guess-tabs
(setq-default indent-tabs-mode nil)
(setq c-basic-indent 4)
(setq tab-width 4)

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

;(require 'xcscope)

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

;; Load CEDET.
;; See cedet/common/cedet.info for configuration details.
;; IMPORTANT: Tou must place this *before* any CEDET component
;; gets activated by another package (Gnus, auth-source, ...).
(load-file "~/.devtools/cedet-repo/cedet-devel-load.el")

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
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
              (ggtags-mode 1))))

;(define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
;(define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
;(define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
;(define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
;(define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
;(define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)

;(define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)

(load-file "~/.emacs.d/cedet-projects.el")
