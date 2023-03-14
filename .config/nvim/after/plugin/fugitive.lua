local last_tab = 0

local call_fugitive = function()
  if vim.bo.filetype == "fugitive" then
    vim.cmd([[tabn ]] .. last_tab)
  else
    last_tab = vim.fn.tabpagenr()

    local fugitive_opened = false
    local first_tab_buf = vim.fn.tabpagebuflist(1)
    for _, buf in ipairs(first_tab_buf) do
      if vim.fn.getbufvar(buf, "&filetype") == "fugitive" then
        fugitive_opened = true
        break
      end
    end
    if not fugitive_opened then
      last_tab = last_tab + 1
    end

    vim.cmd([[tab Git]])
    vim.cmd([[tabm 0]])
  end
end

vim.keymap.set("n", "<Leader>g", call_fugitive)
