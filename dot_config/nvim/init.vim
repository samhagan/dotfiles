"*****************************************************************************
"" Vim-PLug core
"*****************************************************************************
if has('vim_starting')
  set nocompatible				 " Be iMproved
  set encoding=utf-8
endif

let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  echo "Installing Vim-Plug..."
  echo ""
  silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

set mouse=a

"*****************************************************************************
"" Plug install packages
"*****************************************************************************
call plug#begin(expand('~/.config/nvim/plugged'))
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'christoomey/vim-tmux-navigator'
Plug 'chriskempson/base16-vim'
Plug 'ap/vim-buftabline'
Plug 'moll/vim-bbye'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ntpeters/vim-better-whitespace'
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'google/vim-jsonnet'
Plug 'Raimondi/delimitMate'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'sheerun/vim-polyglot'
call plug#end()

"*****************************************************************************
"" Basic Options
"*****************************************************************************
"let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let mapleader=";"		" The <leader> key
set backspace=2			" Makes backspace work like expected
set autoread			" Reload files that have not been modified
set autowrite			" Automatically save before :next or :make
set colorcolumn=100		" Highlight 80 character limit
set hidden				" Allow buffers to be backgrounded without being saved
set laststatus=2		" Always show the status bar
set list				" Show invisible characters
set listchars=tab:›\ ,eol:¬,trail:~,space:· "Set the characters for invisibles
set number				" Display line numbers
set ruler				" Show the line number and column in the status bar
set showmatch			" Highlight matching braces
set noshowmode			" Don't show the current mode on the open buffer
set scrolloff=999		" Keep the cursor centered in the screen
set relativenumber		" Show relative line numbers instead of absolute
set splitbelow			" Splits show up below by default
set splitright			" Splits go to the right by default
set noerrorbells		" No beeps
set noswapfile			" Don't use swapfile
set nobackup			" Don't create annoying backup files
set nowritebackup
"set t_Co=256			" Use 256 colors

" Search settings
set hlsearch			" Highlight results
set ignorecase			" Ignore casing of searches
set incsearch			" Start showing results as you type
set smartcase			" Related to case sensitivity

" Tab settings
set expandtab			" Expand tabs to the proper type and size
set tabstop=4			" Tabs width in spaces
set softtabstop=4		" Soft tab width in spaces
set shiftwidth=4		" Amount of spaces when shifting

filetype plugin indent on

" GUI settings
if filereadable(expand("~/.vimrc_background"))
	let base16colorspace=256
	source ~/.vimrc_background
endif

if has("nvim")
	syntax on
endif

" Backup settings
set undodir=~/nvim/undo
set undofile

"*****************************************************************************
"" Key Mappings
"*****************************************************************************
" Shortcut to yanking to the system clipboard
map <leader>y "+y
map <leader>p "+p

" buffer navigation
nnoremap <C-x> :bnext<CR>
nnoremap <C-z> :bprev<CR>

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
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" Some better exit commands; disable escape key
inoremap jj <esc>
inoremap jJ <esc>
inoremap Jj <esc>
inoremap JJ <esc>
inoremap jk <esc>
inoremap jK <esc>
inoremap Jk <esc>
inoremap JK <esc>
inoremap <esc> <nop>

" -------------------------------------------------------------------------------------------------
" coc.nvim default settings
" -------------------------------------------------------------------------------------------------
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

"*****************************************************************************
"" Plugin Options
"*****************************************************************************
" Nerdtree
nmap <C-n> :NERDTreeToggle<CR>
noremap <Leader>n :NERDTreeFocus<cr>

let NERDTreeShowHidden = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeWinSize = 30
let NERDTreeMinimalUI = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeDirArrows = 1
let NERDTreeIgnore = ['\~$', '\.git$', '.DS_Store']

" Close nerdtree and vim on close file
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" enable line numbers
let NERDTreeShowLineNumbers=1
" make sure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber

" ALE Settings
let g:ale_linters = {}

" there is an issue with golangci-lint where it doesn't find certain issues
" running staticcheck in addition for now
" https://github.com/golangci/golangci-lint/issues/276
let g:ale_linters.go = ['golangci-lint', 'staticcheck']
let g:ale_go_golangci_lint_package = 1
let g:ale_go_golangci_lint_options = ''
let g:ale_go_staticcheck_lint_package = 1
"let g:ale_linters.elixir = ['credo', 'dialyxir', 'dogma', 'elixir-ls', 'mix']

let g:ale_fixers = {}
let g:ale_fixers.javascript = ['eslint']
let g:ale_fixers.elixir = ['mix_format']
let g:ale_fixers.python = ['autopep8']
let g:ale_fixers.dart = ['dartfmt']
let g:ale_fixers.rust = ['rustfmt']
let g:ale_fixers.go = ['goimports']
let g:ale_fixers.terraform = ['terraform']
let g:ale_fix_on_save = 1

" vim-go syntax
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

" buftabline
let g:buftabline_indicators = 1
let g:buftabline_numbers = 1

au FileType go nmap <F12> <Plug>(go-def)

" make autoread work as expected, sortof
autocmd BufEnter,FocusGained * checktime

"FZF
nnoremap <C-p> :GitFiles<CR>
nnoremap <Leader>ff :Files<CR>
nnoremap <Leader>fh :History<CR>
nnoremap <Leader>bb :Buffers<CR>
nnoremap <Leader>ll :Lines<CR>
nnoremap <Leader>lb :BLines<CR>
" give us a nice Find command
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

" vim-better-whitespace
" auto strip whitespace except for file with extention blacklisted
let blacklist = ['markdown', 'md']
autocmd BufWritePre * StripWhitespace

" jsonnet
let g:jsonnet_fmt_fail_silently = 0

"*****************************************************************************
"" File Type Settings
"*****************************************************************************
au BufNewFile,BufRead *.vim setlocal noet ts=4 sw=4 sts=4
au BufNewFile,BufRead *.txt setlocal noet ts=4 sw=4
au BufNewFile,BufRead *.md setlocal spell noet ts=4 sw=4
au BufNewFile,BufRead *.yml,*.yaml setlocal expandtab ts=2 sw=2
au BufNewFile,BufRead *.json setlocal expandtab ts=2 sw=2
au BufNewFile,BufRead *.js,*.jsx,*.ts,*.tsx setlocal expandtab ts=2 sw=2
au BufNewFile,BufRead *.bazel,*.bzl setlocal syntax=bzl expandtab ts=4 sw=4
au BufNewFile,BufRead *.sh setlocal expandtab ts=2 sw=2
au BufNewFile,BufRead Tiltfile setlocal syntax=bzl
au BufNewFile,BufRead *.jsonnet,*.libsonnet setlocal expandtab ts=2 sw=2

" spell check for git commits
autocmd FileType gitcommit setlocal spell

" Wildmenu
set wildmenu
set wildmode=list:full
