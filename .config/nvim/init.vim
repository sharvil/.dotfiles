" Don't generate temp files all over the place
set nobackup
set noswapfile

" Syntax highlighting and theme
syntax on
colorscheme molokai
let g:molokai_original=1
let g:rehash256=1

" Formatting and whitespace
set expandtab
set shiftwidth=2
set softtabstop=2
set nowrap

" Enable search highlighting
" Use CTRL+L to remove search highlighting.
set hlsearch
nnoremap <silent> <C-l> :nohl<CR><C-l>

if has('nvim')
  " Use CTRL+Space to exit terminal mode
  tnoremap <C-Space> <C-\><C-n>

  " Plugins managed by vim-plug
  call plug#begin('~/.config/nvim/plugged')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'Rip-Rip/clang_complete'
  call plug#end()

  " Code completion using deoplete
  let g:deoplete#enable_at_startup=1
  let g:deoplete#sources={}
  let g:deoplete#sources.c=['clang_complete']
  let g:deoplete#sources.cpp=['clang_complete']

  " Code completion plugin for C/C++ using Clang
  let g:clang_library_path='/Library/Developer/CommandLineTools/usr/lib/'
  let g:clang_use_library=1
  let g:clang_auto_select=1
  let g:clang_snippets=1
  let g:clang_snippets_engine='clang_complete'
  let g:clang_trailing_placeholder=1
  set completeopt=menuone,noinsert
endif

set tags=./tags;/
function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction
" au BufEnter /* call LoadCscope()
