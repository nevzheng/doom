(setq user-full-name "Nevin Zheng"
      user-mail-address "nevzheng@gmail.com")

(setq centaur-tabs-set-bar 'over
      centaur-tabs-set-icons t
      centaur-tabs-gray-out-icons 'buffer
      centaur-tabs-height 24
      centaur-tabs-set-modified-marker t
      centaur-tabs-style "bar"
      centaur-tabs-modified-marker "•")
(map! :leader
      :desc "Toggle tabs globally" "t c" #'centaur-tabs-mode
      :desc "Toggle tabs local display" "t C" #'centaur-tabs-local-mode)
(evil-define-key 'normal centaur-tabs-mode-map (kbd "g <right>") 'centaur-tabs-forward        ; default Doom binding is 'g t'
                                               (kbd "g <left>")  'centaur-tabs-backward       ; default Doom binding is 'g T'
                                               (kbd "g <down>")  'centaur-tabs-forward-group
                                               (kbd "g <up>")    'centaur-tabs-backward-group)

(setq doom-theme 'doom-nord)

(setq doom-font (font-spec :family "Fira Code" :size 12)
      doom-variable-pitch-font (font-spec :family "Ubuntu" :size 13)
      doom-big-font (font-spec :family "Fira Code" :size 24))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))
(setq global-prettify-symbols-mode t)

(use-package emojify
  :hook (after-init . global-emojify-mode))

(xterm-mouse-mode 1)

(map! :leader
      (:prefix ("-" . "open file")
       :desc "Edit agenda file" "a" #'(lambda () (interactive) (find-file "~/org/agenda/agenda.org"))
       :desc "Edit doom config.org" "c" #'(lambda () (interactive) (find-file "~/.config/doom/config.org"))
       :desc "Edit eshell aliases" "e a" #'(lambda () (interactive) (find-file "~/.config/doom/eshell/aliases"))
       :desc "Edit eshell aliases" "e p" #'(lambda () (interactive) (find-file "~/.config/doom/eshell/profile"))
       :desc "Edit doom init.el" "i" #'(lambda () (interactive) (find-file "~/.config/doom/init.el"))
       :desc "Edit doom packages.el" "p" #'(lambda () (interactive) (find-file "~/.config/doom/packages.el"))))

(after! org
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  (setq org-directory "~/org/"
        org-agenda-files (directory-files-recursively "~/org/agenda" "\\.org$")
        org-default-notes-file (expand-file-name "notes.org" org-directory)
        ;; org-log-done 'note ;; Adds a Note and time stamp
        org-log-done 'time ;; Adds just a time stamp
        org-hide-emphasis-markers t))

;; Capture Templates
(after! org (setq org-capture-templates
    '(("a" "Agenda Todo" entry (file "~/org/agenda/Refile.org")
       "\n\n** TODO %?\nSCHEDULED: <%(org-read-date nil nil \"+1d\")>" :empty-lines 1)
       ("t" "Todo" entry (file "~/org/agenda/Refile.org")
       "* TODO %?\n%U" :empty-lines 1)
      ("T" "Todo with Clipboard" entry (file "~/org/agenda/Refile.org")
       "* TODO %?\n%U\n   %c" :empty-lines 1)
      ("n" "Note" entry (file "~/org/agenda/Refile.org")
       "* NOTE %?\n%U" :empty-lines 1)
      ("N" "Note with Clipboard" entry (file "~/org/agenda/Refile.org")
       "* NOTE %?\n%U\n   %c" :empty-lines 1)
      ("e" "Event" entry (file+headline "~/org/agenda/Events.org" "Transient")
       "* EVENT %?\n%U" :empty-lines 1)
      ("E" "Event With Clipboard" entry (file+headline "~/org/agenda/Events.org" "Transient")
       "* EVENT %?\n%U\n   %c" :empty-lines 1)
      ("l" "Link" entry (file "~/org/agenda/Link.org")
        "* TODO %a %? %^G\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n")
      ("j" "Journal" entry (file+datetree "~/org/agenda/Journal.org")
        "* %? %^G\nEntered on %U\n")
     )))

;; Org Capture Shortcut C-c c
(global-set-key (kbd "C-c c") 'org-capture)

;; Use org-refile: Increase heading level
(setq org-refile-targets '((org-agenda-files . (:maxlevel . 6))))

;; Org Roam directory
(setq org-roam-directory "~/org/roam")

(add-hook 'text-mode-hook 'flyspell-mode)

(setq display-line-numbers-type t)

(setq ivy-posframe-display-functions-alist
      '((swiper                     . ivy-posframe-display-at-point)
        (complete-symbol            . ivy-posframe-display-at-point)
        (counsel-M-x                . ivy-display-function-fallback)
        (counsel-esh-history        . ivy-posframe-display-at-window-center)
        (counsel-describe-function  . ivy-display-function-fallback)
        (counsel-describe-variable  . ivy-display-function-fallback)
        (counsel-find-file          . ivy-display-function-fallback)
        (counsel-recentf            . ivy-display-function-fallback)
        (counsel-register           . ivy-posframe-display-at-frame-bottom-window-center)
        (dmenu                      . ivy-posframe-display-at-frame-top-center)
        (nil                        . ivy-posframe-display))
      ivy-posframe-height-alist
      '((swiper . 20)
        (dmenu . 20)
        (t . 10)))
(ivy-posframe-mode 1) ; 1 enables posframe-mode, 0 disables it.

(map! :leader
      (:prefix ("v" . "Ivy")
       :desc "Ivy push view" "v p" #'ivy-push-view
       :desc "Ivy switch view" "v s" #'ivy-switch-view))
