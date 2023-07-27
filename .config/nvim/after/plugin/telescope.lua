local builtin = require("telescope.builtin")
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<Leader>pf", builtin.git_files, opts)
vim.keymap.set("n", "<C-p>", builtin.find_files, opts)
-- vim.keymap.set("n", "<Leader>pg", builtin.live_grep, opts)
vim.keymap.set("n", "<Leader>pg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", opts)
vim.keymap.set("n", "<C-Space>", builtin.lsp_document_symbols, opts)

require("telescope").setup {
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        -- ["<C-h>"] = "which_key"
        ["<C-u>"] = false,
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
    find_files = {
      hidden = true,
      theme = "ivy",
      file_ignore_patterns = { ".git/", ".cache", "%.o", "%.a", "%.out", "%.class",
        "%.pdf", "%.mkv", "%.mp4", "%.zip" },
    },
    git_files = {
      theme = "ivy",
    },
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}
