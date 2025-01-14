vim.cmd.source("$HOME/.vim/vimrc")

require("config.ft");
require("config.options")
require("config.priv")
require("config.keymaps")
require("config.lazy")

require("utils.b4")
require("utils.tabmove")
