set encoding=utf-8
scriptencoding utf-8
" ↑1行目は読み込み時の文字コードの設定
" ↑2行目はVim Script内でマルチバイトを使う場合の設定
" Vim scritptにvimrcも含まれるので、日本語でコメントを書く場合は先頭にこの設定が必要になる
"
" release autogroup in MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END

" like Spacemacs
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"

" ノーマルモード時だけ ; と : を入れ替える
nnoremap ;  :
nnoremap :  ;
vnoremap ;  :
vnoremap :  ;

"----------------------------------------------------------
" vim-plug
"----------------------------------------------------------

if has('vim_starting')
  set rtp+=~/.vim/plugged/vim-plug
  if !isdirectory(expand('~/.vim/plugged/vim-plug'))
    echo 'install vim-plug...'
    call system('mkdir -p ~/.vim/plugged/vim-plug')
    call system('git clone https://github.com/junegunn/vim-plug.git ~/.vim/plugged/vim-plug/autoload')
  end
endif

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-plug',
      \ {'dir': '~/.vim/plugged/vim-plug/autoload'}
"もて
" インストールするVimプラグインを以下に記述
" ステータスラインの表示内容強化
Plug 'itchyny/lightline.vim'
" 末尾の全角半角空白文字を赤くハイライト
Plug 'ntpeters/vim-better-whitespace'
" 構文エラーチェック
Plug 'scrooloose/syntastic'
" プロジェクトに入ってるESLintを読み込む
Plug 'pmsorhaindo/syntastic-local-eslint.vim'


"初心者
" コメントON/OFFを手軽に実行
Plug 'tomtom/tcomment_vim'
" ファイルをtree表示してくれる
Plug 'cocopon/vaffle.vim'

"自分でいれたやつ
"自動でかっこつけてくれるやつ
Plug 'cohama/lexima.vim'
"透明
Plug 'miyakogi/seiya.vim'
"fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" 散文
Plug 'junegunn/goyo.vim'
"git
Plug 'tpope/vim-fugitive'
" コード整形
Plug 'junegunn/vim-easy-align'
" インデント可視化
Plug 'Yggdroot/indentLine'
" git追加、削除箇所
Plug 'airblade/vim-gitgutter'
" pep8 インデント
Plug 'Vimjas/vim-python-pep8-indent'
" カラースキーム
Plug 'gosukiwi/vim-atom-dark'
" 検索結果
Plug 'osyo-manga/vim-anzu'
" http REST
Plug 'baverman/vial-http'
" PHP html インデント
Plug 'captbaritone/better-indent-support-for-php-with-html'
" filer
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler'

" surround
Plug 'tpope/vim-surround'

" processing
Plug 'sophacles/vim-processing'

" コードの自動補完
Plug 'Shougo/neocomplete.vim'
" スニペットの補完機能
Plug 'Shougo/neosnippet.vim'
" スニペット集
Plug 'Shougo/neosnippet-snippets'
" vim-startify
Plug 'mhinz/vim-startify'
" vim-multiple-cursors
Plug 'terryma/vim-multiple-cursors'
" shell command
Plug 'b4b4r07/vim-shellutils'

" grep
Plug 'mileszs/ack.vim'

" tex
Plug 'lervag/vimtex'

call plug#end()
"-------- vim-plug end------

""""""""""""""""""""""""
"check
""""""""""""""""""""""""
let s:plug = {
      \ "plugs": get(g:, 'plugs', {})
      \ }

function! s:plug.is_installed(name)
  return has_key(self.plugs, a:name) ? isdirectory(self.plugs[a:name].dir) : 0
endfunction


" -------- plugin setting ---------------

"----------------------------------------------------------
" カラースキーム
"----------------------------------------------------------
if s:plug.is_installed('vim-atom-dark')
  syntax enable
  set t_Co=256
  colorscheme atom-dark-256
endif

"モテ

"----------------------------------------------------------
" neocomplete・neosnippetの設定
"----------------------------------------------------------
" <TAB>: completion.
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
" imap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

