local last_tab = 0

local call_fugitive = function()
  if vim.bo.filetype == "fugitive" then
    vim.cmd([[tabn ]] .. last_tab)
  else
    last_tab = vim.fn.tabpagenr()

    local first_tab_buf = vim.fn.tabpagebuflist(1)[1]
    if vim.fn.getbufvar(first_tab_buf, "&filetype") ~= "fugitive" then
      last_tab = last_tab + 1
    end

    vim.cmd([[tab Git]])
    vim.cmd([[tabm 0]])
  end
end

vim.keymap.set("n", "<Leader>g", call_fugitive)
