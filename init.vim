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


"*****************************************************************************
"" Plug install packages
"*****************************************************************************
call plug#begin(expand('~/.config/nvim/plugged'))
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neomake/neomake'
Plug 'benjie/neomake-local-eslint.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'christoomey/vim-tmux-navigator'
Plug 'morhetz/gruvbox'
Plug 'chriskempson/base16-vim'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'elmcast/elm-vim'
Plug 'ap/vim-buftabline'
Plug 'Raimondi/delimitMate'
Plug 'majutsushi/tagbar'
Plug 'moll/vim-bbye'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ntpeters/vim-better-whitespace'
Plug 'junegunn/fzf.vim'
Plug 'pangloss/vim-javascript'
"Plug 'jelera/vim-javascript-syntax'
Plug 'mxw/vim-jsx'
Plug 'suan/vim-instant-markdown'
Plug 'vim-scripts/groovy.vim'
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

au BufLeave,FocusLost * silent! wall	" Set vim to save the file on focus out.

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
if has("nvim")
	syntax on
	colorscheme base16-oceanicnext
	set background=dark
endif

" Backup settings
set undodir=~/nvim/undo
set undofile

"*****************************************************************************
"" Key Mappings
"*****************************************************************************
" Shortcut to yanking to the system clipboard
map <leader>y "*y
map <leader>p "*p

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
"*****************************************************************************
"" Plugin Options
"*****************************************************************************
" Nerdtree
nmap <C-n> :NERDTreeToggle<CR>
noremap <Leader>n :NERDTreeFocus<cr>
"noremap <Leader>nf :NERDTreeFind<cr>

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

" Turn on javascript linting
let g:neomake_javascript_enabled_makers = ['eslint']
autocmd! BufWritePost * Neomake

" Turn on autcomplete
let g:deoplete#enable_at_startup = 1

" go-vim
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
let g:go_gocode_unimported_packages = 1

" make autoread work as expected, sortof
autocmd BufEnter,FocusGained * checktime

"FZF
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
omap <leader><tab> <plug>(fzf-maps-o)
xmap <leader><tab> <plug>(fzf-maps-x)

" insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

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

" elm-vim
let g:elm_format_autosave = 1
let g:elm_setup_keybindings = 0

" vim-jsx
let g:jsx_ext_required = 0

" markdown preview
let g:instant_markdown_autostart = 0

"*****************************************************************************
"" File Type Settings
"*****************************************************************************

au BufNewFile,BufRead *.vim setlocal noet ts=4 sw=4 sts=4
au BufNewFile,BufRead *.txt setlocal noet ts=4 sw=4
au BufNewFile,BufRead *.md setlocal spell noet ts=4 sw=4
au BufNewFile,BufRead *.yml,*.yaml setlocal expandtab ts=2 sw=2
au BufNewFile,BufRead *.json setlocal expandtab ts=2 sw=2
au BufNewFile,BufRead *.js,*.jsx setlocal expandtab ts=2 sw=2

" spell check for git commits
autocmd FileType gitcommit setlocal spell

" Wildmenu completion {{{
set wildmenu
set wildmode=list:full

set wildignore+=.hg,.git,.svn					 " Version control
set wildignore+=*.aux,*.out,*.toc				 " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg	 " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl							 " compiled spelling word lists
set wildignore+=*.sw?							 " Vim swap files
set wildignore+=*.DS_Store						 " OSX bullshit
set wildignore+=node_modules					" node stuff
set wildignore+=go/pkg							" Go static files
set wildignore+=go/bin							" Go bin files
set wildignore+=go/bin-vagrant					" Go bin-vagrant files
set wildignore+=*.pyc							" Python byte code
set wildignore+=*.orig							" Merge resolution files
set wildignore+=elm_stuff						" elm