if has('lua') && v:version >= 703 && has('patch885')
  if s:plug.is_installed('neocomplete.vim')
    " Vim起動時にneocompleteを有効にする
    let g:neocomplete#enable_at_startup = 1
    " smartcase有効化. 大文字が入力されるまで大文字小文字の区別を無視する
    let g:neocomplete#enable_smart_case = 1
    " 3文字以上の単語に対して補完を有効にする
    let g:neocomplete#min_keyword_length = 3
    " 区切り文字まで補完する
    let g:neocomplete#enable_auto_delimiter = 1
    " 1文字目の入力から補完のポップアップを表示
    let g:neocomplete#auto_completion_start_length = 1
    " バックスペースで補完のポップアップを閉じる
    inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"
  endif
  " else
  " 	if s:plug.is_installed('neocomplecache.vim')
  " 		2013-07-03 14:30 原因不明だがNeoComplCacheEnableコマンドが見つからないので変更
  " 		let g:neocomplcache_enable_at_startup = 1
  " 		let g:acp_enableAtStartup = 0
  " 		let g:neocomplcache_enable_smart_case = 1
  " 		NeoComplCacheを有効化
  " 		NeoComplCacheEnable
  " 	endif
endif

"----------------------------------------------------------
" Syntastic
"----------------------------------------------------------
" 構文エラー行に「>>」を表示
let g:syntastic_enable_signs = 1
" 他のVimプラグインと競合するのを防ぐ
let g:syntastic_always_populate_loc_list = 1
" 構文エラーリストを非表示
" let g:syntastic_auto_loc_list = 0
" ファイルを開いた時に構文エラーチェックを実行する
let g:syntastic_check_on_open = 1

" Javascript用. 構文エラーチェックにESLintを使用
let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_python_checkers = ['pyflakes', 'pep8']

" python syntastic check
" 複数指定する場合はカンマ区切り
let g:pep8_ignore = 'E501'
" 複数指定する場合はカンマ区切り
let g:syntastic_python_pep8_args = '--ignore="E501"'

let g:syntastic_check_on_wq = 0
" hi SyntasticErrorSign ctermfg=blue
" hi SyntasticWarningSign ctermfg=green

"脱初心者
""""""""""""""""""""""""""""""
" 全角スペースの表示
""""""""""""""""""""""""""""""
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme * call ZenkakuSpace()
    autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
  augroup END
  call ZenkakuSpace()
endif
""""""""""""""""""""""""""""""

"---- 自分でいれたやつ -------


"透明
let g:seiya_auto_enable=1

" Align設定
vmap <Enter> <Plug>(EasyAlign)

""""""
" indentLine
""""""
let g:indentLine_color_term=255
let g:indentLine_color_gui='#FFFFFF'
let g:indentLine_char='¦'
let g:indentLine_faster = 1
let g:indentLine_fileTypeExclude = ['help', 'startify']

""""""
" GitGutter
""""""
nmap <leader>hj <Plug>GitGutterNextHunk
nmap <leader>hk <Plug>GitGutterPrevHunk
" let g:gitgutter_highlight_lines = 1
set updatetime=250
" Show gitgutter column always
set signcolumn=yes

""""""
" vim-anzu
""""""
" mapping
nmap n <Plug>(anzu-n)
nmap N <Plug>(anzu-N)
nmap * <Plug>(anzu-star)
nmap # <Plug>(anzu-sharp)
augroup vim-anzu
  " ウインドウを移動したとき、タブを移動したときに
  " 検索ヒット数の表示を消去する
  autocmd!
  " autocmd CursorHold,CursorHoldI,WinLeave,TabLeave * call anzu#clear_search_status()
  autocmd WinLeave,TabLeave * call anzu#clear_search_status()
augroup END

""""""
" ステータスライン
""""""
" 'readonly': 'MyReadonly',
let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'mode_map': {'c': 'NORMAL'},
      \ 'active': {
      \   'left': [ ['mode', 'paste'], ['filename', 'fugitive', 'anzu'] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component': {
      \   'lineinfo': '%3l:%-2v',
      \ },
      \ 'component_function': {
      \   'modified': 'MyModified',
      \   'fugitive': 'MyFugitive',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'anzu': 'anzu#search_status',
      \   'mode': 'MyMode',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ }
      \ }

