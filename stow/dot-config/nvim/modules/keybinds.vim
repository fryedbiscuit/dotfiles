" Basic
	let mapleader = "\<space>"
	nnoremap <esc> :noh<return><esc>

	nnoremap ,c :tabnew $MYVIMRC<cr>
	nnoremap ,k :tabnew ~/.config/nvim/modules/keybinds.vim<cr>
	nnoremap ,p :tabnew ~/.config/nvim/modules/plugins.vim<cr>
	nnoremap ,s :source ~/.config/nvim/init.vim<cr>

    nnoremap <leader>rr :w<cr>:!./%<cr>

" create local quickfix
   nnoremap <leader>td :lvimgrep TODO %<cr>
   nnoremap <leader>fm :lvimgrep FIXME %<cr>

	nnoremap <leader>ee :Lexplore<cr>
	nnoremap <leader>et :Texplore<cr>
	nnoremap <leader>sh :bot split<cr>:terminal<cr>:resize10<cr>

" External programs
	nnoremap <leader>lg :!lazygit<cr><cr>
	nnoremap <leader>vd :!vidir<cr><cr>

" Cargo terminal
	nnoremap <leader>cr :w<cr>:bot split term://cargo run<cr>
    nnoremap <leader>cc :w<cr>:bot split term://cargo check<cr>
    nnoremap <leader>cb :w<cr>:bot split term://cargo build<cr>
	nnoremap <leader>cf gg:.,$!rustfmt<cr><cr>

" Make
	nnoremap <leader>mm :w<cr>:!make<cr><cr>
	nnoremap <leader>mi :w<cr>:!sudo make install<cr><cr>
	nnoremap <leader>mc :w<cr>:!make clean<cr><cr>
	nnoremap <leader>mu :w<cr>:!sudo make uninstall<cr><cr>

" Emmet-vim
	nmap <leader>em <c-y>,
	" let g:user_emmet_leader_key=','

" vim-fugitive
	nnoremap <leader>g :G<cr>

" Vimwiki
	nnoremap <leader>x glx
	nnoremap <leader>= glp
	nnoremap <leader>- gln

" FZF
	nnoremap <leader>ff :Files<cr>
	nnoremap <leader>fF :Filetypes<cr>
	nnoremap <leader>fg :GFiles<cr>
	nnoremap <leader>fG :GFiles?<cr>
	nnoremap <leader>fl :BLines<cr>
	nnoremap <leader>fL :Locate<Space>
	nnoremap <leader>fm :Maps<cr>
	nnoremap <leader>fM :Marks<cr>
	nnoremap <leader>fb :Buffers<cr>
	nnoremap <leader>fc :Commands<cr>
	nnoremap <leader>fC :Colors<cr>
	nnoremap <leader>fw :Windows<cr>
	nnoremap <leader>fr :Rg<space>

" Calendar
	nnoremap <leader>cal :Calendar<cr>:vert resize25<cr>
	nnoremap <leader>cah :CalendarH<cr>

