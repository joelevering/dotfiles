call plug#begin()

" General
Plug 'frankier/neovim-colors-solarized-truecolor-only'
Plug 'editorconfig/editorconfig-vim'
Plug 'ervandew/supertab'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'neomake/neomake'
Plug 'tpope/vim-fugitive'
Plug 'Shougo/deoplete.nvim'
Plug 'janko/vim-test'

" JS
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'othree/html5.vim'
Plug 'mhartington/nvim-typescript'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

" Go
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'zchee/deoplete-go', {'do': 'make', 'for': 'go'}

" Ruby
Plug 'tpope/vim-endwise', {'for': 'ruby'}
Plug 'tpope/vim-rails', {'for': 'ruby'}
Plug 'vim-ruby/vim-ruby', {'for': 'ruby'}

" Elixir
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'
Plug 'mhinz/vim-mix-format'

call plug#end()

filetype indent on
filetype plugin on

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

set noswapfile

let mapleader = ","
let g:deoplete#enable_at_startup = 1 " Enable autocomplete
set number " Line numbers
set autoread " Reload files changed outside vim

" Indentation
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" Scrolling
set scrolloff=8
set sidescrolloff=15

" Make 0 go to the first character rather than the beginning
" of the line. When we're programming, we're almost always
" interested in working with text rather than empty space. If
" you want the traditional beginning of line, use ^
nnoremap 0 ^
nnoremap ^ 0

" Solarized Colors
set termguicolors
set background=dark
colorscheme solarized
set noshowcmd

" Search
nnoremap <Leader>t :FZF<CR>

set incsearch " Find the next match as we type the search
set hlsearch " Highlight searches by default
set ignorecase " Ignore case when searching...
set smartcase " ...unless we type a capital

" Copy to clipboard
set clipboard=unnamedplus

" Type ,hl to toggle highlighting on/off, and show current value.
noremap ,hl :set hlsearch! hlsearch?<CR>


map <leader>gg :Ack<Space>
let g:ackprg = 'ag --vimgrep --smart-case'

" Wrappin'
set nowrap " Dont wrap lines

" Whitespace
set list listchars=tab:\ \ ,trail:· " Display tabs/trailing whitespace visually
autocmd BufWritePre * :%s/\s\+$//e " Remove trailing whitespace

" Nerdtree
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeWinSize = 30

" Open the project tree and expose current file in the nerdtree with Ctrl-\
" " calls NERDTreeFind iff NERDTree is active, current window contains a modifiable file, and we're not in vimdiff
function! OpenNerdTree()
  if &modifiable && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
  else
    NERDTreeToggle
  endif
endfunction
nnoremap <silent> <C-\> :call OpenNerdTree()<CR>

" Quick Navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap Q <C-w>q

" Split Nav
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

" Copy file path
nnoremap <silent> ,cf :let @* = expand("%:~")<CR>

" Surround Commands
" ,# Surround a word with #{ruby interpolation}
map ,# ysiw#
vmap ,# c#{<C-R>"}<ESC>

" ," Surround a word with "quotes"
map ," ysiw"
vmap ," c"<C-R>""<ESC>

" ,' Surround a word with 'single quotes'
map ,' ysiw'
vmap ,' c'<C-R>"'<ESC>

" ,) or ,( Surround a word with (parens)
" The difference is in whether a space is put in
map ,( ysiw(
map ,) ysiw)
vmap ,( c( <C-R>" )<ESC>
vmap ,) c(<C-R>")<ESC>

" ,[ Surround a word with [brackets]
map ,] ysiw]
map ,[ ysiw[
vmap ,[ c[ <C-R>" ]<ESC>
vmap ,] c[<C-R>"]<ESC>

" ,{ Surround a word with {braces}
map ,} ysiw}
map ,{ ysiw{
vmap ,} c{ <C-R>" }<ESC>
vmap ,{ c{<C-R>"}<ESC>

" Tab nav
map <D-1> 1gt
map <D-2> 2gt
map <D-3> 3gt
map <D-4> 4gt
map <D-5> 5gt
map <D-6> 6gt
map <D-7> 7gt
map <D-8> 8gt
map <D-9> 9gt

" Vim test
let test#strategy = "neovim"
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
if has('persistent_undo') && isdirectory(expand('~').'/.vim/backups')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Toggle line commenting on cmd-/
map <D-/> ,ci

" Go stuff
let g:go_fmt_command = "goimports"
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_map_mode = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:go_list_type = 'quickfix'

" Elixir
let g:mix_format_on_save = 1

set completeopt+=noinsert
set completeopt+=noselect
set completeopt-=preview

" FZF uses agignore
let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'

" Enable YATS (typescript syntax highlighting) for tsx files
autocmd BufNewFile,BufRead *.ts,*.tsx setlocal filetype=typescript

" Run neomake on write
call neomake#configure#automake('w')