" let g:syntastic_mode_map = { 'mode': 'passive' }
augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost * call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'RO' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head') && strlen(fugitive#head())
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction


""""""
" vimfiler
""""""

"data_directory はramdiskを指定
" if has('win32')
" 	let g:vimfiler_data_directory = 'R:\.vimfiler'
" elseif  has('macunix')
" 	let g:vimfiler_data_directory = '/Volumes/RamDisk/.vimfiler'
" else
" 	let g:vimfiler_data_directory = '/mnt/ramdisk/.vimfiler'
" endif

"vimデフォルトのエクスプローラをvimfilerで置き換える
let g:vimfiler_as_default_explorer = 1
"セーフモードを無効にした状態で起動する
let g:vimfiler_safe_mode_by_default = 0
"現在開いているバッファのディレクトリを開く
nnoremap <silent> <leader>d :<C-u>VimFilerBufferDir -quit<CR>
"現在開いているバッファをIDE風に開く
nnoremap <silent> <leader>tr :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>

"デフォルトのキーマッピングを変更
augroup vimrc
  autocmd FileType vimfiler call s:vimfiler_my_settings()
augroup END
function! s:vimfiler_my_settings()
  nmap <buffer> q <Plug>(vimfiler_exit)
  nmap <buffer> Q <Plug>(vimfiler_hide)
endfunction

"----------------------------------------------------------
" startify
"----------------------------------------------------------
" When opening a file or bookmark, seek and change to the root directory of the VCS (if there is one).
let g:startify_change_to_vcs_root = 1

let g:startify_files_number = 5
let g:startify_list_order = [
      \ ['♻  最近使ったファイル:'],
      \ 'files',
      \ ['♲  最近使ったファイル(カレントディレクトリ下):'],
      \ 'dir',
      \ ['⚑  セッション:'],
      \ 'sessions',
      \ ['☺  ブックマーク:'],
      \ 'bookmarks',
      \ ]
let g:startify_bookmarks = ["~/.vimrc"]
let g:startify_custom_indices = ['f', 'g', 'd', 's', 'a', 't', 'r', 'w', 'b', 'v', 'c']

" ASCII ARTを真ん中寄せする
" :h startifyを参照
function! s:filter_header(lines) abort
  let longest_line   = max(map(copy(a:lines), 'len(v:val)'))
  let centered_lines = map(copy(a:lines),
        \ 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
  return centered_lines
endfunction
let g:startify_custom_header = s:filter_header([
      \ "        ________ ++     ________ ",
      \ "       /VVVVVVVV\++++  /VVVVVVVV\ ",
      \ "       \VVVVVVVV/++++++\VVVVVVVV/ ",
      \ "        |VVVVVV|++++++++/VVVVV/' ",
      \ "        |VVVVVV|++++++/VVVVV/' ",
      \ "       +|VVVVVV|++++/VVVVV/'+ ",
      \ "     +++|VVVVVV|++/VVVVV/'+++++ ",
      \ "   +++++|VVVVVV|/VVV___++++++++++ ",
      \ "     +++|VVVVVVVVVV/##/ +_+_+_+ ",
      \ "       +|VVVVVVVVV___ +/#_#,#_#, ",
      \ "        |VVVVVVV//##/+/#/+/#/'/#/ ",
      \ "        |VVVVV/'+/#/+/#/+/#/ /#/ ",
      \ "        |VVV/'++/#/+/#/ /#/ /#/ ",
      \ "        'V/'  /##//##//##//###/ ",
      \ "                 ++ ",
      \ ])

"----------------------------------------------------------
" multiple-cursors
"----------------------------------------------------------
function! Multiple_cursors_before()
  if exists(':NeoCompleteLock')==2
    exe 'NeoCompleteLock'
  endif
endfunction

function! Multiple_cursors_after()
  if exists(':NeoCompleteUnlock')==2
    exe 'NeoCompleteUnlock'
  endif
endfunction

"----------------------------------------------------------
" whitespace
"----------------------------------------------------------
let g:better_whitespace_filetypes_blacklist=['startify', 'vimfiler']

"----------------------------------------------------------
" fzf
"----------------------------------------------------------

nnoremap <leader>b :Buffers<CR>
nnoremap <leader>c :Commands<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>a :Ag<CR>
nnoremap <leader>x :bd<CR>
command! FZFMru call fzf#run({
      \  'source':  v:oldfiles,
      \  'sink':    'e',
      \  'options': '-m -x +s',
      \  'down':    '40%'})
