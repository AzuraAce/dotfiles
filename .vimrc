" Syntax highlighting
syntax on
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete

" UI
set number              " Show line numbers
set relativenumber      " Relative line numbers
set cursorline          " Highlight current line
set tabstop=4           " Number of spaces tabs count for
set shiftwidth=4        " Spaces for autoindent
set expandtab           " Convert tabs to spaces
set smartindent         " Smart autoindenting
set nowrap              " Don't wrap long lines
set encoding=utf-8
set formatoptions-=cro
set termguicolors

set mouse=a
" Mouse support in simple terminal
set ttymouse=sgr

" Undo History
set undodir=$HOME/.vim/undodir
if !isdirectory(&undodir)
    echo "creating undodir"
    silent call mkdir(&undodir, 'p')
endif
set undofile

" Disable Swap files
set noswapfile

" Use system clipboard
set clipboard+=unnamedplus

" Correct Spelling mistake
setlocal spell
set spelllang=de,en
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" FZF 
nnoremap <C-p> :Files<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <C-f> :Rg<CR>

" UtilSnips
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsSnippetDirectories = ['UltiSnips']

" VimTex
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_latexmk = {
            \ 'aux_dir': '/home/oliver/.texfiles/',
\}

" Install Vim-Plug if not already installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
    " FZF
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " Snippets
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'  " Optional: community snippet collection

    " VimTex
    Plug 'lervag/vimtex', { 'tag': 'v2.15' }    
    
    " nerdtree
    Plug 'preservim/nerdtree'
    " Exit Vim if NERDTree is the only window remaining in the only tab.
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
        execute "set <C-n>=\e1"
    nnoremap <C-n> :NERDTreeToggle<CR>:if g:NERDTree.IsOpen() \| NERDTreeFocus \| endif<CR>

    " Theme
    Plug 'joshdick/onedark.vim'
    Plug 'liuchengxu/space-vim-dark'
    Plug 'ghifarit53/tokyonight-vim'
    Plug 'arzg/vim-colors-xcode'
    Plug 'dangerousScript/gruber-darker-nvim'

    " Startup Image
    Plug 'mhinz/vim-startify'    
call plug#end()

" Theming
let g:tokyonight_style = 'night' " available: night, storm
colorscheme xcodewwdc

" Theme
hi LineNr ctermfg=5 guifg=#8f7bcc ctermbg=NONE guibg=NONE
hi Comment guifg=#5C6370 ctermfg=59

" Startify
let g:startify_custom_header =
    \ startify#center(readfile('/home/oliver/.vim/art/header.txt'))
let g:startify_lists = [
            \ { 'type': 'files',     'header': ['   MRU'] },
            \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
            \ ]
let g:startify_files_number = 5

" Status Bar
"https://stackoverflow.com/a/5380230
set laststatus=2            " set the bottom status bar
" Formats the statusline
hi statusline guifg=#af87d7
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

