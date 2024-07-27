vim.g.editorconfig = false
vim.opt.exrc = true
vim.opt.guicursor="n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
vim.opt.backupdir = os.getenv("HOME") .. "/.cache/nvim/bkp/"
vim.opt.directory = os.getenv("HOME") .. "/.cache/nvim/swp/"
vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvim/und/"
vim.opt.undofile = true
