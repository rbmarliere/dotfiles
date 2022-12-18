function TabMove(direction)
    local current_tab = vim.fn.tabpagenr()
    local total_tabs = vim.fn.tabpagenr("$")

    if current_tab == 1 and direction == -1 then
        vim.cmd.tabmove()
    elseif current_tab == total_tabs and direction == 1 then
        vim.cmd.tabmove("0")
    else
        if direction > 0 then
            vim.cmd.tabmove("+")
        else
            vim.cmd.tabmove("-")
        end
    end
end

local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<S-C-PageDown>', ':lua TabMove(1)<CR>', opts)
vim.api.nvim_set_keymap('n', '<S-C-PageUp>', ':lua TabMove(-1)<CR>', opts)
