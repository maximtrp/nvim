---@type vim.lsp.Config
return {
	cmd = { "biome", "lsp-proxy" },
	filetypes = {
		"astro",
		"css",
		"graphql",
		"javascript",
		"javascriptreact",
		"json",
		"jsonc",
		"svelte",
		"typescript",
		"typescript.tsx",
		"typescriptreact",
		"vue",
	},
	root_dir = function(bufnr, cb)
		local utils = require("config.utils")
		local fname = vim.api.nvim_buf_get_name(bufnr)
		local root_files = utils.insert_package_json({ "biome.json", "biome.jsonc" }, "biome", fname)
		local root_dir = vim.fs.dirname(vim.fs.find(root_files, { path = fname, upward = true })[1])
		if root_dir ~= nil then
			cb(root_dir)
		end
	end,
}
