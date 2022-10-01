require('packer').startup(function(use)
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/vim-vsnip'
    use 'jamessan/vim-gnupg'
    use 'morhetz/gruvbox'
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-treesitter/nvim-treesitter-context'
    use 'wbthomason/packer.nvim'
end)

require('nvim-cmp-config')
require('nvim-treesitter-config')
require('tabmove')

vim.o.guicursor='n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175'

vim.cmd[[ source ~/.vim/vimrc ]]
vim.cmd[[ colorscheme gruvbox ]]
vim.cmd[[ highlight Normal ctermbg=none ]]

vim.cmd[[ iabbrev pudb __import__('pudb').set_trace() ]]
vim.cmd[[ iabbrev pdb import pdb; import rlcompleter; pdb.Pdb.complete=rlcompleter.Completer(locals()).complete; pdb.set_trace() ]]

vim.api.nvim_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<C-p>', ':Telescope find_files<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>ff', ':lua vim.lsp.buf.format()<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>fg', ':Telescope live_grep<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<S-C-PageDown>', ':lua TabMove(1)<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<S-C-PageUp>', ':lua TabMove(-1)<CR>', { silent = true, noremap = true })

