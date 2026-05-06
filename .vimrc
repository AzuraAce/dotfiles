" disable bell
set belloff=all

" Syntax highlighting
syntax on
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete

" Space as leader
let mapleader = " "
let maplocalleader = " "

" UI
set number              " Show line numbers
set relativenumber      " Relative line numbers
" set cursorline          " Highlight current line
set tabstop=4           " Number of spaces tabs count for
set shiftwidth=4        " Spaces for autoindent
set expandtab           " Convert tabs to spaces
set smartindent         " Smart autoindenting
set nowrap              " Don't wrap long lines
set encoding=utf-8
set formatoptions-=cro
"set termguicolors

set mouse=a
" Mouse support in simple terminal
if !has('nvim') && !has('gui_running')
    set ttymouse=sgr
endif

" Undo History
if has('win32') || has('win64')
    set undodir=$HOME/vimfiles/undodir
else
    set undodir=$HOME/.vim/undodir
endif
if !isdirectory(&undodir)
    echo "creating undodir"
    silent call mkdir(&undodir, 'p')
endif
set undofile

" Disable Swap files
set noswapfile

" Use system clipboard
set clipboard^=unnamed,unnamedplus

" save yanked text to clipboard on exit
autocmd VimLeave * call system("xsel -ib", getreg('+'))

" FZF 
nnoremap <leader>p :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>f :Rg<CR>

" Theming
" colorscheme gruberdarker

" Purple Line Numbers and Grey comments
hi LineNr ctermfg=13 guifg=#85678f ctermbg=NONE guibg=NONE
hi Comment ctermfg=59 guifg=#5C6370 
" Status Bar
"https://stackoverflow.com/a/5380230
set laststatus=2            " set the bottom status bar
" Formats the statusline
hi statusline ctermfg=5 guifg=#85678f
set statusline=%f                           " file name
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%y      "filetype
set statusline+=%h      "help file flag
set statusline+=[%{getbufvar(bufnr('%'),'&mod')?'modified':'saved'}]      
"modified flag
set statusline+=%r      "read only flag
set statusline+=\ %=                        " align left
set statusline+=Line:%l/%L[%p%%]            " line X of Y [percent of file]
set statusline+=\ Col:%c                    " current column
set statusline+=\ Buf:%n                    " Buffer number
set statusline+=\ [%b][0x%B]\               " ASCII and byte code under cursor

" Better search
set ignorecase
set smartcase
set incsearch
set hlsearch
nnoremap <silent> <Esc> :nohl<CR><Esc>

" Hide current buffer
nnoremap <leader>h :hide<CR>
