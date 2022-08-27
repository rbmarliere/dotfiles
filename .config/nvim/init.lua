require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'morhetz/gruvbox'
    use 'jamessan/vim-gnupg'
    use 'nvim-lua/plenary.nvim'
    use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    use { 'nvim-treesitter/nvim-treesitter', run =  ':TSUpdate' }
    use { 'stsewd/isort.nvim', run = ':UpdateRemotePlugins' }
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
end)

require('nvim-cmp-config')
require('nvim-treesitter-config')

vim.cmd[[ source ~/.vim/vimrc ]]
vim.cmd[[ colorscheme gruvbox ]]
vim.o.background = 'dark'

vim.api.nvim_set_keymap('n', '<Leader>rs', ':source ~/.vim/sessions/', {})
vim.api.nvim_set_keymap('n', '<Leader>ss', ':mksession! ~/.vim/sessions/', {})
vim.api.nvim_set_keymap('n', '<C-p>', ':Telescope find_files<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fg', ':Telescope live_grep<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ff', ':lua vim.lsp.buf.format()<CR>:Isort<CR>', { silent = true })
vim.cmd[[iabbrev pubd __import__('pudb').set_trace()]]
vim.cmd[[iabbrev debug import pdb; import rlcompleter; pdb.Pdb.complete=rlcompleter.Completer(locals()).complete; pdb.set_trace()]]

