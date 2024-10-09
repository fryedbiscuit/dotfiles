" Move in quickfix list
nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprev<CR>

" Move in location list
nnoremap <M-j> :lnext<CR>
nnoremap <M-k> :lprev<CR>

" Toggle lists
nnoremap <C-q> :call ToggleQFList(1)<CR>
nnoremap <C-l> :call ToggleQFList(0)<CR>

let g:qf_open = 0
let g:ll_open = 0

fun! ToggleQFList(global)
	if a:global == 1
		" Opens and closes quickfix
		if g:qf_open == 1
			let g:qf_open = 0
			cclose
		else
			let g:qf_open = 1
			copen
		endif
	else
		if g:ll_open == 1
			let g:ll_open = 0
			lclose
		else
			let g:ll_open = 1
			lopen
		endif
	endif
endfun
