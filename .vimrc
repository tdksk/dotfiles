"============================================================
" general settings
"============================================================
set shellslash                  " スラッシュを区切りにしてファイル名を展開する
set textwidth=1000              " 右端で折り返さない
set browsedir=current           " Exploreの初期ディレクトリ
set scrolloff=10                " スクロール時の余白
set autoread                    " ファイルが書き換えられたら自動で読み直す
set vb t_vb=                    " ビープ音を鳴らさない

" サーチオプション
"----------------------------------------
set hlsearch            " 検索文字をハイライト
set incsearch           " インクリメンタルサーチ
set ignorecase          " 大文字小文字を無視
set smartcase           " 大文字が含まれている場合は大文字小文字を区別
" ESCを二回押すことでハイライトを消す
noremap <ESC><ESC> :nohlsearch<CR><ESC>
" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

let Grep_Skip_Dirs = '.svn .git'
let Grep_Skip_Files = '*.bak *~ *.swp'

" エンコーディング
"----------------------------------------
set termencoding=utf-8
set encoding=utf-8
set fenc=utf-8
set fileencodings=iso-2022-jp-3,iso-2022-jp,enc-jisx0213,euc-jp,utf-8,ucs-bom,eucjp-ms,cp932
autocmd BufNew,BufRead,WinEnter COMMIT_EDITMSG set enc=utf-8 fenc=utf-8

" My keymap
"----------------------------------------
noremap j gj
noremap k gk
noremap gj j
noremap gk k
noremap ; :
noremap : ;
cmap <C-A> <Home>
cmap <C-E> <End>
cmap <C-F> <Right>
cmap <C-B> <Left>
smap <C-H> <BS>
inoremap <C-D> <Del>
inoremap <C-B> <Left>
inoremap <C-F> <Right>
" TABにて対応ペアにジャンプ
nnoremap <Tab> %
vnoremap <Tab> %

"============================================================
" appearance settings
"============================================================
set title                               " 端末のタイトルを表示
set ruler                               " 行番号と列番号を表示
set showmode                            " 現在のモードの表示
set number                              " 行番号表示
set ambiwidth=double                    " 一部のマルチバイト文字をascii2文字分の幅で表示
set display=uhex                        " 印字不可能文字を16進数で表示
set laststatus=2                        " ステータスラインを常時表示

set listchars=tab:>\-,eol:$,trail:_     " 不可視文字の設定

set showmatch                           " カッコの対応をハイライト
set list                                " 不可視文字をハイライト

set lazyredraw                          " スクリプト実行中に画面を再描画しない
set ttyfast                             " 再描画を高速にする

syntax on

" 入力モード時、ステータスラインのカラーを変更
highlight StatusLine ctermfg=Black ctermbg=White
augroup InsertHook
    autocmd!
    autocmd InsertEnter * highlight StatusLine ctermfg=White ctermbg=Black
    autocmd InsertLeave * highlight StatusLine ctermfg=Black ctermbg=White
augroup END

" 現在行のハイライト
set cursorline
highlight CursorLine cterm=bold ctermbg=Black

" その他色
highlight LineNr ctermfg=darkgray ctermbg=Black
highlight SpecialKey ctermfg=darkgray
highlight NonText ctermfg=darkgray

"============================================================
" complement settings
"============================================================
set wildmenu        " 補完をwildmenu化