nnoremap <Space>r :FZFMru<CR>

" " Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
"
" " Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)


"----------------------------------------------------------
" ack
"----------------------------------------------------------
let g:ackprg = 'ag --nogroup --nocolor --column'

"----------------------------------------------------------
" goyo
"----------------------------------------------------------
function! ProseMode()
  call goyo#execute(0, [])
  " set spell noci nosi noai nolist noshowmode noshowcmd
  set complete+=s
  " colorscheme delek
endfunction

command! ProseMode call ProseMode()
nnoremap <leader>g :ProseMode<CR>

"----------------------------------------------------------
" tex
"----------------------------------------------------------
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.tex = g:vimtex#re#neocomplete
let g:vimtex_compiler_latexmk = { 'continuous' : 0 }
let g:vimtex_quickfix_open_on_warning = 0
"---------- plugin setting end ---------



" --------- vim setting --------
"----------------------------------------------------------
" 文字
"----------------------------------------------------------
set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 " 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される
set ambiwidth=double " □や○文字が崩れる問題を解決

"----------------------------------------------------------
" ステータスライン
"----------------------------------------------------------
set laststatus=2 " ステータスラインを常に表示
set showmode " 現在のモードを表示
set showcmd " 打ったコマンドをステータスラインの下に表示
set ruler " ステータスラインの右側にカーソルの位置を表示する

"----------------------------------------------------------
" コマンドモード
"----------------------------------------------------------
set wildmenu " コマンドモードの補完
set history=5000 " 保存するコマンド履歴の数

"----------------------------------------------------------
" タブ・インデント
"----------------------------------------------------------
"""""""""""""""""""""""""
"      インデント
""""""""""""""""""""""""
set autoindent          "改行時に前の行のインデントを計測
set smartindent         "改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set cindent             "Cプログラムファイルの自動インデントを始める
set smarttab            "新しい行を作った時に高度な自動インデントを行う
set noexpandtab         " タブをタブとして扱う(スペースに展開しない)

set tabstop=4           "タブを含むファイルを開いた際, タブを何文字の空白に変換するか
set shiftwidth=4        "自動インデントで入る空白数
" set softtabstop=0       "キーボードから入るタブの数

if has("autocmd")
  "ファイルタイプの検索を有効にする
  filetype plugin on
  "ファイルタイプに合わせたインデントを利用
  filetype indent on
  "sw=softtabstop, sts=shiftwidth, ts=tabstop, et=expandtabの略
  autocmd FileType c           setlocal sw=4 sts=4 ts=4
  autocmd FileType ruby        setlocal sw=2 sts=2 ts=2
  autocmd FileType javascript  setlocal sw=2 sts=2 ts=2 et
  autocmd FileType zsh         setlocal sw=4 sts=4 ts=4
  autocmd FileType python      setlocal sw=4 sts=4 ts=4 et
  autocmd FileType scala       setlocal sw=4 sts=4 ts=4
  autocmd FileType json        setlocal sw=4 sts=4 ts=4
  autocmd FileType html        setlocal sw=4 sts=4 ts=4
  autocmd FileType css         setlocal sw=2 sts=2 ts=2
  autocmd FileType scss        setlocal sw=2 sts=2 ts=2
  autocmd FileType sass        setlocal sw=4 sts=4 ts=4
  autocmd FileType php         setlocal sw=4 sts=4 ts=4
  autocmd FileType vim         setlocal sw=2 sts=2 ts=2 et
endif

"----------------------------------------------------------
" 文字列検索
"----------------------------------------------------------
set incsearch  " インクリメンタルサーチ. １文字入力毎に検索を行う
set ignorecase " 検索パターンに大文字小文字を区別しない
set smartcase  " 検索パターンに大文字を含んでいたら大文字小文字を区別する
set hlsearch   " 検索結果をハイライト

" バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

