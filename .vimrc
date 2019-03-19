set hlsearch
colorscheme ron
" set tabstop=4
set tabstop=8
set number

set guifont=Monospace\ 12px

function! AdjustFontSize(amount)
  if has("gui") 
    let font_data_list = split(&guifont)
	let font_data_list[1] = substitute(font_data_list[1], 'px', '', '')
	let delta = a:amount
	let font_data_list[1] = font_data_list[1] + delta
	
	" Attempt to counter the auto-increase/decrease of window.
	" How to do adjust column/row counts cleanly using &delta? 
	if (a:amount < 0)
		execute ":set co+=5"
		execute ":set lines+=3"
	else
		execute ":set co-=5"
		execute ":set lines-=3"
	endif
	
	let newfont = join(font_data_list, " ")
	let newfont = newfont . "px"
    let &guifont = newfont
  else
    echoerr "You need to run the GTK2 version of Vim to use this function."
  endif
endfunction

" mapping for font changing
nmap <A-=> :call AdjustFontSize(2)<CR>
nmap <A--> :call AdjustFontSize(-2)<CR>