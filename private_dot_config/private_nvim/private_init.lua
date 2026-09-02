require("modules.lazy")
require("modules.keymaps")
require("modules.filetype")
require("modules.lint")

vim.opt.number = true       -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.shiftwidth = 4      -- Shift 4 spaces when tab
vim.opt.tabstop = 4         -- 1 tab == 4 spaces
vim.opt.expandtab = false
vim.opt.ignorecase = true   -- Ignore case in search...
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.updatetime = 300
