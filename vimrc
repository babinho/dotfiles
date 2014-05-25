set nocompatible
" Use Pathogen:
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" ========================================================================
" Vundle stuff
" ========================================================================
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage Vundle (required)!
Bundle 'gmarik/vundle'

" My bundles
Bundle 'ervandew/supertab'

Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-unimpaired'
Bundle 'kana/vim-textobj-user'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'tpope/vim-bundler'

Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-markdown'
Bundle 'koron/nyancat-vim'
Bundle 'vim-scripts/ruby-matchit'
Bundle 'kien/ctrlp.vim'
Bundle 'bronson/vim-trailing-whitespace'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"

Bundle "garbas/vim-snipmate"
Bundle 'tpope/vim-commentary'
Bundle 'honza/vim-snippets'

" Clojure
Bundle 'tpope/vim-fireplace'
Bundle 'tpope/vim-classpath'
Bundle 'guns/vim-clojure-static'

" Go Support
Bundle 'jnwhiteh/vim-golang'
Bundle 'Blackrush/vim-gocode'

" Elixir
Bundle 'elixir-lang/vim-elixir'

" tmux support
Bundle "benmills/vimux"
Bundle 'jgdavey/vim-turbux'
Bundle "christoomey/vim-tmux-navigator"

" ember here we go
Bundle 'mustache/vim-mustache-handlebars'
Bundle 'dsawardekar/ember.vim'

runtime macros/matchit.vim

" ================
" Ruby stuff
" ================
syntax on                 " Enable syntax highlighting
filetype plugin indent on " Enable filetype-specific indenting and plugins

augroup myfiletypes
  " Clear old autocmds in group
  autocmd!
  " autoindent with two spaces, always expand tabs
  au FileType ruby,eruby,yaml set ai sw=2 sts=2 et
augroup END
" ================

let mapleader = ","

