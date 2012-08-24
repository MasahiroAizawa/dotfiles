" vim:set foldmethod=marker
" check key map -> :verbose [in]map
"neobundle {{{

"NeoBundle 準備
set nocompatible
filetype off
filetype plugin indent off

if has('vim_starting')
  let g:default_runtimepath=&runtimepath
endif
exec 'set runtimepath='.g:default_runtimepath
set runtimepath& runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#rc(expand('~/.vim/bundle/'))

"colorscheme
NeoBundle 'Solarized'

"vim-script by Shougo
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/vimfiler'

"vim-scritps repo
NeoBundle 'vim-scripts/taglist.vim'

"programming
NeoBundle 'motemen/git-vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'gregsexton/gitv'
NeoBundle 'https://github.com/tpope/vim-fugitive.git'
"Scala
NeoBundle 'vim-scala'
NeoBundle 'scala.vim'
"Ruby
NeoBundle 'tpope/vim-rails'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'endwise.vim'
NeoBundle 'thinca/vim-ref'
"CoffeeScript
NeoBundle 'https://github.com/kchmck/vim-coffee-script.git'
"zencoding-vim
NeoBundle 'mattn/zencoding-vim'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/gist-vim'
"memo
NeoBundle 'migrs/qfixhowm'
"YankRing
NeoBundle 'vim-scripts/YankRing.vim'

"File Explorer
NeoBundle 'scrooloose/nerdtree'

"Rsense for ruby. dummy
NeoBundle 'rsense'
if filereadable(expand('~/.vim/bundle/rsense/rsense.vim'))
  source ~/.vim/bundle/rsense/rsense.vim
endif

"My plugin
NeoBundle 'MasahiroAizawa/helptags-vim'

"JavaScript
NeoBundle 'scrooloose/syntastic'
"HTML5 syntax
NeoBundle 'othree/html5.vim'
NeoBundle 'pauloalem/matchit'
NeoBundle 'hokaccha/vim-html5validator'
NeoBundle 'groenewege/vim-less'

"neobundle }}}

"基本的な設定 {{{

"キーマッピング
nnoremap J gJ
nnoremap gJ J

"バックアップファイル系
set backupdir=~/.vim/backup
set directory=~/.vim/backup

syntax on
set number
set list
set listchars=eol:$,tab:>;,extends:<
set shiftwidth=2
set tabstop=2
set enc=utf8
set fenc=utf8
set fencs=utf8,iso-2022-p,enc-jp,cp932
set backspace=indent,eol,start
set wildchar=<Tab>
set showmatch
set nosmarttab
set nojoinspaces
set noincsearch
set ruler
set showcmd

set expandtab
set autoindent
set nocompatible
set textwidth=0
filetype on
filetype indent on
filetype plugin on

"行頭のコメントをやめる
set formatoptions-=o
set formatoptions-=r

"分割は右下に
set splitbelow
set splitright

"******** set tags は絶対パスで指定すること ************

"基本的な設定 }}}

"日本語入力 {{{
"日本語入力をリセット
au BufNewFile,BufRead * set iminsert=0

"日本語入力時のカーソル
if has('multi_byte_ime') || has('xim')
	highlight CursorIM guibg=Purple guifg=NONE
endif

"日本語入力 }}}

"折りたたみ {{{
set foldmethod=syntax

"rubyの折りたたみ設定をまねしてみる
set foldlevel=1
set foldnestmax=2

augroup foldmethod-syntax
	autocmd!
	autocmd InsertEnter * if &l:foldmethod ==# 'syntax'
	\                   |   setlocal foldmethod=manual
	\                   | endif
	autocmd InsertLeave * if &l:foldmethod ==# 'manual'
	\                   |   setlocal foldmethod=syntax
	\                   | endif
augroup END
"}}}

"vimrc編集時用の設定 {{{
augroup EditVim
  autocmd!
  "vimrcの時のみ折りたたみパターンを変更
  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType vim setlocal formatoptions-=ro
augroup END

"Open vimrc
nnoremap <Leader>v<Space> :<C-u>edit ~/.vimrc<CR>:e %<CR>
nnoremap <Leader>v<S-Space> :<C-u>edit ~/.gvimrc<CR>:e %<CR>
"Reload vimrc
nnoremap <C-Space><C-Space> :<C-u>source ~/.vimrc<CR>:<C-u>source ~/.gvimrc<CR>:<C-u>e %<CR>

"count vim power
function! CountVimPower()
  new
  read ~/.vimrc
  read ~/.gvimrc
  %s/^\s\+//g
  g/^"/d
  g/^\n/d
  normal G
  let s:linePower = line('.')
  q!
  echo 'Your vim power is ' . s:linePower
