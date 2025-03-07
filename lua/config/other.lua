local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "", linehl = "" })
end

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf,trouble",
	callback = function()
		vim.opt_local.statusline = " %f%=%l:%L "
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
