syntax enable
if exists('$TMUX')
  set term=screen-256color
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
  augroup myCmds 
   au!
   autocmd VimEnter * silent !echo -ne "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\" 
  augroup END 
else
  let &t_SI = "\e[5 q"
  let &t_EI = "\e[3 q"
  let &t_SR = "\e[4 q" 
  augroup myCmds 
    au!
    " !{cmd} runs command in shell,  echo options -e enable exec of
    " backslash-escaped chars [\e = escape]
    " option -n do not output the trailing newline
    autocmd VimEnter * silent !echo -ne "\e[3 q"
    autocmd VimLeave * silent !echo -ne "\e[5 q"
  augroup END 
endif

"=======================================================================
autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif
      
" ====================================================
"              -----  PLUGINS  -----
" ====================================================
"
" Auto-install vim-plug plugins if they don't exist
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall  --sync | source $MYVIMRC
endif
" ******** BEGIN PLUGS TO INSTALL *********
call plug#begin('~/.vim/plugged')

" Good default settings
Plug 'tpope/vim-sensible'
" ..................UI ENHANCEMENT....................
" Atom color scheme | https://github.com/joshdick/onedark.vim
Plug 'joshdick/onedark.vim'
" Dark color scheme with excellent syntax differentiation
 Plug 'mhartington/oceanic-next'
" Fancy start screen
" Plug 'mhinz/vim-startify'
" Solarized color scheme | http://vimawesome.com/plugin/vim-colors-solarized-ours
Plug 'altercation/vim-colors-solarized'
" Indent guides
Plug 'nathanaelkane/vim-indent-guides'
" Goyo - distraction free writing | https://github.com/junegunn/goyo.vim
Plug 'junegunn/goyo.vim'
" NERDTree + load on-demand | https://github.com/scrooloose/nerdtree
Plug 'scrooloose/nerdtree' ", { 'on': 'NERDTreeToggle' }
Plug 'jistr/vim-nerdtree-tabs'
" Git plugin for NERDTree | https://github.com/Xuyuanp/nerdtree-git-plugin
" Plug 'Xuyuanp/nerdtree-git-plugin'
" Font Icons for NERDTree
Plug 'ryanoasis/nerd-fonts'
" HTML tag highlighting
Plug 'gregsexton/matchtag'
" Airline Custom statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Navigate TMUX panes | https://github.com/christoomey/vim-tmux-navigator
Plug 'christoomey/vim-tmux-navigator'
" ...................SYNTAX SUPPORT...................
" Syntastic- tons of syntax checking support like eslint
Plug 'scrooloose/syntastic'
" HTML5 syntax highlighting and indentation + inline SVG omnicomplete function 
Plug 'othree/html5.vim'
" Javascript syntax highlighting and indentation 
Plug 'pangloss/vim-javascript'
" JSX syntax support | https://github.com/mxw/vim-jsx
Plug 'mxw/vim-jsx'
" Typescript | https://github.com/leafgarland/typescript-vim 
Plug 'leafgarland/typescript-vim'
" JSON syntax highlighting and error reporting
Plug 'elzr/vim-json'
" Markdown syntax highlighting support
Plug 'plasticboy/vim-markdown'
" Preview CSS colors inline
Plug 'ap/vim-css-color'
" ....................MISC UTILITIES.................
" Tern code completion engine
" Plug 'marijnh/tern_for_vim'
" Code completion | https://github.com/valloric/youcompleteme
" Plug 'valloric/youcompleteme'
" Text completion for all visible text in TMUX window | https://github.com/wellle/tmux-complete.vim
Plug 'wellle/tmux-complete.vim'
" CTRLP easy file search, etc | https://github.com/ctrlpvim/ctrlp.vim
Plug 'ctrlpvim/ctrlp.vim'
" Respect .gitignore in plugins like ctrlp | https://github.com/octref/rootignore 
Plug 'octref/rootignore'
" easy comment out blocks of code  with \cc | https://github.com/scrooloose/nerdcommenter
Plug 'scrooloose/nerdcommenter'
" Git wrapper | https://github.com/tpope/vim-fugitive
Plug 'tpope/vim-fugitive'
" HTML, PHP, XML, etc close tags via `tag`<C-x><space>||<enter> https://github.com/tpope/vim-ragtag
Plug 'tpope/vim-ragtag'
" Surround : delete `ds` | add `ys`[motion] | change `cs`[motion] 
Plug 'tpope/vim-surround'
" Emmet
Plug 'mattn/emmet-vim'
" Better Vim session management | https://github.com/tpope/vim-obsession
Plug 'tpope/vim-obsession'
" auto close various code tags | http://vimawesome.com/plugin/autoclose
Plug 'townk/vim-autoclose'
" Tag Bar for easy view code tags | https://github.com/majutsushi/tagbar
" Plug 'majutsushi/tagbar'
" Auto update tags file for yarious file types | https://github.com/xolox/vim-easytags
" Plug 'xolox/vim-easytags'
" Plug 'xolox/vim-misc
" Jump around a file | https://github.com/easymotion/vim-easymotion
"Plug 'easymotion/vim-easymotion'
" Vim Sneak - jump to location with s/S-{char}{char}
Plug 'justinmk/vim-sneak'
" Sublime Text style Multi-cursor
Plug 'terryma/vim-multiple-cursors'
" Dev Icons
Plug 'ryanoasis/vim-devicons'
" color for devicons in Nerdtree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
call plug#end()
" ********** END PLUGS TO INSTALL *********
"............................................................ 
"============================================================


