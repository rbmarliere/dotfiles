vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.tabstop = 2

local detect_gohtmltmpl = function()
		if vim.bo.filetype == "html" and vim.fn.search("{{", "nw") ~= 0 then
				vim.bo.filetype = "gohtmltmpl"
		end
end

detect_gohtmltmpl()
