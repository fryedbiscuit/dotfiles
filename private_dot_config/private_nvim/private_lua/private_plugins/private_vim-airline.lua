return {
	{"vim-airline/vim-airline"},
	{"vim-airline/vim-airline-themes"},
	{
		"bling/vim-bufferline",
		init = function()
			vim.g.bufferline_echo = 0
		end
	},
}