map <Leader>bb :!bundle install<cr>
nmap <Leader>bi :source ~/.vimrc<cr>:BundleInstall<cr>
map <Leader>f :call OpenFactoryFile()<CR>
map <Leader>fw :FixWhitespace<CR>
map <Leader>fix :cnoremap % %<CR>
map <Leader>h :nohl<CR>
map <Leader>i mmgg=G`m<CR>
map <Leader>so :so %<cr>
map <Leader>vi :tabe ~/.vimrc<CR>
map <leader>z :call ToggleSpring()<CR>

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
map <Leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>s :split <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>v :vnew <C-R>=expand("%:p:h") . '/'<CR>

" Read file from the same directory in the current buffer
map <Leader>r :r <C-R>=expand("%:p:h") . '/'<CR>

map <C-n> :cn<CR>

set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=500		" keep 500 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set autoindent
set showmatch
set nowrap
set backupdir=~/.tmp
set directory=~/.tmp " Don't clutter my dirs up with swp and tmp files
set autoread
set wmh=0
set viminfo+=!
set guioptions-=T
set et
set sw=2
set smarttab
set noincsearch
set ignorecase smartcase
set laststatus=2  " Always show status line.
set nu
set rnu
set gdefault " assume the /g flag on :s substitutions to replace all matches in a line
set autoindent " always set autoindenting on

" Set the tag file search order
set tags=./tags;

" Use _ as a word-separator
" set iskeyword-=_

" Use Silver Searcher instead of grep
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  " bind \ (backward slash) to grep shortcut
  command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

  nnoremap \ :Ag<SPACE>
endif

" Get rid of the delay when hitting esc!
set noesckeys

" Fuzzy finder: ignore stuff that can't be opened, and generated files
let g:fuzzy_ignore = "*.png;*.PNG;*.JPG;*.jpg;*.GIF;*.gif;coverage/**;tmp/**;rdoc/**"

" Format xml files
au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

set shiftround " When at 3 spaces and I hit >>, go to 4, not 5.

set nofoldenable " Say no to code folding...

command! Q q " Bind :Q to :q
command! Qall qall


" Disable Ex mode
map Q <Nop>

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" When loading text files, wrap them and don't split up words.
au BufNewFile,BufRead *.txt setlocal wrap
au BufNewFile,BufRead *.txt setlocal lbr

" Better? completion on command line
set wildmenu
" What to do when I press 'wildchar'. Worth tweaking to see what feels right.
set wildmode=list:full

" (Hopefully) removes the delay when hitting esc in insert mode
set noesckeys
set ttimeout
set ttimeoutlen=1

" Turn on spell-checking in markdown and text.
au BufRead,BufNewFile *.md,*.txt,*.markdown setlocal spell

" Turn on spell-checking in gitcommits
au FileType gitcommit setlocal spell

" Merge a tab into a split in the previous window
function! MergeTabs()
  if tabpagenr() == 1
    return
  endif
  let bufferName = bufname("%")
  if tabpagenr("$") == tabpagenr()
    close!
  else
    close!
    tabprev
  endif
  split
  execute "buffer " . bufferName
endfunction

nmap <C-W>u :call MergeTabs()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Test-running stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RunCurrentTest()
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
  if in_test_file
    call SetTestFile()

    if match(expand('%'), '\.feature$') != -1
      call SetTestRunner("!zeus cucumber")
      exec g:bjo_test_runner g:bjo_test_file
    elseif match(expand('%'), '_spec\.rb$') != -1
      call SetTestRunner("!bundle exec rspec")
      exec g:bjo_test_runner g:bjo_test_file
    else
      call SetTestRunner("!bundle exec m")
      exec g:bjo_test_runner g:bjo_test_file
    endif
  else
    exec g:bjo_test_runner g:bjo_test_file
  endif
endfunction

function! SetTestRunner(runner)
  let g:bjo_test_runner=a:runner
endfunction

function! RunCurrentLineInTest()
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
  if in_test_file
    call SetTestFileWithLine()
  end

  if match(expand('%'), '\.feature$') != -1
    call SetTestRunner("!zeus cucumber")
  elseif match(expand('%'), '_spec\.rb$') != -1
    call SetTestRunner("!rspec")
  elseif match(expand('%'), '_test\.rb$') != -1
    call SetTestRunner("!bundle exec m")
  end
  exec g:bjo_test_runner g:bjo_test_file . ":" . g:bjo_test_file_line
endfunction

function! SetTestFile()
  let g:bjo_test_file=@%
endfunction

function! SetTestFileWithLine()
  let g:bjo_test_file=@%
  let g:bjo_test_file_line=line(".")
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Spring toggle and turbux integration
let g:spring_enabled='false'

fun! ToggleSpring()
  if g:spring_enabled == 'true'
    let g:spring_enabled='false'
    let g:turbux_command_prefix=''
    :!spring stop
    echo 'Spring is disabled'
  else
    let g:spring_enabled='true'
    let g:turbux_command_prefix='spring'
    :!spring
    echo 'Spring is enabled'
  endif
endfun
""""""""""""""""""""""""""""""

" Let's be reasonable, shall we?
nmap k gk
nmap j gj


" Don't add the comment prefix when I hit enter or o/O on a comment line.
set formatoptions-=or


function! OpenJasmineSpecInBrowser()
  let filename = expand('%')
  "                  substitute(exprsson, pattern,            substitution,    flags)
  let url_fragment = substitute(filename, "spec/javascripts", "evergreen/run", "")
  let host_fragment = "http://localhost:3001/"
  let url = host_fragment . url_fragment
  silent exec "!open ~/bin/chrome" url
endfunction

set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

let g:CommandTMaxHeight=50
let g:CommandTMatchWindowAtTop=1

" Don't wait so long for the next keypress (particularly in ambigious Leader
" situations.
set timeoutlen=500

function! OpenFactoryFile()
  if filereadable("test/factories.rb")
    execute ":sp test/factories.rb"
  else
    execute ":sp spec/factories.rb"
  end
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE (thanks Gary Bernhardt)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <Leader>n :call RenameFile()<cr>

" Moving through splits normally
map <C-h> <C-w><C-h>
map <C-j> <C-w><C-j>
map <C-k> <C-w><C-k>
map <C-l> <C-w><C-l>

" natural split opening
set splitbelow
set splitright

" ========================================================================
" End of things set by me.
" ========================================================================

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

set t_Co=256
colorscheme grb256

" Make the omnicomplete text readable
highlight PmenuSel ctermfg=black

" Highlight the status line
" highlight StatusLine ctermfg=blue ctermbg=yellow

" Set gutter background to black
" highlight SignColumn ctermbg=black

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType markdown setlocal textwidth=78

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
          \   exe "normal g`\"" |
          \ endif

  augroup END

  " Clean whitespace in ruby and haml
  au BufWritePre *.rb,*.rake,*.js FixWhitespace

endif " has("autocmd")

" some stuff to get the mouse working in the term
set mouse=a
set ttymouse=xterm2

" open markdown files in marked
command! Marked silent !open -a "Marked.app" "%:p"

" don't clear screen when background/resume
" set t_ti= t_te=

set wildignore+=*.so,*.swp,*.zip

" don't redraw after each macro run
set lazyredraw

