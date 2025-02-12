local function get_current_branch()
	local handle = io.popen("git rev-parse --abbrev-ref HEAD")
	if handle == nil then
		return nil
	end
	local branch = handle:read("*a")
	handle:close()
	return string.gsub(branch, "^%s*(.-)%s*$", "%1") -- trim whitespace
end

local function read_branch_description(branch)
	local handle = io.popen(string.format("git config branch.%s.description", branch))
	if handle == nil then
		return nil
	end
	local description = handle:read("*a")
	handle:close()
	return description
end

local function write_branch_description(branch, content)
	local tmp_file = os.tmpname()
	local file = io.open(tmp_file, "w")
	if file == nil then
		return false
	end
	file:write(content)
	file:close()

	local command = string.format('git config branch.%s.description "$(cat %s)"', branch, tmp_file)
	local success = os.execute(command)
	os.remove(tmp_file)
	return success
end

local function edit_b4_cover()
	local branch = get_current_branch()
	if branch == nil then
		vim.api.nvim_err_writeln("Not in a git repository")
		return
	end

	local description = read_branch_description(branch)
	if description == nil then
		vim.api.nvim_err_writeln("Could not read branch description")
		return
	end

	vim.cmd("new")
	local buf = vim.api.nvim_get_current_buf()

	vim.bo[buf].buftype = "acwrite"
	vim.bo[buf].filetype = "gitcommit"
	vim.api.nvim_buf_set_name(buf, string.format("b4-cover-%s-%d", branch, buf))

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(description, "\n"))

	vim.api.nvim_create_autocmd("BufWriteCmd", {
		buffer = buf,
		callback = function()
			local content = table.concat(vim.api.nvim_buf_get_lines(buf, 0, -1, false), "\n")
			if write_branch_description(branch, content) then
				vim.api.nvim_set_option_value("modified", false, { buf = buf })
				vim.api.nvim_echo(
					{ { string.format("Saved b4 cover letter for branch %s", branch), "Normal" } },
					true,
					{}
				)
				return false
			else
				vim.api.nvim_err_writeln("Failed to save branch description")
				return true
			end
		end,
	})
end
vim.api.nvim_create_user_command("B4EditCover", edit_b4_cover, {})

local function send_b4(args)
	local cmd = "b4 send" .. (args and " " .. args or "")

	vim.cmd("tabnew")

	local buf = vim.api.nvim_get_current_buf()

	vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
	vim.api.nvim_set_option_value("swapfile", false, { buf = buf })

	local term_ok, term_id = pcall(vim.fn.termopen, cmd, {
		on_exit = function(job_id, exit_code, event_type)
			if exit_code == 0 then
				vim.api.nvim_echo({ { string.format("b4 send completed successfully"), "Normal" } }, true, {})
			else
				vim.api.nvim_err_writeln(string.format("b4 send failed with exit code: %d", exit_code))
			end
		end,
		stderr_buffered = true,
		stdout_buffered = true,
	})

	if not term_ok then
		vim.api.nvim_err_writeln("Failed to open terminal: " .. vim.inspect(term_id))
		return
	end

	vim.schedule(function()
		vim.cmd("startinsert")
	end)
end

vim.api.nvim_create_user_command("B4Send", function(opts)
	send_b4(opts.args)
end, { nargs = "*" })

-- https://b4.docs.kernel.org/en/latest/contributor/overview.html
local opts = { noremap = true }
vim.keymap.set("n", "<Leader>bn", ":!b4 prep --enroll", opts)
vim.keymap.set("n", "<Leader>be", edit_b4_cover, { noremap = true, silent = true, desc = "!b4 prep --edit-cover" })
vim.keymap.set("n", "<Leader>bc", ":!b4 prep --auto-to-cc<CR>:!b4 trailers --update<CR>:!b4 prep --check<CR>", opts)
vim.keymap.set("n", "<Leader>bs", ":B4Send --reflect", opts)
vim.keymap.set("n", "<Leader>ba", ":!b4 shazam ", opts)
