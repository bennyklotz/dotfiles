scriptencoding utf-8
set encoding=utf-8

" Using fish as shell breaks Vundle -> set shell
set shell=/bin/bash

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/vundle'

Plugin 'tpope/vim-rails.git'
Plugin 'kien/ctrlp.vim'
Plugin 'https://github.com/avakhov/vim-yaml.git'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'mattn/webapi-vim'
Plugin 'gabrielelana/vim-markdown'
Plugin 'Keithbsmiley/rspec.vim'
Plugin 'jgdavey/tslime.vim'
Plugin 'travitch/hasksyn'
Plugin 'arsenerei/vim-ragel'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'scrooloose/syntastic'
Plugin 'airblade/vim-gitgutter'
Plugin 'chriskempson/base16-vim'
Plugin 'tmhedberg/matchit'
Plugin 'mkitt/tabline.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'wting/rust.vim'
Plugin 'groenewege/vim-less'
Plugin 'evidens/vim-twig'
" Plugin 'ahw/vim-hooks'

call vundle#end()

syntax on                         " show syntax highlighting
filetype off
filetype indent on

set autoindent                    " set auto indent
set ts=2                          " set indent to 2 spaces
set sw=2
set sts=2
set expandtab                     " use spaces, not tab characters
set nocompatible                  " don't need to be compatible with old vim
set relativenumber                " show relative line numbers
set number
set showmatch                     " show bracket matches
set ignorecase                    " ignore case in search
set hlsearch                      " highlight all search matches
set cursorline                    " highlight current line
set cursorcolumn
set smartcase                     " pay attention to case when caps are used
set incsearch                     " show search results as I type
set ttimeoutlen=100               " decrease timeout for faster insert with 'O'
set vb                            " enable visual bell (disable audio bell)
set ruler                         " show row and column in footer
set scrolloff=2                   " minimum lines above/below cursor
set laststatus=2                  " always show status bar
set list listchars=tab:»·,trail:· " show extra space characters
set nofoldenable                  " disable code folding
set clipboard=unnamedplus             " use the system clipboard
set wildmenu                      " enable bash style tab completion
set wildmode=list:longest,full
set encoding=utf-8                " The encoding displayed.
set fileencoding=utf-8            " The encoding written to file.
set synmaxcol=800                 " don't highlight lines longer than 800
set noshowmode

noremap <ScrollWheelUp>      <nop>
noremap <S-ScrollWheelUp>    <nop>
noremap <C-ScrollWheelUp>    <nop>
noremap <ScrollWheelDown>    <nop>
noremap <S-ScrollWheelDown>  <nop>
noremap <C-ScrollWheelDown>  <nop>
noremap <ScrollWheelLeft>    <nop>
noremap <S-ScrollWheelLeft>  <nop>
noremap <C-ScrollWheelLeft>  <nop>
noremap <ScrollWheelRight>   <nop>
noremap <S-ScrollWheelRight> <nop>
noremap <C-ScrollWheelRight> <nop>

