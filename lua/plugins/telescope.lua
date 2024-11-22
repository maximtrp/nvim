return {
	"nvim-telescope/telescope.nvim",
	lazy = false,
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("telescope").setup({
			defaults = {
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
			},
		})

		require("telescope").load_extension("file_browser")
	end,
}
