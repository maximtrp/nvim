vim.lsp.enable({
	"biome",
	"css",
	"dart",
	"eslint",
	"html",
	"json",
	"lua",
	"prisma",
	"pylsp",
	"ruff",
	"svelte",
	"tailwindcss",
	"ts",
	"volar",
})

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅙 ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰌵 ",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
})

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local directory = vim.fn.isdirectory(vim.fn.argv(0)) == 1
		if directory then
			vim.cmd("bd")
			vim.fn.chdir(vim.fn.argv(0))
			require("telescope").extensions.file_browser.file_browser({
				path = vim.fn.argv(0),
				select_buffer = true,
				no_ignore = true,
				grouped = true,
			})
		elseif vim.fn.argc() == 0 then
			vim.cmd("bd")
			require("telescope.builtin").find_files({ hidden = true, no_ignore = false })
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.opt_local.statusline = "  %f%=%l:%L "
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "lazygit",
	callback = function()
		vim.opt_local.statusline = "  "
	end,
})

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
-- 	if vim.api.nvim_get_mode().mode == "i" then
-- 		return
-- 	end
-- 	vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
-- end

-- local original_did_change = vim.lsp.handlers["textDocument/didChange"]
-- vim.lsp.handlers["textDocument/didChange"] = function(err, result, ctx, config)
-- 	print("I'm your change handler!!!")
-- 	local mode = vim.api.nvim_get_mode().mode
--
-- 	if mode ~= "i" then
-- 		vim.notify("I'm your change ihandler!!!")
-- 		original_did_change(err, result, ctx, config)
-- 	end
-- end
