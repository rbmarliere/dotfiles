return {
	"lewis6991/gitsigns.nvim",
	lazy = false,
	config = function()
		require("gitsigns").setup({
			on_attach = function(buffer)
				local gs = package.loaded.gitsigns
				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
				end
				map("n", "]h", gs.next_hunk, "Next Hunk")
				map("n", "[h", gs.prev_hunk, "Prev Hunk")
				map({ "n", "v" }, "<Leader>gs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
				map({ "n", "v" }, "<Leader>gr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
				map("n", "<Leader>gS", gs.stage_buffer, "Stage Buffer")
				map("n", "<Leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
				map("n", "<Leader>gR", gs.reset_buffer, "Reset Buffer")
				map("n", "<Leader>gp", gs.preview_hunk, "Preview Hunk")
				-- map("n", "<Leader>gb", function()
				-- 	gs.blame_line({ full = true })
				-- end, "Blame Line")
				map("n", "<Leader>gd", gs.diffthis, "Diff This")
				-- map("n", "<Leader>gD", function()
				-- 	gs.diffthis("~")
				-- end, "Diff This ~")
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
			end,
		})
	end,
}
