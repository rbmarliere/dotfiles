require('packer').startup(function(use)
    use 'L3MON4D3/LuaSnip'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/nvim-cmp'
    use 'jamessan/vim-gnupg'
    use 'morhetz/gruvbox'
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-treesitter/nvim-treesitter-context'
    use 'saadparwaiz1/cmp_luasnip'
    use 'tpope/vim-commentary'
    use 'wbthomason/packer.nvim'
end)

require'snippets'
require'nvim-cmp-config'
require'nvim-lsp-config'
require'nvim-treesitter-config'
require'tabmove'

vim.o.grepformat="%f:%l:%c:%m"
vim.o.grepprg="rg --vimgrep --no-heading --smart-case"
vim.o.guicursor="n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

vim.cmd[[ source ~/.vim/vimrc ]]
vim.cmd[[ colorscheme gruvbox ]]
vim.cmd[[ highlight Normal ctermbg=none ]]

vim.cmd[[ autocmd FileType html setlocal tabstop=2 softtabstop=2 shiftwidth=2 ]]
vim.cmd[[ autocmd FileType typescript setlocal tabstop=2 softtabstop=2 shiftwidth=2 ]]

vim.api.nvim_set_keymap('n', '<C-p>', ':Telescope find_files<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>fg', ':Telescope live_grep<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<S-C-PageDown>', ':lua TabMove(1)<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<S-C-PageUp>', ':lua TabMove(-1)<CR>', { silent = true, noremap = true })