" ESCキー2度押しでハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>
" ESCを二回押すことでハイライトを消す
" nmap <silent> <Esc><Esc> :nohlsearch<CR>

"----------------------------------------------------------
" 編集関係 edit setting
"----------------------------------------------------------
set shiftround          " '<'や'>'でインデントする際に'shiftwidth'の倍数に丸める
set infercase           " 補完時に大文字小文字を区別しない
set hidden              " バッファを閉じる代わりに隠す（Undo履歴を残すため）
set switchbuf=useopen   " 新しく開く代わりにすでに開いてあるバッファを開く
set showmatch           " 対応する括弧などをハイライト表示する
set matchtime=3         " 対応括弧のハイライト表示を3秒にする

" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>

source $VIMRUNTIME/macros/matchit.vim " Vimの「%」を拡張する

" バックスペースでなんでも消せるようにする
set backspace=indent,eol,start

" クリップボードにコピー
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Swapファイル？Backupファイル？前時代的すぎ
" なので全て無効化する
" set nowritebackup
" set nobackup
" set noswapfile

"----------------------------------------------------------
" 表示関係 display setting
"----------------------------------------------------------
"色付け
syntax on
autocmd BufNewFile,BufRead *.ctp set filetype=php
set list           " 不可視文字の可視化
" set number         " 行番号の表示
set wrap           " 長いテキストの折り返し
set textwidth=0    " 自動的に改行が入るのを無効化
" set colorcolumn=80 " その代わり80文字目にラインを入れる
set cursorline     " カーソルラインをハイライト

" 前時代的スクリーンベルを無効化
set t_vb=
set novisualbell

" デフォルト不可視文字は美しくないのでUnicodeで綺麗に
" set listchars=tab:\»\ ,trail:-,extends:»,precedes:«,nbsp:%,eol:↲
set listchars=tab:\»\ ,extends:»,precedes:«,nbsp:%
" tab
augroup set-tab-highlight
  autocmd!
  " autocmd ColorScheme,GUIEnter * highlight SpecialKey guifg=None guibg=None
  " autocmd ColorScheme,VimEnter * highlight SpecialKey ctermfg=None ctermbg=None
augroup END

"----------------------------------------------------------
" マクロおよびキー設定 keymap
"----------------------------------------------------------
" 行末
nnoremap H  ^
nnoremap L  $

" 検索
nnoremap * *<C-o>
nnoremap g* g*<C-o>

" インデント
vnoremap > >gv
vnoremap < <gv

" 向きがそろえる
" nnoremap <expr> n <SID>search_forward_p() ? 'nzv' : 'Nzv'
" nnoremap <expr> N <SID>search_forward_p() ? 'Nzv' : 'nzv'
" vnoremap <expr> n <SID>search_forward_p() ? 'nzv' : 'Nzv'
" vnoremap <expr> N <SID>search_forward_p() ? 'Nzv' : 'nzv'
"
" function! s:search_forward_p()
"   return exists('v:searchforward') ? v:searchforward : 1
" endfunction

" ファイル保存
nnoremap <leader>w  :<C-u>w<CR>
nnoremap <leader>q  :<C-u>q<CR>
nnoremap <leader>Q  :<C-u>q!<CR>

" 空行の挿入
nnoremap <silent><leader>o  :<C-u>for i in range(v:count1) \| call append(line('.'), '') \| endfor<CR>
nnoremap <silent><leader>O  :<C-u>for i in range(v:count1) \| call append(line('.')-1, '') \| endfor<CR>

" ペースト
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" タブ
nnoremap <silent> tt  :<C-u>tabe<CR>
nnoremap <C-h>  gT
nnoremap <C-l>  gt

" 危険なキー
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

nnoremap Q gq

" バックスペースキーの有効化
set backspace=indent,eol,start

" jjでエスケープ
inoremap <silent> jj <ESC>

" 日本語入力で”っj”と入力してもEnterキーで確定させればインサートモードを抜ける
inoremap <silent> っj <ESC>

" 日本語入力がオンのままでも使えるコマンド(Enterキーは必要)
nnoremap あ a
nnoremap い i
nnoremap う u
nnoremap お o
nnoremap っd dd
nnoremap っy yy

