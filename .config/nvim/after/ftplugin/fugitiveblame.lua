-- check if current tab only has one window
local function is_only_window()
	return vim.fn.tabpagewinnr(vim.fn.tabpagenr(), '$') == 1
end

if not is_only_window() then
	vim.cmd.wincmd("T")
end