"============================================================
"       ------  NEW KEY MAPPINGS  -------- 
"============================================================
"
" .......... MIN DELAY EXITING INSERT MODE ..........
set timeoutlen=1000 ttimeoutlen=10
" .......... LEADER KEY REMAP .........
let mapleader = " "
" ........... ESC with jj ..........
inoremap jj <Esc>
"GOYO mode
"--------------------------------------------------
map <F10> :Goyo<CR>
" NERDTree
"-------------------------------------------------- 
" Open NERDtree shortcut -  and  F3 for open to current file highlighted
silent! nmap <Leader><Leader>ne :NERDTreeToggle<CR>
silent! map <F3> :NERDTreeFind<CR>
" Open NERDTree on current file <leader>f
nnoremap <silent> <Leader>f :NERDTreeFind<CR>
let g:NERDTreeMapPreview = "<F4>"
let g:NERDTreeMapActiveNode = "<F3>"
" VIM LEADER MAPPINGS
"-------------------------------------------------- 
" save file
nnoremap <Leader>. :w<CR>
" splits navigation
nnoremap <Leader><Leader>v <C-W>v
nnoremap <Leader><Leader>h <C-W>S
nnoremap <Leader>h <C-W><C-H>
nnoremap <Leader>l <C-W><C-L>
" splits sizing
  " --max height
silent! nnoremap <Leader><Leader>_ <C-W>_
  " --max width
silent! nnoremap <Leader><Leader><Bar> <C-W><Bar>
  " --normalize
