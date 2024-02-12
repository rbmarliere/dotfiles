function TabMove(direction)
	local current_tab = vim.fn.tabpagenr()
	local total_tabs = vim.fn.tabpagenr("$")
	if current_tab == 1 and direction == -1 then
		vim.cmd.tabmove()
	elseif current_tab == total_tabs and direction == 1 then
		vim.cmd.tabmove("0")
	else
		if direction > 0 then
			vim.cmd.tabmove("+")
		else
			vim.cmd.tabmove("-")
		end
	end
end

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<S-C-PageDown>", function()
	TabMove(1)
end, opts)
vim.keymap.set("n", "<S-C-PageUp>", function()
	TabMove(-1)
end, opts)
