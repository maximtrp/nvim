return {
	"nvim-treesitter/nvim-treesitter",
	event = "UIEnter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"javascript",
				"html",
				"css",
				"typescript",
				"python",
				"go",
				"svelte",
				"vue",
				"dart",
				"json",
				"yaml",
				"markdown",
				"bash",
				"dockerfile",
				"prisma",
				"graphql",
				"scss",
				"tsx",
			},
			auto_install = true,
			sync_install = false,
			highlight = {
				enable = true,
				disable = function(lang, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
			},
			indent = { enable = true },
			textobjects = { enable = true },
		})
	end,
}