endfunction

"vimrc用 }}}

" help {{{
set helplang=en,ja
"}}}

"編集用 {{{

"改行
nnoremap <Leader><Enter> o<ESC>

"検索時に/を入力
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'

":helpのショートカット
nnoremap <C-h> :<C-u>help<Space>

"tabnew
nnoremap <Leader>xt :<C-u>:tabnew<CR>

"diff
nnoremap <Leader>dt :<C-u>diffthis<CR>
nnoremap <Leader>du :<C-u>diffupdate<CR>
nnoremap <Leader>do :<C-u>diffoff<CR>

"編集用 }}}

"書いているコードの実行 {{{

"scalaのコマンド
command! Scalac !scalac %
command! Scala !scala -classpath . %

function! RunProgram()
  let ext = expand("%:e")
  if ext == "rb"
    :w<CR>:!ruby %<CR>
  elseif ext == "scala"
    w
    !scalac %
    !scala -classpath . %<
  endif
endfunction

"書いているコードの実行 }}}

"git ショートカット {{{
"git-vimがあるので設定はほとんど不要

"git push heroku master
nnoremap <Leader>gh :GitPush heroku master<CR>

"git ショートカット }}}

"補完系設定 {{{
"ポップアップメニューの色
hi Pmenu ctermbg=8 guibg=#606060
hi PmenuSel ctermbg=12 guibg=SlateBlue
hi PmenuSbar ctermbg=0 guibg=#404040

"eskk and neocomplcache
let g:gskk#enable_completion = 1

let g:neocomplcache_enable_at_startup = 1

"大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplcache_enable_smart_case = 1

"区切りの補完を有効化
let g:neocomplcache_enable_underbar_completion = 1

"シンタックスをキャッシュする時の最小文字長を3
let g:neocomplcache_min_syntax_length = 4

"Enable heavy omni completion. ruby用
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
"let g:neocomplcache_omni_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

"補完候補が表示されている場合は確定。そうでない場合は改行
"inoremap pumvisible() ? neocomplcache#close_popup() : "\"

" pair close checker.
" from othree vimrc ( http://github.com/othree/rc/blob/master/osx/.vimrc )
function! ClosePair(char)
  if getline('.')[col('.') - 1] == a:char
    return "\"
  else
    return a:char
  endif
endfunction

"補完系設定 }}}

"plugin setting {{{

"VimFiler {{{
let g:vimfiler_as_default_explorer=1
let g:vimfiler_edit_action="tabopen"
let g:vimfiler_safe_mode_by_default=0
"VimFiler }}}

"Gist-Vim {{{
let g:gist_open_browser_after_post = 1
"Gist-Vim }}}

"QFixHowm {{{
if has('mac')
  let howm_dir = '~/Dropbox/private/howm'
elseif has('win64')
  let howm_dir = '~/Dropbox/private/howm'
endif
"QFixHowm }}}

"rubycomplete {{{
"from http://generation1986.g.hatena.ne.jp/ukstudio/20080223
"<TAB>で補完
function! InsertTabWrapper()
  if pumvisible()
    return "\<c-n>"
  endif
  let col = col('.') - 1
  if !col || getline('.')[col -1] !~ '\k\|<\|/'
    return "\<tab>"
  elseif exists('&omnifunc') && &omnifunc == ''
    return "\<c-n>"
  else
    return "\<c-x>\<c-o>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_rails = 0
let g:rubycomplete_classes_in_global = 1
"rubycomplete }}}

"VimShell {{{
nnoremap <Leader>xs :<C-u>10new<CR>:<C-u>VimShell<CR>
let g:vimshell_editor_command="/usr/bin/vim"
"VimShell }}}

" unite.vim {{{

" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q
" unit.vim }}}

" quickrun {{{
let g:quickrun_config = {}
let g:quickrun_config['coffee'] = {'command':'coffee', 'exec':['%c -cbp %s']}
let g:quickrun_config['coffee.script'] = {'command':'coffee', 'exec':['%c -cbp %s; %c %s']}
"}}}

"RSense {{{

let g:rsenseHome = "/Users/masahiro/program/lib/rsense"
let g:rsenseUseOmniFunc = 1

"}}}

" syntastic {{{
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes':['ruby', 'javascript'],
                           \ 'passive_filetypes':[]}
let g:syntastic_javascript_jslint_conf = "--white --undef --nomen --regexp --plusplus --bitwise --newcap --sloppy --vars"
"}}}

" YankRing {{{
nnoremap <silent> <F11> :<C-u>YRShow<CR>
let g:yankring_history_dir = "~/.vim/"
let g:yankring_history_file = ".yankring_history"
"}}}