silent! nnoremap <Leader><Leader>= <C-W>=
" Indent text
nnoremap <Leader>] >>
nnoremap <Leader>[ <<
vnoremap <Leader>] >gv
vnoremap <Leader>[ <gv
" buffer navigation
nnoremap <Leader><Tab> :b#<CR>
nnoremap <Leader><Leader><Tab> :bnext<CR>
nnoremap <Leader><Leader>x :bd<CR> 
" Syntastic Shortcuts= show location list | next error | prev error | toggle live lint
nnoremap <Leader>se :Errors<CR> 
nnoremap <Leader>sn :lnext<CR>
nnoremap <Leader>sb :lprevious<CR>
nnoremap <Leader>st :SyntasticToggleMode<CR>
" ctrl P
nnoremap <Leader>z :CtrlPMixed<CR>
nnoremap <Leader>f :CtrlPBuffer<CR>
nnoremap <Leader>n :CtrlP<CR>
" code nav 
nnoremap <Leader>e $
nnoremap <Leader>b ^
nnoremap <Leader>d <C-d>
nnoremap <Leader>u <C-u>
nnoremap <Leader>\ %
" easyMotion
" let g:EasyMotion_leader_key = ';'
" code editing
map u <Nop>
nnoremap <Leader>i i<Space><Esc>
nnoremap <Leader><Leader><Leader>u :undo<CR>
nnoremap <Leader>j <C-f>
nnoremap <Leader>k <C-b>
nnoremap <Leader>md :m+<CR>== 
nnoremap <Leader>mu :m .-2<CR>==
vnoremap <Leader>md :m '>+1<CR>gv=gv
vnoremap <Leader>mu :m '<-2<CR>gv=gv
nnoremap <Leader>c yy
vnoremap <Leader>c Vy
nnoremap <Leader>v P
vnoremap <Leader>v P
" MISC
"--------------------------------------------------
" change split screen nav from <C-w>j to just ctrl+j etc...
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" tmux-complete command via vim's `omnifunc` == `<C-space> or <C-X><C-O>`
let g:tmuxcomplete#trigger = 'omnifunc'
" Soft CAPS LOCK | Execute 'lnoremap x X' and 'lnoremap X x' for each letter a-z.
for c in range(char2nr('A'), char2nr('Z'))
  execute 'lnoremap ' . nr2char(c+32) . ' ' . nr2char(c)
  execute 'lnoremap ' . nr2char(c) . ' ' . nr2char(c+32)
endfor
" Kill the CAPSLOCK when leaving insert mode.
autocmd InsertLeave * set iminsert=0


" ===============================================
"        ------  UI CUSTOMIZATIONS  ------
" ===============================================
"
" Colors...
colorscheme onedark 
" Splits...
set splitbelow
set splitright
" NERDTree...
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.swp$','\.git$']
let NERDTreeMinimalUI=1
let NERDTreeQuitOnOpen=1
let g:NERDTreeDirArrowExpandable=""
let g:NERDTreeDirArrowCollapsible=""
let g:webdevicons_enable_nerdtree=1
let g:WebDevIconsUnicodeGlyphDoubleWidth=0
let g:WebDevIconsNerdTreeAfterGlyphPadding=''
let g:WebDevIconsUnicodeDecorateFolderNodes=0
let g:DevIconsEnableFoldersOpenClose=1
let g:DevIconsDefaultFolderOpenSymbol=' '
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol=' '
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['js']=''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['json']=''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['css']=''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['html']='' 
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['md']=''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['scss']=''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['php']=''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['.gitignore']=''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['Procfile']=''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['README.md']=''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['package.json']=''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['node_modules']=' '
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['webpack.config.dev.js']=''
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['webpack.config.prod.js']=''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['webpack*'] = ''
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 0
" Icon colors0900B8
let s:brown = "905532"
let s:aqua =  "3AFFDB"
let s:blue = "0071EB"
let s:darkBlue = "0900B8"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:red = "AE403F"
let s:beige = "F5C06F"
let s:yellow = "FFF700"
let s:orange = "EB9100"
let s:darkOrange = "A86800"
let s:pink = "CB6F6F"
let s:salmon = "EE6E73"
let s:green = "8FAA54"
let s:lightGreen = "66FF66"
let s:white = "FFFFFF"
let s:rspec_red = 'FE405F'
let s:git_orange = 'F54D27'
let g:NERDTreeExtensionHighlightColor={} " this line is needed to avoid error
let g:NERDTreeExtensionHighlightColor['css']=s:blue " sets the color of css files to blue
let g:NERDTreeExtensionHighlightColor['js']=s:yellow
let g:NERDTreeExactMatchHighlightColor={} " this line is needed to avoid error
let g:NERDTreeExactMatchHighlightColor['.gitignore']=s:git_orange " sets the color for .gitignore files
let g:NERDTreeExactMatchHighlightColor['package.json']=s:green 
let g:NERDTreePatternMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreePatternMatchHighlightColor['.*_spec\.rb$']=s:rspec_red " sets the color for files ending with _spec.rb

" NERDTree tabs: 1=on 2=on-if-open-on-dir 0=off
let g:nerdtree_tabs_open_on_gui_startup = 2
let g:nerdtree_tabs_open_on_console_startup = 2
let g:nerdtree_tabs_startup_cd = 0
let g:nerdtree_tabs_open_on_new_tab = 1
" Line numbers
set number
" set the width of line number margin
set nuw=1
" .jsx not required to recognize jsx syntax
let g:jsx_ext_required = 0
" recognize jsDoc commenting
let g:javascript_plugin_jsdoc = 1
" recognize NGDoc
let g:javascript_plugin_ngdoc = 1
" no word wrapping
set formatoptions-=t
set nowrap
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
 "If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
 "(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
" if (empty($TMUX))
"   if (has("nvim"))
     "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
"     let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"   endif
   "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
   "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
   " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
"   if (has("termguicolors"))
"     set termguicolors
"   endif
" endif
"............................................................ 
"============================================================


"============================================================
"     --------   SYNTASTIC SETTINGS  ---------
"============================================================
"
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0 " auto open location list when errors?
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_sass_checkers=['sass']
let g:syntastic_html_checkers=['tidy']
let g:syntastic_css_checkers=['csslint'] " csslint --list-rules ...for list of css rules
" let g:syntastic_csslint_args="--ignore=outline-none"
let g:syntastic_loc_list_height = 5 " height of location list for errors 
let g:typescript_indent_disable = 1


"=============================================================
" ------------ CTRLP CUSTOMIZATIONS -------------
"=============================================================

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_working_path_mode = 'c'
let g:ctrlp_root_markers = ['pom.xml', '.p4ignore']
let g:ctrlp_user_command = 'find %s -type f'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

"============================================================
"           -------  CUSTOM TAB INDENTS  --------
"============================================================
"
" tabstop = max width of a tab char, shiftwidth = size of an indent in spaces
" softtabstop = when nonzero makes tab key insert a combo of spaces to
" simulate tab stops at this width
" expandtab = when enabled makes the tab key insert spaces instead of tabs
" smarttab = when enabled makes the tab key insert spaces or tabs to the next
" indent of the next tabstop
set tabstop=4 softtabstop=0 expandtab shiftwidth=2 smarttab
" syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

"=============================================================
"        ----------  GOYO CUSTOMIZATIONS  ---------
"=============================================================

let g:goyo_linenr = 0
let g:goyo_width = 50+25
let g:goyo_height = 95

function! s:goyo_enter()
  silent !tmux set status off
  silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  set noshowmode
  set noshowcmd
  set scrolloff=999
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  set showmode
  set showcmd
  set scrolloff=5
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

"==============================================================
"      -------  VIM AIRLINE CUSTOMIZATIONS  ---------
"==============================================================

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#exclude_preview = 1
" show tab numbers 1=tab-num 2=tab-num+num-splits
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_tab_type = 1
" tabline filename modifiers
let g:airline#extensions#tabline#fnamemod = ':t:r'
" tabline separators
" set guifont=ProFont\ IIx\ Nerd\ Font\ Complete\ 15
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep=' '
let g:airline#extensions#tabline#right_alt_sep=''
let g:airline_left_sep=""
let g:airline_left_alt_sep=""
let g:airline_right_sep=""
let g:airline_right_alt_sep=""
let g:airline#extensions#whitespace#checks = []
let g:airline_skip_empty_sections = 1
set laststatus=2
let g:airline_theme='murmur'
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#branch#enabled = 1
"let g:airline_section_y=''
"let g:airline_section_z=''
"let g:airline_section_x=''
let g:airline#extensions#default#layout = [
      \ [ 'a', 'b' ],
      \ [ 'error', 'warning' ]
      \ ]
