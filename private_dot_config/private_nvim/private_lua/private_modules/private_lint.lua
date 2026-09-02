local ns = vim.api.nvim_create_namespace("prism_cli_linter")

-- Separate function to populate and open the location list
local function open_prism_loclist()
  vim.diagnostic.setloclist({
    namespace = ns,
    open = true,
  })
  vim.cmd.lopen()
end

-- Keybind to trigger the function
vim.keymap.set("n", "<leader>dd", open_prism_loclist, { desc = "Populate location list with prism" })

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
  pattern = "*.c",
  callback = function(args)
    local bufnr = args.buf
    local file = vim.api.nvim_buf_get_name(bufnr)
    if file == "" then return end

    vim.system({ "prism", "-o", "-", "-c", file }, { text = true }, function(obj)
      local output = (obj.stdout or "") .. (obj.stderr or "")
      local diagnostics = {}

      for line in output:gmatch("[^\r\n]+") do
        local fname, lnum, col, message
        
        fname, lnum, col, message = line:match("^(.-):(%d+):(%d+):%s*(.*)$")
        
        if lnum then
          col = tonumber(col) - 1
        else
          fname, lnum, message = line:match("^(.-):(%d+):%s*(.*)$")
          col = 0
        end

        if lnum then
          table.insert(diagnostics, {
            lnum = tonumber(lnum) - 1,
            col = col,
            severity = vim.diagnostic.severity.ERROR,
            message = message,
            source = "prism",
          })
        end
      end

      vim.schedule(function()
        vim.diagnostic.set(ns, bufnr, diagnostics)
      end)
    end)
  end,
})

-- Automatically open diagnostic float on cursor hold
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = "rounded",
      source = "always",
      prefix = " ",
      scope = "cursor",
    })
  end,
})
