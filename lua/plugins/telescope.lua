return {
	"nvim-telescope/telescope.nvim",
	lazy = false,
	dependencies = {
    "nvim-lua/popup.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-media-files.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
	},
	config = function()
		local actions = require("telescope.actions")

		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
						["<ESC>"] = actions.close,
					},
					n = {
						["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
						["<ESC>"] = actions.close,
					},
				},
				sorting_strategy = "ascending",
				layout_strategy = "vertical",
				layout_config = {
					horizontal = {
						size = {
							width = "90%",
							height = "80%",
						},
					},
					vertical = {
						prompt_position = "top",
						size = {
							width = "90%",
							height = "90%",
						},
					},
				},
				path_display = { "truncate" },
			},
      media_files = {
      filetypes = {"png", "webp", "jpg", "jpeg"},
      find_cmd = "rg"
    },
			pickers = {
				find_files = {
					find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
				},
			},
		})

		require("telescope").load_extension("media_files")
		require("telescope").load_extension("file_browser")
		require("telescope").load_extension("ui-select")
		require("telescope").load_extension("fzf")
	end,
}
