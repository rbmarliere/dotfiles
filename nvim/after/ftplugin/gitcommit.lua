vim.api.nvim_create_autocmd(
  {
    "BufWinEnter"
  }, {
    buffer = 0,
    command = [[wincmd H]]
  }
)

vim.cmd.setlocal("spell")

require("cmp").setup.buffer {
  sources = require "cmp".config.sources(
    { { name = "conventionalcommits" } },
    { { name = "buffer" } }
  ),
}
