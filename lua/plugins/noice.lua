return {
	"folke/noice.nvim",
	opts = {
		timeout = 5000,
		views = {
			cmdline_popup = {
				border = {
					style = "rounded",
					padding = { 1, 2 },
				},
				filter_options = {},
			},
			hover = {
				border = {
					style = "rounded",
					padding = { 1, 2 },
				},
			},
			cmdline = {
				border = {
					style = "rounded",
					padding = { 1, 2 },
				},
			},
			cmdline_output = {
				border = {
					style = "rounded",
					padding = { 1, 2 },
				},
			},
			mini = {
				timeout = 4000,
				border = {
					--style = "rounded",
					padding = { 1, 1 },
				},
			},
			-- popup = {
			-- 	border = {
			-- 		style = "rounded",
			-- 		padding = { 1, 2 },
			-- 	},
			-- },
			-- popupmenu = {
			-- 	border border= {
			-- 		style = "rounded",
			-- 		padding = { 1, 2 },
			-- 	},
			-- },
		},
		lsp = {
			hover = {
				silent = true,
			},
		},
	},
}
