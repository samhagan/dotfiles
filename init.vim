"*****************************************************************************
"" Vim-PLug core
"*****************************************************************************
if has('vim_starting')
  set nocompatible               " Be iMproved
endif

let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  echo "Installing Vim-Plug..."
  echo ""
  silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif


"*****************************************************************************
"" Plug install packages
"*****************************************************************************
call plug#begin(expand('~/.config/nvim/plugged'))
"Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'tomasr/molokai'
Plug 'neomake/neomake'
Plug 'benjie/neomake-local-eslint.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'flazz/vim-colorschemes'
call plug#end()

"*****************************************************************************
"" Basic Options 
"*****************************************************************************
let mapleader=";"       " The <leader> key
set backspace=2         " Makes backspace work like expected
set autoread            " Reload files that have not been modified
set colorcolumn=100     " Highlight 80 character limit
set hidden              " Allow buffers to be backgrounded without being saved
set laststatus=2        " Always show the status bar
set list                " Show invisible characters
set listchars=tab:›\ ,eol:¬,trail:~,space:·  " Set the characters for invisibles
set number              " Display line numbers
set ruler               " Show the line number and column in the status bar
set showmatch           " Highlight matching braces
set noshowmode          " Don't show the current mode on the open buffer
set scrolloff=999       " Keep the cursor centered in the screen
set encoding=utf-8
set relativenumber      " Show relative line numbers instead of absolute
set splitbelow          " Splits show up below by default
set splitright          " Splits go to the right by default
set t_Co=256            " Use 256 colors

" Search settings
set hlsearch            " Highlight results
set ignorecase          " Ignore casing of searches
set incsearch           " Start showing results as you type
set smartcase           " Related to case sensitivity

" Tab settings
set expandtab           " Expand tabs to the proper type and size
set tabstop=4           " Tabs width in spaces
set softtabstop=4       " Soft tab width in spaces
set shiftwidth=4        " Amount of spaces when shifting

" GUI settings
if has("nvim")
    syntax enable
    colorscheme molokai
endif

" Backup settings
set directory=~/nvim/swap
set backupdir=~/nvim/backup
set undodir=~/nvim/undo
set backup
set undofile
set writebackup

"*****************************************************************************
"" Key Mappings
"*****************************************************************************

" Get rid of search highlighting
noremap <silent><leader>/ :nohlsearch<CR>

" Improve split navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Prevent using arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
" inoremap <up> <nop>
" inoremap <down> <nop>
" inoremap <left> <nop>
" inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" Some better exit commands
inoremap jj <esc>
inoremap jJ <esc>
inoremap Jj <esc>
inoremap JJ <esc>
inoremap jk <esc>
inoremap jK <esc>
inoremap Jk <esc>
inoremap JK <esc>

"*****************************************************************************
"" Plugin Options
"*****************************************************************************
" Nerdtree
map <C-n> :NERDTreeToggle <CR>

" Turn on javascript linting
let g:neomake_javascript_enabled_makers = ['eslint']
autocmd! BufWritePost * Neomake

" Turn on autcomplete
let g:deoplete#enable_at_startup = 1

