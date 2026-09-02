local nest = require("nest")

require"nest".applyKeymaps({",r", "<cmd>w<cr><cmd>!tcc -run %<cr>"})

local function toggle_loclist()
  local is_open = vim.fn.getloclist(0, { winid = 0 }).winid ~= 0

  if is_open then
    vim.cmd("lclose")
  elseif #vim.fn.getloclist(0) > 0 then
    vim.cmd("lopen")
  else
    vim.notify("Location list is empty", vim.log.levels.WARN)
  end
end

nest.applyKeymaps {
	{ ",", 
		{ "c", "<cmd>tabnew<cr><cmd>e ~/.config/nvim/init.lua<cr>", options = { desc = "Edit neovim config" } },
		{ "k", "<cmd>tabnew<cr><cmd>e ~/.config/nvim/lua/config/keymaps.lua<cr>", options = { desc = "Edit keymaps" } },
	},

	--Location list
	{ "<C-l><C-l>", toggle_loclist},
	{ "<C-j>", "<cmd>lnext<CR>", options = { desc = "Next location list item", silent = true } },
	{ "<C-k>", "<cmd>lprev<CR>", options = { desc = "Previous location list item", silent = true } },

	-- Make
	{ "<leader>m", {
		{'m', "<cmd>w<cr><cmd>!make<cr>", options = { desc = "Run make", silent = true }},
		{'r', "<cmd>w<cr><cmd>!make run<cr>", options = { desc = "Run make run", silent = true }},
		{'c', "<cmd>w<cr><cmd>!make clean<cr>", options = { desc = "Run make clean", silent = true }},
	}},
	-- Buffers
	{'<leader>b', {
		{'n', "<cmd>bnext<cr>", options = { desc = "Next buffer", silent = true }},
		{'p', "<cmd>bprevious<cr>", options = { desc = "Previous buffer", silent = true }},
		{'d', "<cmd>bdelete<cr>", options = { desc = "Delete buffer", silent = true }},
	}},
	-- Oil
	{'-', "<cmd>Oil<cr>"},

	-- Vimwiki
	{'<C-Minus>', "<cmd>VimWikiDecrementListItem<cr>"}
}
