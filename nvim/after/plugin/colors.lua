vim.g.gruvbox_material_background = 'soft'
vim.g.gruvbox_material_transparent_background = true

function setColors(color)
  color = color or 'gruvbox-material'
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
end

setColors()
