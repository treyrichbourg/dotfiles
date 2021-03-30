if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"set the runtime path to include fzf
"set rtp+=~/.fzf

syntax enable
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
"set mouse=a
set clipboard=unnamedplus

call plug#begin('~/.vim/plugged')
"Plug 'morhetz/gruvbox'
Plug 'gruvbox-community/gruvbox'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'vim-utils/vim-man'
"Plug 'nvim-lua/completion-nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mbbill/undotree'
Plug 'junegunn/fzf' ", {'do': { -> fzf#install() }}
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'calviken/vim-gdscript3'
Plug 'psf/black', { 'branch': 'stable' }

call plug#end()

"Set background/colorscheme
set bg=dark
colorscheme gruvbox

"set the leader key
let mapleader = ' '
"Keybindings
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>fz :FZF<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fc :Commands<CR>
nnoremap <leader>fC :Colors<cr>
nnoremap <leader>ff :Files<cr>
nnoremap <leader>fh :Helptags<cr>
nnoremap <leader>fH :History<cr>
nnoremap <leader>fl :Lines<cr>
nnoremap <leader>fm :Maps<cr>
nnoremap <leader>fn :FZF ~/Notes<cr>
nnoremap <leader>fr :Rg<cr>
nnoremap <leader>fs :Snippets<cr>


"autocmds
"closes nerdtree if left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"let g:fzf_layout = { 'window': '1-split enew' }
"Trims trailing whitespace
fun! TrimWhiteSpace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup comet
    autocmd!
"    autocmd BufWritePre *.py execute ':Black'
    autocmd BufWritePre * :call TrimWhiteSpace()
augroup END

"source files
source $HOME/dotfiles/nvim/coc/coc.vim


