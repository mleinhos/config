;;
;; c-default-style values: java awk linux gnu k&r bsd
;;
;; Brace placement that's acceptable to me is implemented by:
;; k&r, stroustrup, linux - same line as condition
;; bsd, allman - alone on next line
;;
;;    https://www.gnu.org/software/emacs/manual/html_node/ccmode/Built_002din-Styles.html#Built_002din-Styles
;;

; c-mode-hook, c++-mode-hook
; (add-hook 'c-mode-hook
;    '(lambda() 
;         (local-set-key [13] 'c-return)        ;;; RET with automatic indent
;         (local-set-key "\ep" 'indent-all)     ;;; Esc-p pretty-prints file
;         (c-set-style "k&r")                   ;;; Kernihan & Richie's style
;         (setq c-basic-offset 4)               ;;; 4 spaces for indentations
;         (c-set-offset 'substatement-open 0)   ;;; No indent for open bracket
;     )
; )

;;
;; Full path is the buffer name
;;
(require 'uniquify)
;(setq uniquify-buffer-name-style 'reverse)
;(setq uniquify-buffer-name-style 'forward)
(setq uniquify-buffer-name-style 'post-forward)

;;
;; Auto-insert closing parens/brackets/etc
;;
(electric-pair-mode 1)
(setq electric-pair-preserve-balance nil)

;;
;; Default style... clobbered below in case of kernel source
;;
(setq c-default-style "k&r")
(setq c-basic-offset  4)

(defun maybe-linux-style ()
  (when (and buffer-file-name
	     (or (string-match "linux"  buffer-file-name)
		 (string-match "kernel" buffer-file-name)))
    (c-set-style "linux")
    (message "Using Linux mode for kernel code")))

(add-hook 'c-mode-hook 'maybe-linux-style)

; prolog-mode
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

;;
;; Tab settings: pick one tab-always-indent below
;;

;; make tab key call indent command or insert tab character, 
;; depending on cursor position

;(setq-default tab-always-indent t)
;(setq-default indent-tabs-mode nil)

;(setq tabs-always-indent t)
;(setq indent-tabs-mode t)

;(setq default-tab-width 8)
;(setq tab-width 8)

;(setq-default tab-width 8) ; or any other preferred value

;; These don't work and cause warnings
;;(defvaralias 'c-basic-offset 'tab-width)
;(set-variable tab-width 8)

;; Keep this!!
;(setq c-basic-offset 8)


;; M-x set-variable RET c-basic-offset RET 8
;; ---OR---
;; M-x set-variable RET tab-width RET 8
;(setq-default c-basic-offset 8)

;(defvaralias 'c-basic-offset 'tab-width)
;(add-hook 'c-mode-hook (lambda () (setq indent-tabs-mode t)))
