;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs

   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()

   ;; List of configuration layers to load. If it is the symbol `all' instead
   ;; of a list then all discovered layers will be installed.
   dotspacemacs-configuration-layers
   '(
     yaml
     php
     sql
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     osx
     auto-completion
     better-defaults
     emacs-lisp
     git
     ruby
     javascript
     html
     version-control
     go
     (go :variables
         go-use-gometalinter t
         go-tab-width 8
         gofmt-command "goimports")

     markdown
     org
     ruby-on-rails
     vagrant
     dash
     (shell :variables
             shell-default-height 30
             shell-default-position 'bottom)
     spell-checking
     syntax-checking
     )

   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages then consider to create a layer, you can also put the
   ;; configuration in `dotspacemacs/config'.
   dotspacemacs-additional-packages
   '(
     editorconfig
     flycheck-gometalinter
     )

   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '()

   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'. (default t)
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."

  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; One of `vim', `emacs' or `hybrid'. Evil is always enabled but if the
   ;; variable is `emacs' then the `holy-mode' is enabled at startup. `hybrid'
   ;; uses emacs key bindings for vim's insert mode, but otherwise leaves evil
   ;; unchanged. (default 'vim)
   dotspacemacs-editing-style 'vim

   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner `random

   ;; List of items to show in the startup buffer. If nil it is disabled.
   ;; Possible values are: `recents' `bookmarks' `projects'.
   ;; (default '(recents projects))
   dotspacemacs-startup-lists '(recents projects)

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light
                         solarized-light
                         solarized-dark
                         leuven
                         monokai
                         zenburn)

   ;; If non nil the cursor color matches the state color.
   dotspacemacs-colorize-cursor-according-to-state t

   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Han Code JP N"
                               :size 16
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)

   ;; The leader key
   dotspacemacs-leader-key "SPC"

   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"

   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","

   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m)
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"

   ;; The command key used for Evil commands (ex-commands) and
   ;; Emacs commands (M-x).
   ;; By default the command key is `:' so ex-commands are executed like in Vim
   ;; with `:' and Emacs commands are executed with `<leader> :'.
   dotspacemacs-command-key ":"

   ;; If non nil `Y' is remapped to `y$'. (default t)
   dotspacemacs-remap-Y-to-y$ t

   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache

   ;; If non nil then `ido' replaces `helm' for some commands. For now only
   ;; `find-files' (SPC f f), `find-spacemacs-file' (SPC f e s), and
   ;; `find-contrib-file' (SPC f e c) are replaced. (default nil)
   dotspacemacs-use-ido nil

   ;; If non nil, `helm' will try to miminimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil

   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil

   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom

   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-micro-state nil

   ;; Which-key delay in seconds. he which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.1

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 60

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90

   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t

   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters the
   ;; point when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non nil advises quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")

   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init'.  You are free to put any
user code."

  (setq warning-minimum-level :emergency)
  (setq ispell-program-name "aspell")
  ;;------------------------------------------------------------------------------
  ;; mode
  ;;------------------------------------------------------------------------------
  (add-to-list 'auto-mode-alist '("\\.php$"     . php-mode))
  (add-to-list 'auto-mode-alist '("\\.phtml$"     . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php$" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.jsp$"       . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x$"   . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb$"       . web-mode))
  (add-to-list 'auto-mode-alist '("\\.ctp?$"      . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?$"     . web-mode))
  (add-to-list 'auto-mode-alist '("\\.js$"        . js2-mode))

  (setq-default c-basic-offset 4
                tab-width 4
                indent-tabs-mode t)

)

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
 This function is called at the very end of Spacemacs initialization after
layers configuration. You are free to put any user code."
  (setq-default dotspacemacs-line-numbers t)
  (setq powerline-default-separator 'arrow)
  (setq flycheck-display-errors-delay 0.3)

  ;;------------------------------------------------------------------------------
  ;; 矩形選択のキーバインドを C-cb に設定
  ;;------------------------------------------------------------------------------
  (cua-mode t)
  (setq cua-enable-cua-keys nil) ;; cua-mode の不要なキーバインドは除去
  (global-set-key (kbd "\C-cb") 'cua-set-rectangle-mark)

  ;;------------------------------------------------------------------------------
  ;; C-hをBackspaceに割り当て
  ;;------------------------------------------------------------------------------
  (global-set-key "\C-h" 'delete-backward-char)

  ;;------------------------------------------------------------------------------
  ;; C-x o の other-window を C-o にバインド
  ;;------------------------------------------------------------------------------
  (define-key global-map (kbd "C-o") 'other-window)

  ;;------------------------------------------------------------------------------
  ;; 行番号表示
  ;;------------------------------------------------------------------------------
  (global-linum-mode 1)
  (setq linum-format "%4d ")
  (global-set-key [f6] 'linum-mode)

  ;;------------------------------------------------------------------------------
  ;; helm
  ;;------------------------------------------------------------------------------
  (global-set-key (kbd "C-x p") 'helm-for-files)
  (global-set-key (kbd "C-x C-r") 'helm-recentf)
  (global-set-key (kbd "C-x C-a") 'helm-ag)
  (global-set-key (kbd "M-y") 'helm-show-kill-ring)

  ;;------------------------------------------------------------------------------
  ;; tree-undo
  ;;------------------------------------------------------------------------------
  (global-set-key (kbd "M-/") 'undo-tree-redo)

  ;;------------------------------------------------------------------------------
  ;; magit
  ;;------------------------------------------------------------------------------
  (global-set-key (kbd "C-x g") 'magit-status)
  (global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)

  ;;------------------------------------------------------------------------------
  ;; デフォルトのインデント幅は4, タブか半角スペースかはプロジェクトに合わせる
  ;;------------------------------------------------------------------------------
  (setq-default tab-width 4 indent-tabs-mode t)

  ;;------------------------------------------------------------------------------
  ;; web-mode-hook
  ;;------------------------------------------------------------------------------
  (defun my-web-mode-hook ()
    (setq
     web-mode-css-offset    4
     web-mode-script-offset 4
     web-mode-php-offset    4
     web-mode-asp-offset    4
     web-mode-markup-indent-offset   4
     indent-tabs-mode       t
     web-mode-engines-alist
     '(("php"    . "\\.ctp\\'"))
     )
  )
  (add-hook 'web-mode-hook 'my-web-mode-hook)

  ;;------------------------------------------------------------------------------
  ;; php-mode-hook
  ;;------------------------------------------------------------------------------
  (add-hook 'php-mode-hook
     (lambda ()
       (c-set-offset 'case-label' 4)
       (c-set-offset 'arglist-intro' 4)
       (c-set-offset 'arglist-cont-nonempty' 4)
       (c-set-offset 'arglist-close' 0)
       (setq indent-tabs-mode t)
     )
  )

  ;;------------------------------------------------------------------------------
  ;; js2-mode-hook
  ;;------------------------------------------------------------------------------
  (add-hook 'js2-mode-hook
            (lambda ()
              (c-set-offset 'case-label' 4)
              (c-set-offset 'arglist-intro' 4)
              (c-set-offset 'arglist-cont-nonempty' 4)
              (c-set-offset 'arglist-close' 0)
              (setq indent-tabs-mode t)
              )
  )

  ;;------------------------------------------------------------------------------
  ;; editorconfig
  ;;------------------------------------------------------------------------------
  (setq edconf-exec-path "/usr/local/bin/editorconfig")

  ;;------------------------------------------------------------------------------
  ;; whitespace設定
  ;;------------------------------------------------------------------------------
  (setq whitespace-style '(face           ; faceで可視化
                           trailing       ; 行末
                           tabs           ; タブ
                           empty          ; 先頭/末尾の空行
                           space-mark     ; 表示のマッピング
                           tab-mark
                           ))

  (setq whitespace-display-mappings
        '((tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))

  (global-whitespace-mode 1)
  (setq indent-tabs-mode t)

  ;; skips 'vendor' directories and sets GO15VENDOREXPERIMENT=1
  (setq flycheck-gometalinter-vendor t)
  ;; only show errors
  (setq flycheck-gometalinter-errors-only t)
  ;; only run fast linters
  (setq flycheck-gometalinter-fast t)
  ;; use in tests files
  (setq flycheck-gometalinter-test t)
  ;; disable linters
  (setq flycheck-gometalinter-disable-linters '("gotype" "gocyclo"))
  ;; Only enable selected linters
  (setq flycheck-gometalinter-disable-all t)
  (setq flycheck-gometalinter-enable-linters '("golint"))
  ;; Set different deadline (default: 5s)
  (setq flycheck-gometalinter-deadline "5s")
)

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(helm-ext org-mime ghub yaml-mode xterm-color ws-butler winum web-mode web-beautify vagrant-tramp vagrant uuidgen unfill toc-org tagedit sql-indent spaceline slim-mode shell-pop scss-mode sass-mode rvm ruby-tools ruby-test-mode rubocop rspec-mode robe reveal-in-osx-finder restart-emacs rbenv pug-mode projectile-rails rake inflections phpunit phpcbf php-extras php-auto-yasnippets persp-mode pbcopy spinner osx-trash osx-dictionary orgit org-projectile org-category-capture org-present org-pomodoro alert log4e gntp org-plus-contrib org-download org-bullets mwim multi-term mmm-mode minitest markdown-toc markdown-mode lorem-ipsum livid-mode skewer-mode simple-httpd link-hint less-css-mode launchctl json-snatcher json-reformat js2-refactor multiple-cursors js-doc hydra htmlize hl-todo parent-mode hide-comnt help-fns+ projectile request helm-flx helm-dash helm-css-scss helm-company helm-c-yasnippet haml-mode go-guru go-eldoc gnuplot gitignore-mode git-link git-gutter-fringe+ git-gutter-fringe fringe-helper git-gutter+ git-gutter gh-md fuzzy flyspell-correct-helm flyspell-correct flycheck-pos-tip pos-tip flycheck pkg-info epl flx feature-mode eyebrowse evil-visual-mark-mode evil-unimpaired evil-mc evil-magit magit magit-popup git-commit with-editor evil-lisp-state evil-indent-plus iedit evil-ediff anzu evil goto-chg undo-tree highlight eshell-z eshell-prompt-extras esh-help emmet-mode editorconfig dumb-jump f drupal-mode php-mode diminish dash-at-point company-web web-completion-data company-tern dash-functional tern dash company-go go-mode column-enforce-mode chruby bundler inf-ruby bind-map bind-key auto-yasnippet auto-compile packed ace-jump-helm-line helm avy helm-core async ac-ispell auto-complete popup flycheck-gometalinter yasnippet json-mode js2-mode diff-hl company-statistics company coffee-mode window-numbering which-key volatile-highlights vi-tilde-fringe use-package tt-mode spray spacemacs-theme smooth-scrolling smeargle smartparens s rainbow-delimiters quelpa powerline popwin pcre2el paradox page-break-lines open-junk-file neotree move-text magit-gitflow macrostep linum-relative leuven-theme info+ indent-guide ido-vertical-mode hungry-delete highlight-parentheses highlight-numbers highlight-indentation helm-themes helm-swoop helm-projectile helm-mode-manager helm-make helm-gitignore helm-descbinds helm-ag google-translate golden-ratio gitconfig-mode gitattributes-mode git-timemachine git-messenger flx-ido fill-column-indicator fancy-battery expand-region exec-path-from-shell evil-visualstar evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-matchit evil-leader evil-jumper evil-indent-textobject evil-iedit-state evil-exchange evil-escape evil-args evil-anzu eval-sexp-fu elisp-slime-nav define-word clean-aindent-mode buffer-move auto-highlight-symbol auto-dictionary aggressive-indent adaptive-wrap ace-window ace-link)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))
