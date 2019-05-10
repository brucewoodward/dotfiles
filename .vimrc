
syntax enable
filetype plugin indent on

let mapleader=','

"set re=1

set t_Co=256
set background=dark

set incsearch
set hlsearch
set ignorecase
set smartcase
set wrapscan
set ruler
set nu
set splitbelow
set splitright
set lazyredraw
set nocursorline
set mouse=a
set ttymouse=xterm2

set expandtab
"set listchars=tab:··,trail:·
"set list
set nobackup
set nowritebackup
set undolevels=1000
set undofile
set undodir=/tmp
set history=5000
set encoding=utf8
set showmatch
set ttyfast
set tabstop=8
set softtabstop=8
set shiftwidth=2
set expandtab
set bs=indent,eol,start
set laststatus=2

set exrc
set diffopt=filler,vertical

set guifont=Source\ Code\ Pro

"set shell=/usr/local/bin/bash\ --login
set shell=/usr/bin/bash

set nojoinspaces

set backspace=indent,eol,start

set sw=8
set expandtab

inoremap jw <esc>:w<cr>
inoremap jj <esc>
inoremap jr <esc>
inoremap jn <esc>:w<cr>O

map ,, :set nohlsearch<cr>
nmap <Leader>p :Files<cr>


let g:rspec_command = "!bundle exec rspec {spec}"

" Custom autocommands
augroup mine
    autocmd!
    au FileType sh set shiftwidth=8 expandtab tabstop=8
    au FileType ruby set shiftwidth=2 tabstop=2 softtabstop=2
    au FileType perl nmap <Leader>dd iuse Data::Dumper; warn Dumper 
    au FileType perl imap <Leader>dd use Data::Dumper; warn Dumper 

    au FileType yaml set sw=2 ts=2 expandtab

    au FileType c set sw=8 ts=8

    au BufReadPost *
        \ if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif

    au BufRead *.es6 setf javascript
    au FileType text setlocal textwidth=78
augroup END

function! InsertDebug(prefix, suffix)
  normal gvy
  let variable = getreg('"')
  execute "normal o" . a:prefix . variable . a:suffix
  normal j^
endfunction

function! RubyInsertDebug()
  call InsertDebug("puts \"#{", "}\"")
endfunction

function! JavascriptInsertDebug()
  call InsertDebug("console.log(JSON.stringify(", "));")
endfunction

augroup debugWithPrint
  autocmd!
  au FileType ruby vmap <Leader>de :call RubyInsertDebug()<cr>
  au FileType javascript vmap <Leader>de :call JavascriptInsertDebug()<cr>
augroup END

set wildignore=.git,tmp,public/assets/*
set wildmenu
set exrc
nmap ,b :split #<cr>

colorscheme solarized
hi StatusLine ctermfg=Yellow ctermbg=Black cterm=None
hi DiffAdd        term=bold ctermbg=81 guibg=LightBlue
hi DiffChange     term=bold ctermbg=225 guibg=LightMagenta
hi DiffDelete     term=bold ctermfg=12 ctermbg=159 gui=bold guifg=Blue guibg=LightCyan
hi DiffText       term=reverse cterm=bold ctermbg=9 gui=bold guibg=Red

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OpenChangedFiles COMMAND
" Open a split for each dirty file in git
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenChangedFiles()
  only " Close all windows, unless they're modified
  let status = system('git status -s | grep "^ \?\(M\|A\|UU\)" | sed "s/^.\{3\}//"')
  let filenames = split(status, "\n")
  exec "edit " . filenames[0]
  for filename in filenames[1:]
    exec "sp " . filename
  endfor
endfunction
command! OpenChangedFiles :call OpenChangedFiles()

let g:tagbar_ctags_bin="/Users/bruce/bin/ctags"

"nnoremap h h|xnoremap h h|onoremap h h|
"nnoremap n j|xnoremap n j|onoremap n j|
"nnoremap e k|xnoremap e k|onoremap e k|
"nnoremap i l|xnoremap i l|onoremap i l|

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

nmap ,l :ls<cr>:b
set pastetoggle=,p
