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
	workspace_required = true,
	root_dir = function(bufnr, on_dir)
		local utils = require("config.utils")
		local fname = vim.api.nvim_buf_get_name(bufnr)
		local root_files = utils.insert_package_json({ "biome.json", "biome.jsonc" }, "biome", fname)
		local root_directory = vim.fs.dirname(vim.fs.find(root_files, { path = fname, upward = true })[1])
		if root_directory ~= nil then
			on_dir(root_directory)
		end
	end,
}
