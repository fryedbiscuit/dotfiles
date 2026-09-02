return {
	{
		"neovim/nvim-lspconfig",
		dependencies = { "hrsh7th/cmp-nvim-lsp" },
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

		vim.lsp.config("clangd", {
		capabilities = capabilities,

		-- Disable semantic tokens globally for all LSP servers
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if client then
					client.server_capabilities.semanticTokensProvider = nil
				end
			end,
		}),

		handlers = {
		-- Suppress LSP-based diagnostics entirely
		["textDocument/publishDiagnostics"] = function() end,
		},
	})
	vim.lsp.enable("clangd")

			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true })
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { silent = true })
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = { "hrsh7th/cmp-nvim-lsp" },
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
				}),
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
				}),
				performance = {
					debounce = 150,
					throttle = 60,
				},
			})
		end,
	},
}
