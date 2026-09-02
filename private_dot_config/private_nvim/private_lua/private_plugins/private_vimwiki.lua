return {
 {
    "vimwiki/vimwiki",
    branch = "dev",
	lazy = false,
    init = function()
        vim.g.vimwiki_list = {
            {
                syntax = "markdown",
                ext = ".md",
                path = "~/wiki",
            },
        }
        vim.g.vimwiki_global_ext = 1
		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = "*.md,*.wiki",
			command = "syntax sync fromstart"
		})

    end,
},
}
