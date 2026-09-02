local function set_clipboard_provider()
    -- Priority 1: Tmux
    if os.getenv('TMUX') then
        return {
            name = 'tmux',
            copy = {
                ['*'] = {'tmux', 'load-buffer', '-'},
            },
            paste = {
                ['*'] = {'tmux', 'save-buffer', '-'},
            },
            cache_enabled = 1,
        }
    -- Priority 2: Termux (Standalone)
    elseif vim.fn.executable('termux-clipboard-set') == 1 then
        return {
            name = 'termux',
            copy = {
                ['*'] = {'termux-clipboard-set'},
            },
            paste = {
                ['*'] = {'termux-clipboard-get'},
            },
            cache_enabled = 1,
        }
    end
    -- Fallback: Default Neovim behavior
    return nil
end

local provider = set_clipboard_provider()

if provider then
    vim.g.clipboard = provider
end

vim.opt.clipboard = "unnamed"
