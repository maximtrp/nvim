vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local directory = vim.fn.isdirectory(vim.fn.argv(0)) == 1
		if directory then
			vim.cmd("bd")
			require("telescope").extensions.file_browser.file_browser({ path = vim.fn.getcwd(), select_buffer = true })
		elseif vim.fn.argc() == 0 then
			vim.cmd("bd")
			require("telescope.builtin").find_files({ cwd = vim.fn.argv(0), hidden = true })
		end
	end,
})
