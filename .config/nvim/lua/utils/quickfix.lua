local toggle_qf = function()
	local opened_in_tab = false
	for _, win in pairs(vim.fn.getwininfo()) do
		if win["quickfix"] == 1 then
			vim.api.nvim_win_close(win["winid"], true)
			if win["tabnr"] == vim.fn.tabpagenr() then
				opened_in_tab = true
			end
		end
	end
	if opened_in_tab then
		vim.cmd("cclose")
	else
		vim.cmd("copen")
	end
end

local save_qf = function(opts)
	if vim.fn.isdirectory(vim.fn.stdpath("data") .. "/qf") == 0 then
		vim.fn.mkdir(vim.fn.stdpath("data") .. "/qf", "p")
	end
	local filename = vim.fn.expand(opts.args)
	local _qflist = vim.fn.getqflist()
	local _qfinfo = vim.fn.getqflist({ title = 1 })
	for _, entry in ipairs(_qflist) do
		vim.fn.setbufvar(entry.bufnr, "&buflisted", 1)
	end
	local _setqflist = string.format("call setqflist(%s)", vim.fn.string(_qflist))
	local _setqfinfo = string.format('call setqflist([], "a", %s)', vim.fn.string(_qfinfo))
	vim.fn.writefile({ _setqflist, _setqfinfo }, filename)
end

vim.api.nvim_create_user_command("ToggleQf", toggle_qf, { nargs = 0 })
vim.api.nvim_create_user_command("SaveQf", save_qf, { nargs = 1 })

local opts = { noremap = true }
vim.keymap.set("n", "<Leader>sq", ":SaveQf " .. vim.fn.stdpath("data") .. "/qf/", opts)
vim.keymap.set("n", "<Leader>rq", ":source " .. vim.fn.stdpath("data") .. "/qf/", opts)
vim.keymap.set("n", "<Leader>q", ":ToggleQf<CR>", opts)
