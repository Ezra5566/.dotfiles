"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ███████╗███████╗███████╗           ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
" ██╔════╝╚══███╔╝╚══███╔╝           ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
" █████╗    ███╔╝   ███╔╝            ██║   ██║██║██╔████╔██║██████╔╝██║     
" ██╔══╝   ███╔╝   ███╔╝             ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║     
" ███████╗███████╗███████╗    ███████╗╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
" ╚══════╝╚══════╝╚══════╝    ╚══════╝ ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" {{{ GENERAL Settings
set ts=4 sw=4 so=8 nu rnu
set list
set lcs=tab:▏\ 
set background=dark
set showtabline=2 laststatus=2
set scrolloff=8
set wildmenu
set noshowmode
set nowrap
set hidden
set timeoutlen=200
let g:mapleader = " "
filetype indent on
syntax on
set nofoldenable
set fdm=syntax
" }}}


" {{{ KEYMAPS
inoremap <nowait>   jk <Esc>
nnoremap <space>r   :w<CR><cmd>!gcc % && ./a.out<CR>
nnoremap <Tab>      :bnext<CR>
nnoremap <TAB>      :bnext<CR>
nnoremap <S-TAB>    :bprevious<CR>
inoremap (          ()<Esc>i
inoremap {          {}<Esc>i
nnoremap <leader>w  :bd<CR>
" }}}

" {{{ PALETTE
let s:palette = {
	\ 'black':      ['#06080a',   '237',  'DarkGrey'],
	\ 'bg0':        ['#1a1b26',   '233',  'Black'],
	\ 'bg1':        ['#232433',   '233',  'DarkGrey'],
	\ 'bg2':        ['#2a2b3d',   '236',  'DarkGrey'],
	\ 'bg3':        ['#32344a',   '237',  'DarkGrey'],
	\ 'bg4':        ['#3b3d57',   '237',  'Grey'],
	\ 'bg_red':     ['#ff7a93',   '203',  'Red'],
	\ 'diff_red':   ['#803d49',   '52',   'DarkRed'],
	\ 'bg_green':   ['#b9f27c',   '107',  'Green'],
	\ 'diff_green': ['#618041',   '22',   'DarkGreen'],
	\ 'bg_blue':    ['#7da6ff',   '110',  'Blue'],
	\ 'diff_blue':  ['#3e5380',   '17',   'DarkBlue'],
	\ 'fg':         ['#a9b1d6',   '250',  'White'],
	\ 'red':        ['#F7768E',   '203',  'Red'],
	\ 'orange':     ['#FF9E64',   '215',  'Orange'],
	\ 'yellow':     ['#E0AF68',   '179',  'Yellow'],
	\ 'green':      ['#9ECE6A',   '107',  'Green'],
	\ 'blue':       ['#7AA2F7',   '110',  'Blue'],
	\ 'purple':     ['#ad8ee6',   '176',  'Magenta'],
	\ 'grey':       ['#444B6A',   '246',  'LightGrey'],
	\ 'none':       ['NONE',      'NONE', 'NONE']
\ }

function! s:HL(group, fg, bg, ...)
	let hl_string = [ 'highlight', a:group, 'ctermfg=' . a:fg[1], 'ctermbg=' . a:bg[1] ]
	if a:0 >= 1
	  if a:1 ==# 'undercurl'
		call add(hl_string, 'cterm=underline')
	  else
		call add(hl_string, 'cterm=' . a:1)
	  endif
	else
	  call add(hl_string, 'cterm=NONE')
	endif
	execute join(hl_string, ' ')
endfunction
" }}}

" {{{ Calling COLORS
call s:HL('Fg', s:palette.fg, s:palette.none)
call s:HL('Grey', s:palette.grey, s:palette.none)
call s:HL('Red', s:palette.red, s:palette.none)
call s:HL('Orange', s:palette.orange, s:palette.none)
call s:HL('Yellow', s:palette.yellow, s:palette.none)
call s:HL('Green', s:palette.green, s:palette.none)
call s:HL('Blue', s:palette.blue, s:palette.none)
call s:HL('Purple', s:palette.purple, s:palette.none)

call s:HL('Normal', s:palette.fg, s:palette.bg0)
call s:HL('EndOfBuffer', s:palette.bg0, s:palette.bg0)
call s:HL('FoldColumn', s:palette.grey, s:palette.bg1)
call s:HL('Folded', s:palette.grey, s:palette.bg1)
call s:HL('ErrorMsg', s:palette.red, s:palette.none, 'bold,underline')
call s:HL('WarningMsg', s:palette.yellow, s:palette.none, 'bold')
call s:HL('ModeMsg', s:palette.fg, s:palette.none, 'bold')
call s:HL('IncSearch', s:palette.bg0, s:palette.bg_red)
call s:HL('Search', s:palette.bg0, s:palette.bg_green)
call s:HL('MatchParen', s:palette.none, s:palette.bg4)
call s:HL('StatusLine', s:palette.fg, s:palette.bg3)
call s:HL('TabLine', s:palette.fg, s:palette.bg4)
call s:HL('TabLineFill', s:palette.grey, s:palette.bg1)
call s:HL('TabLineSel', s:palette.bg0, s:palette.bg_red)
call s:HL('VertSplit', s:palette.black, s:palette.none)
call s:HL('Visual', s:palette.none, s:palette.bg3)
call s:HL('Include', s:palette.red, s:palette.none)
call s:HL('Keyword', s:palette.red, s:palette.none)
call s:HL('Define', s:palette.red, s:palette.none)
call s:HL('Typedef', s:palette.red, s:palette.none)
call s:HL('Exception', s:palette.red, s:palette.none)
call s:HL('Conditional', s:palette.red, s:palette.none)
call s:HL('Repeat', s:palette.red, s:palette.none)
call s:HL('Statement', s:palette.red, s:palette.none)
call s:HL('Error', s:palette.red, s:palette.none)
call s:HL('Label', s:palette.purple, s:palette.none)
call s:HL('Special', s:palette.purple, s:palette.none)
call s:HL('SpecialChar', s:palette.purple, s:palette.none)
call s:HL('Boolean', s:palette.purple, s:palette.none)
call s:HL('String', s:palette.yellow, s:palette.none)
call s:HL('Character', s:palette.yellow, s:palette.none)
call s:HL('Number', s:palette.purple, s:palette.none)
call s:HL('Float', s:palette.purple, s:palette.none)
call s:HL('Function', s:palette.green, s:palette.none)
call s:HL('Operator', s:palette.red, s:palette.none)
call s:HL('Title', s:palette.red, s:palette.none, 'bold')
call s:HL('Tag', s:palette.orange, s:palette.none)
call s:HL('Delimiter', s:palette.fg, s:palette.none)
call s:HL('Comment', s:palette.grey, s:palette.none)
highlight! link cLabel Red
highlight! link cppSTLnamespace BlueItalic
highlight! link cppSTLtype BlueItalic
highlight! link cppAccess Red
highlight! link cppStructure Red
highlight! link cppSTLios BlueItalic
highlight! link cppSTLiterator BlueItalic
highlight! link cppSTLexception Red
highlight! link cppSTLVariable BlueItalic
hi! LineNr ctermfg=8
hi! SpecialKey ctermfg=246
" }}}

" {{{ Comment Function
function! ToggleComment()
	if getline('.') =~ "^\\s*// "
		execute 'norm ^xxx'
	else
		execute 'norm I// '
	endif
endfunction

vnoremap <leader>/ :call ToggleComment()<CR>
nnoremap <leader>/ :call ToggleComment()<CR>
" }}}

" {{{ Statusline
set stl=\ %#Nice#\ %f
set stl+=%=%l/%L\ :%c\ \ \ \ 
set stl+=%#Nice#\ 

hi! Statusline ctermbg=1 ctermfg=232
hi! Nice ctermbg=none ctermfg=none
hi! TablineSel ctermbg=none ctermfg=1
" }}}

" {{{ Tabline
function! Nice()
	let nice = repeat(' ', &columns/2-10) . "%#Statusline# %M %f %##"
	return nice
endfunction
set tabline=%!Nice()
" }}}

au! BufWritePost $MYVIMRC source %
" vim: fdm=marker