" 置換
nnoremap gs  :<C-u>%s///g<Left><Left><Left>
vnoremap gs  :s///g<Left><Left><Left>

" コマンドライン emacsライク
cnoremap <C-f>  <Right>
cnoremap <C-b>  <Left>
cnoremap <C-a>  <C-b>
cnoremap <C-e>  <C-e>
cnoremap <C-u> <C-e><C-u>
cnoremap <C-v> <C-f>a

" text
onoremap aa  a>
onoremap ia  i>
onoremap ar  a]
onoremap ir  i]
onoremap ad  a"
onoremap id  i"

set whichwrap=b,s,h,l,<,>,[,],~ " カーソルの左右移動で行末から次の行の行頭への移動が可能になる

" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap k   gk
nnoremap j   gj
vnoremap k   gk
vnoremap j   gj
nnoremap gk  k
nnoremap gj  j
vnoremap gk  k
vnoremap gj  j

" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
" nnoremap n nzz
" nnoremap N Nzz
" nnoremap * *zz
" nnoremap # #zz
" nnoremap g* g*zz
" nnoremap g# g#zz

" vを二回で行末まで選択
vnoremap v $h

" TABにて対応ペアにジャンプ
nnoremap <Tab> %
vnoremap <Tab> %

" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>

" T + ? で各種設定をトグル
nnoremap [toggle] <Nop>
nmap T [toggle]
nnoremap <silent> [toggle]s :setl spell!<CR>:setl spell?<CR>
nnoremap <silent> [toggle]l :setl list!<CR>:setl list?<CR>
nnoremap <silent> [toggle]t :setl expandtab!<CR>:setl expandtab?<CR>
nnoremap <silent> [toggle]w :setl wrap!<CR>:setl wrap?<CR>

" make, grep などのコマンド後に自動的にQuickFixを開く
autocmd MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep copen

" QuickFixおよびHelpでは q でバッファを閉じる
autocmd MyAutoCmd FileType help,qf nnoremap <buffer> q <C-w>c

" :e などでファイルを開く際にフォルダが存在しない場合は自動作成
function! s:mkdir(dir, force)
  if !isdirectory(a:dir) && (a:force ||
        \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction
autocmd MyAutoCmd BufWritePre * call s:mkdir(expand('<afile>:p:h'), v:cmdbang)

" vim 起動時のみカレントディレクトリを開いたファイルの親ディレクトリに指定
autocmd MyAutoCmd VimEnter * call s:ChangeCurrentDir('', '')
function! s:ChangeCurrentDir(directory, bang)
  if a:directory == ''
    lcd %:p:h
  else
    execute 'lcd' . a:directory
  endif

  if a:bang == ''
    pwd
  endif
endfunction

" ~/.vimrc.localが存在する場合のみ設定を読み込む
let s:local_vimrc = expand('~/.vimrc.local')
if filereadable(s:local_vimrc)
  execute 'source ' . s:local_vimrc
endif

"画面分割
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>

"call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
"call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
"call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
"call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
"call submode#map('bufmove', 'n', '', '>', '<C-w>>')
"call submode#map('bufmove', 'n', '', '<', '<C-w><')
"call submode#map('bufmove', 'n', '', '+', '<C-w>+')
"call submode#map('bufmove', 'n', '', '-', '<C-w>-')

"----------------------------------------------------------
" マウスでカーソル移動とスクロール
"----------------------------------------------------------
" if has('mouse')
" 	set mouse=a
" 	if has('mouse_sgr')
" 		set ttymouse=sgr
" 	elseif v:version > 703 || v:version is 703 && has('patch632')
" 		set ttymouse=sgr
" 	else
" 		set ttymouse=xterm2
" 	endif
" endif

"----------------------------------------------------------
" クリップボードからのペースト
"----------------------------------------------------------
" 挿入モードでクリップボードからペーストする時に自動でインデントさせないようにする
if &term =~ "xterm"
  let &t_SI .= "\e[?2004h"
  let &t_EI .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction

  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

" clipboard
set clipboard=unnamed,autoselect

"html閉じタグ自動補完
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
augroup END

" --------- vim setting end--------