"Zencoding {{{
let g:user_zen_leader_key = '<C-n>'
"}}}

"plugin }}}

" 色々な設定 {{{
nnoremap <Leader>cs :<C-u>VimShell<CR>
nnoremap <Leader>cf :<C-u>VimFiler<CR>

"末尾のスペースを削除 {{{
function! SaveCursor()
  let g:before_line = line('.')
  let g:before_column = col('.')
endfunction
function! RemoveTailWhiteSpaces()
  silent! %s/\s\+$//g
endfunction
function! RestoreCursor()
  execute "call cursor(" . g:before_line . "," . g:before_column . ")"
endfunction
"}}}

" for program {{{
augroup RubyCompile
  autocmd!
  autocmd BufWritePre * :call SaveCursor()
  autocmd BufWritePre * :call RemoveTailWhiteSpaces()
  autocmd BufWritePost *.rb silent! :make -c % >/dev/null
  autocmd BufWritePost *.coffe silent! :make -c % >/dev/null
  autocmd BufWritePost redraw
  autocmd BufWritePost * :call RestoreCursor()
  autocmd BufWritePost * :cw
augroup END
" }}}

"ファイル名をコピー {{{
function! CopyPath()
  let @*=expand('%:p')
  let @"=expand('%:p')
endfunction
command! CP :call CopyPath()
"}}}

nnoremap <ESC><ESC> :<C-u>noh<CR>

"HTML用 non-break space {{{
inoremap <C-space> &nbsp;
"}}}

" コメント用 {{{
augroup AddSyntax
  autocmd!
  autocmd BufReadPost *.rb syn keyword rubyTodo MEMO NOTE contained
  autocmd BufReadPost *.coffee syn keyword coffeeTodo MEMO NOTE contained
augroup END
"}}}

" }}}

" for Ruby {{{
set tags+=~/program/ruby/.lib_tags

function! RunRspec(line_run)
  let s:filename = expand('%')

  let s:line = ""
  if a:line_run == 1
    let s:line = " -l " . line('.')
  endif

  let s:bufname = "[spec] " . s:filename
  if bufexists(s:bufname)
    let s:bufnum = bufnr(s:bufname)
    execute "bw" . s:bufnum
  endif

  execute "VimShellInteractive rspec " . s:line . " " . s:filename
  nnoremap <silent><buffer> q bw
  silent! file `=s:bufname`
  nnoremap <silent><buffer> q bw
endfunction

command! RunRspec :call RunRspec(0)
command! RunRspecL :call RunRspec(1)

nnoremap <Leader><Space> :<C-u>RunRspec<CR>
nnoremap <Leader><C-Space> :<C-u>RunRspecL<CR>

augroup FileTypeSupport
  autocmd!
  autocmd BufReadPost *.rb,*.coffee setlocal formatoptions-=r
  autocmd BufReadPost *.rb,*.coffee setlocal formatoptions-=o
augroup END

" }}}

" ステータスライン {{{

" from http://d.hatena.ne.jp/ruedap/20110712/vim_statusline_git_branch_name
" ステータスラインの表示
  set statusline=%<     " 行が長すぎるときに切り詰める位置
  set statusline+=[%n]  " バッファ番号
  set statusline+=%m    " %m 修正フラグ
  set statusline+=%r    " %r 読み込み専用フラグ
  set statusline+=%h    " %h ヘルプバッファフラグ
  set statusline+=%w    " %w プレビューウィンドウフラグ
  set statusline+=%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}  " fencとffを表示
  set statusline+=%y    " バッファ内のファイルのタイプ
  set statusline+=\     " 空白スペース
if winwidth(0) >= 130
  set statusline+=%F    " バッファ内のファイルのフルパス
else
  set statusline+=%t    " ファイル名のみ
endif
  set statusline+=%=    " 左寄せ項目と右寄せ項目の区切り
  silent! set statusline+=%{fugitive#statusline()}  " Gitのブランチ名を表示
  set statusline+=\ \   " 空白スペース2個
  set statusline+=%1l   " 何行目にカーソルがあるか
  set statusline+=/
  set statusline+=%L    " バッファ内の総行数
  set statusline+=,
  set statusline+=%c    " 何列目にカーソルがあるか
  set statusline+=%V    " 画面上の何列目にカーソルがあるか
  set statusline+=\ \   " 空白スペース2個
  set statusline+=%P    " ファイル内の何％の位置にあるか
" }}}

"ローカル用の拡張設定 {{{
if exists('~/.vim/ext_vimrc.vim')
  source ~/.vim/ext_vimrc.vim
endif
"}}}
