M = {}

local get_visual_selection = function()
	local mode = vim.api.nvim_get_mode()
	-- if not in visual mode, return
	if mode.mode ~= "V" then
		return {}
	end

	-- exit visual mode to update markers
	local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
	vim.api.nvim_feedkeys(esc, "x", false)

	local _, start_row, _, _ = unpack(vim.fn.getpos("'<"))
	local _, end_row, _, _ = unpack(vim.fn.getpos("'>"))

	return vim.fn.getline(start_row, end_row)
end

local get_cmd = function(ref)
	return "git --no-pager show " .. ref .. " | get_maintainer.pl --scm | tee >(wl-copy -p)"
end

M.get_from_cursor = function()
	local ref = vim.fn.expand("<cword>")
	vim.cmd.echo("system('" .. get_cmd(ref) .. "')")
end

M.get_from_range = function()
	local sel = get_visual_selection()
	local output = ""

	-- run get_maintainer.pl for each ref, append to output
	for _, commit in pairs(sel) do
		vim.cmd('echo "Processing: ' .. commit .. '"')
		local ref = string.match(commit, "^(%w+)")
		local cmd = get_cmd(ref)
		local partial = vim.fn.system(cmd)

		output = output .. commit .. partial .. commit .. "\n\n"
	end

	-- put into paste registers
	vim.fn.setreg("+", output)
	vim.fn.setreg("", output)

	return output
end

M.get_from_file = function()
	local file = vim.fn.expand("%")
	vim.cmd.echo("system('get_maintainer.pl --scm -f " .. file .. " | tee >(wl-copy -p)')")
end

return M
