require"packer".startup(function(use)
  use "David-Kunz/markid"
  use "L3MON4D3/LuaSnip"
  use "folke/which-key.nvim"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/nvim-cmp"
  use "jamessan/vim-gnupg"
  use "m-demare/hlargs.nvim"
  use "mfussenegger/nvim-dap"
  use "mfussenegger/nvim-dap-python"
  -- use "morhetz/gruvbox"
  use "sainnhe/gruvbox-material"
  use "neovim/nvim-lspconfig"
  use "nvim-lua/plenary.nvim"
  use "nvim-telescope/telescope.nvim"
  use "nvim-treesitter/nvim-treesitter"
  use "nvim-treesitter/nvim-treesitter-context"
  use "p00f/nvim-ts-rainbow"
  use "rcarriga/nvim-dap-ui"
  use "saadparwaiz1/cmp_luasnip"
  use "theHamsta/nvim-dap-virtual-text"
  use "tpope/vim-commentary"
  use "tpope/vim-fugitive"
  use "wbthomason/packer.nvim"
  use "windwp/nvim-ts-autotag"
end)

require"which-key".setup()
require"snippets"
require"nvim-ts-rainbow-config"
require"nvim-cmp-config"
require"nvim-lsp-config"
require"nvim-treesitter-config"
require"tabmove"
require"config.dap".setup()

vim.o.grepformat="%f:%l:%c:%m"
vim.o.grepprg="rg --vimgrep --no-heading --smart-case"
vim.o.guicursor="n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

vim.cmd[[ source ~/.vim/vimrc ]]
-- vim.cmd[[ set termguicolors ]]
vim.cmd[[ let g:gruvbox_material_background = 'soft' ]]
vim.cmd[[ let g:gruvbox_material_transparent_background=1 ]]
vim.cmd[[ colorscheme gruvbox-material ]]

vim.cmd[[ autocmd FileType html setlocal tabstop=2 softtabstop=2 shiftwidth=2 ]]
vim.cmd[[ autocmd FileType typescript setlocal tabstop=2 softtabstop=2 shiftwidth=2 ]]
vim.cmd[[ autocmd FileType lua setlocal tabstop=2 softtabstop=2 shiftwidth=2 ]]

vim.api.nvim_set_keymap("n", "<C-p>", ":Telescope find_files<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>fg", ":Telescope live_grep<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<S-C-PageDown>", ":lua TabMove(1)<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<S-C-PageUp>", ":lua TabMove(-1)<CR>", { silent = true, noremap = true })
