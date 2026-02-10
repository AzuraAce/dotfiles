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
if has('unnamedplus')
    set clipboard^=unnamed,unnamedplus
else
    set clipboard^=unnamed
endif
" save yanked text to clipboard on exit
autocmd VimLeave * call system("xsel -ib", getreg('+'))

" Spell Check and Correct Spelling mistake in .tex files
autocmd BufNewFile,BufRead *.tex set spell spelllang=de,en
nnoremap <C-l> [s1z=

" WhichKey
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>

" FZF 
nnoremap <leader>p :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>f :Rg<CR>

" UtilSnips - python3 required
if has('python3')
    let g:UltiSnipsExpandTrigger = '<tab>'
    let g:UltiSnipsJumpForwardTrigger = '<tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
    let g:UltiSnipsSnippetDirectories = ['UltiSnips']
else
    echoerr 'python3 required to use UtilSnips'
endif

" VimTex
if has('zathura')
    let g:vimtex_view_method = 'zathura'
endif
let g:vimtex_view_forward_search_on_start = 0 " don't auto forward search; use <leader>lv instead
let g:vimtex_compiler_latexmk = {
            \ 'aux_dir': './aux',
            \ 'out_dir': './out',
\}

" COC Settings
inoremap <silent> <C-x><C-o> <C-r>=coc#refresh()<CR>

" Install Vim-Plug if not already installed
if has('win32') || has('win64')
    let data_dir = has('nvim') ? stdpath('data') . '/site' : expand('$HOME/vimfiles')
    let plug_path = data_dir . '/autoload/plug.vim'
    let plug_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    
    if empty(glob(plug_path))
        let autoload_dir = data_dir . '/autoload'
        if !isdirectory(autoload_dir)
            call mkdir(autoload_dir, 'p')
        endif
        
        if executable('curl')
            silent execute '!curl -fLo "' . plug_path . '" ' . plug_url
        elseif executable('powershell')
            silent execute '!powershell -Command "Invoke-WebRequest -Uri ''' . plug_url . ''' -OutFile ''' . plug_path . '''"'
        else
            echoerr 'curl or powershell required to install vim-plug'
        endif
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
else
    let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
    if empty(glob(data_dir . '/autoload/plug.vim'))
        silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
endif

call plug#begin()
    " FZF
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " LSP
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " Snippets
    if has('python3')
        Plug 'SirVer/ultisnips'
    endif
    Plug 'honza/vim-snippets'  " Optional: community snippet collection

    " VimTex
    Plug 'lervag/vimtex', { 'tag': 'v2.15' }    
    
    " nerdtree
    Plug 'preservim/nerdtree'
    " Exit Vim if NERDTree is the only window remaining in the only tab.
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
    if !has('gui_running')
        execute "set <C-n>=\e1"
    endif
    nnoremap <leader>n :NERDTreeToggle<CR>:if g:NERDTree.IsOpen() \| NERDTreeFocus \| endif<CR>

    " Theme
    Plug 'dangerousScript/gruber-darker-nvim'

    " Startup Image
    Plug 'mhinz/vim-startify'    

    Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
call plug#end()

" Theming
colorscheme gruberdarker

" Purple Line Numbers and Grey comments
hi LineNr ctermfg=5 guifg=#8f7bcc ctermbg=NONE guibg=NONE
hi Comment guifg=#5C6370 ctermfg=59

" Startify
let g:startify_custom_header = startify#center([
    \ '⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿',
    \ '⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⣠⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿',
    \ '⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣡⣾⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⣿⣟⠻⣿⣿⣿⣿⣿⣿⣿⣿',
    \ '⣿⣿⣿⣿⣿⣿⣿⣿⡿⢫⣷⣿⣿⣿⣿⣿⣿⣿⣾⣯⣿⡿⢧⡚⢷⣌⣽⣿⣿⣿⣿⣿⣶⡌⣿⣿⣿⣿⣿⣿',
    \ '⣿⣿⣿⣿⣿⣿⣿⣿⠇⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣮⣇⣘⠿⢹⣿⣿⣿⣿⣿⣻⢿⣿⣿⣿⣿⣿',
    \ '⣿⣿⣿⣿⣿⣿⣿⣿⠀⢸⣿⣿⡇⣿⣿⣿⣿⣿⣿⣿⣿⡟⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣻⣿⣿⣿⣿',
    \ '⣿⣿⣿⣿⣿⣿⣿⡇⠀⣬⠏⣿⡇⢻⣿⣿⣿⣿⣿⣿⣿⣷⣼⣿⣿⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⢻⣿⣿⣿⣿',
    \ '⣿⣿⣿⣿⣿⣿⣿⠀⠈⠁⠀⣿⡇⠘⡟⣿⣿⣿⣿⣿⣿⣿⣿⡏⠿⣿⣟⣿⣿⣿⣿⣿⣿⣿⣿⣇⣿⣿⣿⣿',
    \ '⣿⣿⣿⣿⣿⣿⡏⠀⠀⠐⠀⢻⣇⠀⠀⠹⣿⣿⣿⣿⣿⣿⣩⡶⠼⠟⠻⠞⣿⡈⠻⣟⢻⣿⣿⣿⣿⣿⣿⣿',
    \ '⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⢿⠀⡆⠀⠘⢿⢻⡿⣿⣧⣷⢣⣶⡃⢀⣾⡆⡋⣧⠙⢿⣿⣿⣟⣿⣿⣿⣿',
    \ '⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⡥⠂⡐⠀⠁⠑⣾⣿⣿⣾⣿⣿⣿⡿⣷⣷⣿⣧⣾⣿⣿⣿⣿⣿⣿⣿',
    \ '⣿⣿⡿⣿⣍⡴⠆⠀⠀⠀⠀⠀⠀⠀⠀⣼⣄⣀⣷⡄⣙⢿⣿⣿⣿⣿⣯⣶⣿⣿⢟⣾⣿⣿⢡⣿⣿⣿⣿⣿',
    \ '⣿⡏⣾⣿⣿⣿⣷⣦⠀⠀⠀⢀⡀⠀⠀⠠⣭⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⣡⣾⣿⣿⢏⣾⣿⣿⣿⣿⣿',
    \ '⣿⣿⣿⣿⣿⣿⣿⣿⡴⠀⠀⠀⠀⠀⠠⠀⠰⣿⣿⣿⣷⣿⠿⠿⣿⣿⣭⡶⣫⠔⢻⢿⢇⣾⣿⣿⣿⣿⣿⣿',
    \ '⣿⣿⣿⡿⢫⣽⠟⣋⠀⠀⠀⠀⣶⣦⠀⠀⠀⠈⠻⣿⣿⣿⣾⣿⣿⣿⣿⡿⣣⣿⣿⢸⣾⣿⣿⣿⣿⣿⣿⣿',
    \ '⡿⠛⣹⣶⣶⣶⣾⣿⣷⣦⣤⣤⣀⣀⠀⠀⠀⠀⠀⠀⠉⠛⠻⢿⣿⡿⠫⠾⠿⠋⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿',
    \ '⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣀⡆⣠⢀⣴⣏⡀⠀⠀⠀⠉⠀⠀⢀⣠⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿',
    \ '⠿⠛⠛⠛⠛⠛⠛⠻⢿⣿⣿⣿⣿⣯⣟⠷⢷⣿⡿⠋⠀⠀⠀⠀⣵⡀⢠⡿⠋⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿',
    \ '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⢿⣿⣿⠂⠀⠀⠀⠀⠀⢀⣽⣿⣿⣿⣿⣿⣿⣿⣍⠛⠿⣿⣿⣿⣿⣿⣿'])
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