" put useful info in status bar
set statusline=%F%m%r%h%w\ %{fugitive#statusline()}\ [%l,%c]\ [%L,%p%%]

syntax enable
set t_Co=256 " 256 color mode
set background=dark

" colorscheme monokai
" colorscheme hybrid
" colorscheme jellyx
" colorscheme base16-twilight
colorscheme base16-railscasts

syn match Todo "@todo" "@TODO" TODO todo contained

" set up some custom colors
highlight clear SignColumn
highlight ColorColumn  ctermbg=235
highlight LineNr       ctermbg=236 ctermfg=240
highlight CursorLineNr ctermfg=2 cterm=bold ctermbg=235
highlight CursorLine   ctermbg=235
highlight CursorColumn ctermbg=235
highlight StatusLine ctermfg=235 ctermbg=2
highlight SpecialKey ctermbg=green ctermfg=white
" highlight Search ctermfg=green
highlight Visual ctermfg=black
highlight ErrorMsg ctermbg=red ctermfg=white
highlight Todo ctermfg=2 ctermbg=235 cterm=bold

" set leader key to comma
let mapleader = ","

" ctrlp config
let g:ctrlp_map = '<leader>f'
let g:ctrlp_max_height = 30
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_show_hidden = 1

" use silver searcher for ctrlp
" let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" unmap F1 help
nmap <F1> :echo<CR>
imap <F1> <C-o>:echo<CR>

" map . in visual mode
vnoremap . :norm.<cr>

" die hash rockets, die!
vnoremap <leader>h :s/:\(\w*\) *=>/\1:/g<cr>

" map markdown preview
map <leader>m :!open -a Marked %<cr><cr>

" map git commands
map <leader>b :Gblame<cr>
map <leader>l :!clear && git log -p %<cr>
map <leader>d :!clear && git diff %<cr>

" check code complexity and duplication for current file
map <leader>x :!clear &&
 \ echo '----- Complexity -----' && flog % &&
 \ echo '\n----- Duplication -----' && flay %<cr>

" open gist after it's been created
let g:gist_open_browser_after_post = 1

" map Silver Searcher
" map <leader>a :Ag!<space>

" search for word under cursor with Silver Searcher
" map <leader>A :Ag! "<C-r>=expand('<cword>')<CR>"

" clear the command line and search highlighting
noremap <C-l> :nohlsearch<CR>

" toggle spell check with <F5>
map <F5> :setlocal spell! spelllang=en_us<cr>
imap <F5> <ESC>:setlocal spell! spelllang=en_us<cr>

" add :Plain command for converting text to plaintext
command! Plain execute "%s/’/'/ge | %s/[“”]/\"/ge | %s/—/-/ge"

" hint to keep lines short
if exists('+colorcolumn')
  set colorcolumn=120
endif

" execute current file
map <leader>e :call ExecuteFile(expand("%"))<cr>

" execute file if we know how
function! ExecuteFile(filename)
  :w
  :silent !clear
  if match(a:filename, '\.rb$') != -1
    exec ":!ruby " . a:filename
  elseif match(a:filename, '\.js$') != -1
    exec ":!node " . a:filename
  elseif match(a:filename, '\.sh$') != -1
    exec ":!bash " . a:filename
  else
    exec ":!echo \"Don't know how to execute: \"" . a:filename
  end
endfunction

" jump to last position in file
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" multi-purpose tab key (auto-complete)
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" rename current file, via Gary Bernhardt
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'))
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>n :call RenameFile()<cr>

noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
imap <S-Up> <nop>
imap <S-Down> <nop>
vmap <S-Up> <nop>
vmap <S-Down> <nop>
nmap <S-Up> <nop>
nmap <S-Down> <nop>
imap ^ <Esc>

" run specs with ',t' via Gary Bernhardt
function! RunTests(filename)
  " Write the file and run tests for the given filename
  :w
  :silent !clear
  if match(a:filename, '\.feature$') != -1
    :exec ":!bundle exec cucumber " . a:filename . "\n"
    :edit
  elseif match(a:filename, '_test\.rb$') != -1
    :exec ":!bundle exec ruby -Itest:lib " . a:filename . "\n"
    :edit
  elseif match(a:filename, '_spec\.rb$') != -1
    :exec ":!bundle exec rspec " . a:filename . "\n"
    :edit
  " else
  "   if filereadable("Gemfile")
  "     :exec ":bundle exec rspec --color " . a:filename . "\n"
  "     :edit
  "   else
  "     :exec ":!'rspec --color " . a:filename . "\n"
  "     :edit
  "   end
  end
endfunction

function! SetTestFile()
  " set the spec file that tests will be run for.
  let t:grb_test_file=@%
endfunction

function! RunTestFile(...)
  if a:0
    let command_suffix = a:1
  else
    let command_suffix = ""
  endif

  " run the tests for the previously-marked file.
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
  if in_test_file
    call SetTestFile()
  elseif !exists("t:grb_test_file")
    return
  end
  call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
  echo %
  let spec_line_number = line('.')
  call RunTestFile(":" . spec_line_number . " -b")
endfunction

" run test runner
map <leader>t :call RunTestFile()<cr>
map <leader>T :call RunNearestTest()<cr>


" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_php_checkers = ['phpcs', 'php']

hi SpellBad ctermfg=0 ctermbg=2
hi SpellCap ctermfg=0 ctermbg=2

let g:gitgutter_enabled = 0
map <leader>git :GitGutterToggle<cr>
map <leader>gb  :Gblame<cr>
map <leader>gs  :Gstatus<cr>
set linespace=0

highlight clear SignColumn
highlight GitGutterAdd ctermfg=green ctermbg=0
highlight GitGutterChange ctermfg=yellow ctermbg=0
highlight GitGutterDelete ctermfg=red ctermbg=0
highlight GitGutterChangeDelete ctermfg=yellow ctermbg=0

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

au BufRead,BufNewFile *.rs setfiletype rust
