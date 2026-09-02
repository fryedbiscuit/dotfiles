nest = require"nest"

return {
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-mini/mini.icons" },
		opts = {},
		config = function ()
			nest.applyKeymaps(
			{'<leader>', 
				{ 'f', {
					{'f', "<cmd>FzfLua files<cr>"},
					{'F', "<cmd>FzfLua filetypes<cr>"},
					{'b', "<cmd>FzfLua buffers<cr>"},
					{'g', "<cmd>FzfLua grep<cr>"},
					{'l', "<cmd>FzfLua blines<cr>"},
				},
			}})
		end
	}
}
