" Set compatibility to Vim only.
set nocompatible

" Helps force plug-ins to load correctly when it is turned back on below.
filetype off

" 4 space tabs
set tabstop=4

call plug#begin('~/.vim/plugged')

" Nord Theme
Plug 'arcticicestudio/nord-vim'

" One Dark
Plug 'joshdick/onedark.vim'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

"Markdown plugins
Plug 'gabrielelana/vim-markdown'

"Illuminate
Plug 'oknozor/illumination', { 'dir': '~/.illumination', 'do': '.install.sh' }

" Fish syntax highlightning
Plug 'aliva/vim-fish'

" File explorer
Plug 'scrooloose/nerdtree'

" Commentary
Plug 'tpope/vim-commentary'

" Autoclose
Plug 'townk/vim-autoclose'

" Rust
Plug 'rust-lang/rust.vim'

"CoC
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Install ansible plugin 
Plug 'pearofducks/ansible-vim'

" Ranger integration
Plug 'francoiscabrol/ranger.vim'

" Vim icons
Plug 'ryanoasis/vim-devicons'

call plug#end()

" Nerdtree
" autocmd vimenter * NERDTree

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_theme='onedark'
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" Move between split windows
:nmap <silent> <A-h> :wincmd h<CR>
:nmap <silent> <A-j> :wincmd j<CR>
:nmap <silent> <A-k> :wincmd k<CR>
:nmap <silent> <A-l> :wincmd l<CR>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Turn on syntax highlighting.
syntax on

" For plug-ins to load correctly.
filetype plugin indent on

" Set this to have long lines wrap inside comments.
setlocal textwidth=79

" Enable folding of block structures in fish.
setlocal foldmethod=expr

" Turn off modelines
set modelines=0

colorscheme onedark

" Highlighted row
let g:nord_cursor_line_number_background = 1

" Uniform status line
let g:nord_uniform_status_lines = 1

" Vsplit line
let g:nord_bold_vertical_split_line = 1

"Uniform backgroung highlighting
let g:nord_uniform_diff_background = 1

" Include bold style for specified syntax
let g:nord_bold = 0

" Include italic style for specified syntax
let g:nord_italic = 0

" Include underline style for specified syntax
let g:nord_underline = 0

" Automatically wrap text that extends beyond the screen length.
set wrap
" Vim's auto indentation feature does not work properly with text copied from outside of Vim. Press the <F2> key to toggle paste mode on/off.
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F2>

" Uncomment below to set the max textwidth. Use a value corresponding to the width of your screen.
" set textwidth=79
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

" Display 5 lines above/below the cursor when scrolling with a mouse.
set scrolloff=5

" Wayland clipborad
set clipboard+=unnamedplus

" Fixes common backspace problems
set backspace=indent,eol,start

"Delay vim

" File explorer shortcut
:nnoremap <C-space> :NERDTreeToggle<CR>

" Speed up scrolling in Vim
set ttyfast
" standard shortcuts
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+

" Status bar
set laststatus=2

" Display options
set showmode
set showcmd

" Highlight matching pairs of brackets. Use the '%' character to jump between them.
set matchpairs+=<:>

" Display different types of white spaces.
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

" Show line numbers
set number

" Set status line display
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%c')}

" Encoding
set encoding=utf-8

" Highlight matching search patterns
set hlsearch
" Enable incremental search
set incsearch
" Include matching uppercase words with lowercase search term
set ignorecase
" Include only uppercase words with uppercase search term
set smartcase

" Store info from no more than 100 files at a time, 9999 lines of text, 100kb of data. Useful for copying large amounts of data between files.
set viminfo='100,<9999,s100

" Map the <Space> key to toggle a selected fold opened/closed.
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" Automatically save and load folds
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview"
