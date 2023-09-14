vim.cmd.setlocal("tabstop=8 softtabstop=8 shiftwidth=8 nosmarttab noexpandtab")
vim.cmd.iabbrev("shotgun", "trace_printk(\"%s: %d\\n\", __func__, __LINE__);")
