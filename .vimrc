set shellslash
set textwidth=0
set browsedir=current
set scrolloff=10
set autoread
set vb t_vb=
set nowritebackup
set nobackup
set noswapfile

set hlsearch
set incsearch
set ignorecase
set smartcase
noremap <ESC><ESC> :nohlsearch<CR><ESC>
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

let Grep_Skip_Dirs = '.svn .git'
let Grep_Skip_Files = '*.bak *~ *.swp'

set termencoding=utf-8
set encoding=utf-8
set fenc=utf-8
set fileencodings=iso-2022-jp-3,iso-2022-jp,enc-jisx0213,euc-jp,utf-8,ucs-bom,eucjp-ms,cp932
autocmd BufNew,BufRead,WinEnter COMMIT_EDITMSG set enc=utf-8 fenc=utf-8

noremap j gj
noremap k gk
noremap gj j
noremap gk k
noremap Y y$
noremap <Space> :w<CR>
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>
cmap <C-A> <Home>
cmap <C-E> <End>
cmap <C-F> <Right>
cmap <C-B> <Left>
cmap <C-D> <Del>
smap <C-H> <BS>
inoremap <C-A> <Home>
inoremap <C-E> <End>
inoremap <C-B> <Left>
inoremap <C-F> <Right>
inoremap <C-D> <Del>

set title
set ruler
set showmode
set number
set ambiwidth=double
set display=uhex
set laststatus=2

set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲

set showmatch
set matchpairs& matchpairs+=<:>
set list

set lazyredraw
set ttyfast

syntax on

highlight StatusLine ctermfg=Black ctermbg=White
augroup InsertHook
    autocmd!
    autocmd InsertEnter * highlight StatusLine ctermfg=White ctermbg=Black
    autocmd InsertLeave * highlight StatusLine ctermfg=Black ctermbg=White
augroup END

set cursorline
highlight CursorLine cterm=bold ctermbg=Black

highlight LineNr ctermfg=darkgray ctermbg=Black
highlight SpecialKey ctermfg=darkgray
highlight NonText ctermfg=darkgray

set wildmenu
set infercase

" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

map <silent> [Tag]c :tablast <bar> tabnew<CR>
map <silent> [Tag]x :tabclose<CR>
map <silent> [Tag]n :tabnext<CR>
map <silent> [Tag]p :tabprevious<CR>
