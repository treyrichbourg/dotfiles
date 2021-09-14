if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

syntax enable
set noerrorbells
set nowrap
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
set noshowmode
"set mouse=a
set clipboard=unnamedplus

call plug#begin('~/.vim/plugged')
Plug 'pprovost/vim-ps1'
"Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
"Plug 'glepnir/galaxyline.nvim', {'branch': 'main'}
Plug 'ledger/vim-ledger'
Plug 'ryanoasis/vim-devicons'
Plug 'gruvbox-community/gruvbox'
Plug 'folke/tokyonight.nvim'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'vim-utils/vim-man'
"Plug 'nvim-lua/completion-nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mbbill/undotree'
Plug 'junegunn/fzf' ", {'do': { -> fzf#install() }}
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'calviken/vim-gdscript3'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSU pdate'}

call plug#end()

"Set background/colorscheme
set bg=dark
" let g:tokyonight_style = "night"
" let g:tokyonight_italic_functions = "true"
" let g:tokyonight_sidebars = ["qf", "vista_kind", "terminal", "packer"]
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

" lightline
let g:lightline = {
    \ 'colorscheme': 'gruvbox',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste'],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'FugitiveHead'
    \ }
    \ }

