"Install vim-plug 
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"set the runtime path to include fzf
"set rtp+=~/.fzf

"set the leader key
let mapleader = ' '

syntax on
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set hidden
set nohlsearch
set ignorecase
set incsearch
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set scrolloff=8
set clipboard=unnamed

call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
"Plug 'nvim-lua/completion-nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mbbill/undotree'
Plug 'junegunn/fzf' ", {'do': { -> fzf#install() }}
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'calviken/vim-gdscript3'

call plug#end()

"Set background/colorscheme
set bg=dark
colorscheme gruvbox

"have nerdtree autorun
"autocmd vimenter * NERDTree
" Ctrl+n to toggle NERDTree
noremap <C-n> :NERDTreeToggle<CR>
noremap <leader>h :wincmd h<CR>
noremap <leader>l :wincmd l<CR>
noremap <leader>j :wincmd j<CR>
noremap <leader>k :wincmd k<CR>
noremap <leader>f :FZF<CR>
noremap <leader>fb :Buffers<CR>
noremap <leader>fc :Commands<CR>
noremap <leader>fC :Colors<cr>
nnoremap <leader>ff :Files<cr>
nnoremap <leader>fh :Helptags<cr>
nnoremap <leader>fH :History<cr>
nnoremap <leader>fl :Lines<cr>
nnoremap <leader>fm :Maps<cr>
nnoremap <leader>fn :FZF ~/Notes<cr>
nnoremap <leader>fr :Rg<cr>
nnoremap <leader>fs :Snippets<cr>

"closes nerdtree if left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"let g:fzf_layout = { 'window': '1-split enew' }

