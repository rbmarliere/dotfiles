local M = {}

function M.get_qf()
	local _qflist = vim.fn.getqflist()
	if #_qflist == 0 then return nil end
	local _qfinfo = vim.fn.getqflist({ title = 1 })

	for _, entry in ipairs(_qflist) do
		-- the goal is to use SaveQf across nvim instances,
		-- so use filename instead of bufnr
		entry.filename = vim.api.nvim_buf_get_name(entry.bufnr)
		entry.bufnr = nil
	end

	local _setqflist = string.format('call setqflist(%s)', vim.fn.string(_qflist))
	local _setqfinfo = string.format('call setqflist([], "a", %s)', vim.fn.string(_qfinfo))
	return { _setqflist, _setqfinfo, 'copen' }
end

function M.toggle_qf()
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

M.save_qf = function(opts)
	if vim.fn.isdirectory(vim.fn.stdpath("data") .. "/qf") == 0 then
		vim.fn.mkdir(vim.fn.stdpath("data") .. "/qf", "p")
	end

	local filename = vim.fn.expand(opts.args)
	local qf = M.get_qf()
	if qf == nil then
		return
	end

	vim.fn.writefile(qf, filename)
end

return M
