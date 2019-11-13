set encoding=utf-8
scriptencoding utf-8

" ----------setting dein.vim------------- "
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if &runtimepath !~# 'dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim '. s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
let s:toml_lazy_file = fnamemodify(expand('<sfile>'), ':h').'/dein_lazy.toml'

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:toml_file)
  call dein#load_toml(s:toml_lazy_file, {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

" ----setting init.vim -----"
syntax enable
colorscheme gotham256
set nowrap
set completeopt=menuone
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
set hidden
set hlsearch
set incsearch
set number
set showmatch
set smarttab
set whichwrap=b,s,<,>,[,]
set laststatus=2
set nobackup
set noswapfile
set background=dark
if has('nvim-0.4.0')
  set wildoptions=pum
endif
set noshowmode

" ---------setting autofmt------------ "
set formatexpr=autofmt#japanese#formatexpr()
filetype plugin indent on

if has('mouse')
  set mouse=a
endif

if &compatible
  set nocompatible
endif

"shellのキーバインド設定"
tnoremap <silent> <ESC> <C-\><C-n>

"言語別にインデントを分ける"
augroup fileTypeIndent
  autocmd!
  autocmd FileType py setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd FileType rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType html setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType eruby setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType vim setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType go :highlight goErr cterm=bold ctermfg=214
  autocmd FileType go :match goErr /\<err\>/
  autocmd FileType markdown setlocal wrap
augroup END

"goのsyntax強化


"setting keymap
command! -nargs=* T split | terminal <args>

"スペース + tでターミナル起動"
let mapleader = "\<Space>"

nnoremap <Leader>t :T<CR>

nnoremap <leader>f :Denite file/rec<CR>

"スペース + v で垂直分割"
nnoremap <Leader>v :vsplit<CR>

nnoremap <Leader>s :split<CR>

"ウインドウ移動ショートカットをswに当てる"
nnoremap sw <C-w>w

"Defxコマンドをスペース+dに当てる"
nnoremap <Leader>d :Defx -columns=icons:filename:type<CR>
"nohコマンドをescに"
nnoremap <ESC><ESC> :nohlsearch<CR>

noremap <Up> :Gina status<CR>
noremap <Down> :Gina commit<CR>
noremap <Left> :Gina diff<CR> 
noremap <Right> <Nop>

" 補完コマンドの再設定
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : MyInsCompl()
function! MyInsCompl()
  let c = nr2char(getchar())
  if c == "l"
    return "\<C-x>\<C-l>"
  elseif c == "n"
    return "\<C-x>\<C-n>"
  elseif c == "p"
    return "\<C-x>\<C-p>"
  elseif c == "k"
    return "\<C-x>\<C-k>"
  elseif c == "t"
    return "\<C-x>\na<C-t>"
  elseif c == "i"
    return "\<C-x>\<C-i>"
  elseif c == "]"
    return "\<C-x>\<C-]>"
  elseif c == "f"
    return "\<C-x>\<C-f>"
  elseif c == "d"
    return "\<C-x>\<C-d>"
  elseif c == "v"
    return "\<C-x>\<C-v>"
  elseif c == "u"
    return "\<C-x>\<C-u>"
  elseif c == "o"
    return "\<C-x>\<C-o>"
  elseif c == "s"
    return "\<C-x>s"
  endif
  return "\<Tab>"
endfunction

"setting update command"
function PluginUpdate()
  if exists('*dein#update()')
    call dein#update()
  endif
endfunction
command -nargs=0 PluginUpdate call PluginUpdate()

"setting indent command
function Indent()
  let save_cursor = getcurpos()
  execute("normal " . "gg=G")
  call setpos('.', save_cursor)
endfunction
command -nargs=0 Indent call Indent()

"-----setting vim-lsp-------
if executable('gopls')
  augroup LspGo
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'gopls',
          \ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
          \ 'whitelist': ['go'],
          \ })
  augroup END
endif

"if (executable('pyls'))
"  augroup LspPython
"    autocmd!
"    autocmd User lsp_setup call lsp#register_server({
"          \ 'name': 'pyls',
"          \ 'cmd': { server_info -> [$PYENV_ROOT.'/shims/pyls'] },
"          \ 'whitelist': ['python'],
"          \})
"  augroup END
"endif
