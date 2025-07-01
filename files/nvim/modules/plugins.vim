call plug#begin('~/.config/nvim/plugged')

" Plugins
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-eunuch'
	Plug 'airblade/vim-gitgutter'
	Plug 'vimwiki/vimwiki'
	Plug 'junegunn/fzf'
	Plug 'junegunn/fzf.vim'
	Plug 'jamessan/vim-gnupg'
	" Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
	Plug 'mattn/emmet-vim'
	" Plug 'mattn/calendar-vim'
	Plug 'neoclide/coc.nvim', {'branch': 'release'} "Autocomplete
    Plug 'mtdl9/vim-log-highlighting'
	" Plug 'dhruvasagar/vim-table-mode'
	" Plug 'liuchengxu/vim-which-key'

"	# Color Schemes
	" Plug 'dracula/vim'
	" Plug 'zefei/simple-dark'
	" Plug 'ParamagicDev/vim-medic_chalk'
	" Plug 'atahabaki/archman-vim'
	" Plug 'tomasr/molokai'
	" Plug 'morhetz/gruvbox'
	" Plug 'tpope/vim-vividchalk'
	" Plug 'junegunn/seoul256.vim'
	" Plug 'joshdick/onedark.vim'
	Plug 'tomasiser/vim-code-dark'

call plug#end()

" Plugin Configs
	" GitGutter
	highlight GitGutterAdd guifg=#009900 ctermfg=Green
	highlight GitGutterChange guifg=#bbbb00 ctermfg=Yellow
	highlight GitGutterDelete guifg=#ff2222 ctermfg=Red
	let g:gitgutter_enable = 1

	" Vimwiki
	let g:vimwiki_folding='list'
	" let g:vimwiki_folding='expr'

	let wiki = {}
	let wiki.path = '~/vimwiki/'
	" let wiki.syntax = 'markdown'
	" let wiki.ext = '.md'
	let wiki.nested_syntaxes = {'bash' : 'bash', 'python': 'python', 'c++': 'cpp'}
	let wiki.inks_space_char = '_'

	let g:vimwiki_list = [wiki]
	" let g:vimwiki_global_ext=0
	let g:vimwiki_ext2syntax = {'.wiki': 'default'}
	" let g:vimwiki_listsyms = '✗○◐●✓'
	function! VimwikiFindIncompleteTasks()
		lvimgrep /- \[ \]/ %:p
		lopen
	endfunction

	function! VimwikiFindAllIncompleteTasks()
		VimwikiSearch /- \[ \]/
		lopen
	endfunction

	nmap <Leader>wa :call VimwikiFindAllIncompleteTasks()<CR>
	nmap <Leader>wx :call VimwikiFindIncompleteTasks()<CR>

	function! VimwikiLinkHandler(link)
	" Use sxiv to open external images.  E.g.:
	"   1) [[sxiv:path/to/image.png]]
	let link = a:link
	if link =~# '^ifile:'
	 let link = link[1:]
	else
	 return 0
	endif
	let link_infos = vimwiki#base#resolve_link(link)
	if link_infos.filename == ''
	 echomsg 'Vimwiki Error: Unable to resolve link!'
	 return 0
	else
	 " exe 'tabnew ' . fnameescape(link_infos.filename)
	 call system("sxiv " . fnameescape(link_infos.filename) . " &")
	 return 1
	endif
	endfunction

	"Calendar
	let g:calendar_no_mappings=1

    "Semshi
    let g:python3_host_prog = '/usr/bin/python3'
    nnoremap <leader>sr :Semshi rename
