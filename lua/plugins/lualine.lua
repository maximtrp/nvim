return {
	"nvim-lualine/lualine.nvim",
	event = { "VeryLazy" },
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local ltheme = vim.o.background == "dark" and "onedark" or "onelight"
		local config = {
			options = {
				theme = ltheme,
				component_separators = { left = " ", right = " " },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { { "filename", color = { fg = "Normal", gui = "bold" } } },
				lualine_c = { { "branch", "diff" } },
				lualine_x = {
					"diagnostics",
					"filetype",
					"encoding",
					"fileformat",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = { "mode" },
				lualine_b = { { "filename", color = { fg = "Normal", gui = "bold" } } },
				lualine_c = { "branch", "diff" },
				lualine_x = { "filetype", "encoding", "fileformat" },
				lualine_y = {},
				lualine_z = {},
			},
		}
		require("lualine").setup(config)
	end,
}
