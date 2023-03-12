vim.cmd([[wincmd L]])

vim.cmd.setlocal("spell")

require("cmp").setup.buffer {
  sources = require "cmp".config.sources(
    { { name = "conventionalcommits" } },
    { { name = "buffer" } }
  ),
}
