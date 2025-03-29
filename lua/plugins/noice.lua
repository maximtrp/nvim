return {
	"folke/noice.nvim",
	opts = {
		timeout = 5000,
		notify = {
			enabled = true,
			view = "notify",
		},
		views = {
			notify = {
				max_width = 40,
			},
			cmdline_popup = {
				border = {
					style = "rounded",
					padding = { 0, 1 },
				},
				filter_options = {},
			},
			hover = {
				relative = "cursor",
				position = {
					row = 2,
					col = 2,
				},
				size = {
					max_width = 60,
				},
				border = {
					style = "rounded",
					padding = { 0, 1 },
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
				size = {
					max_width = 60,
				},
				border = {
					--style = "rounded",
					padding = { 0, 1 },
				},
			},
			popup = {
				size = {
					max_width = 40,
					max_height = 10,
				},
			},
			popupmenu = {
				size = {
					max_width = 60,
					max_height = 10,
				},
			},
		},
		lsp = {
			progress = {
				enabled = true,
			},
			hover = {
				silent = true,
			},
		},
		routes = {
			{
				filter = {
					event = "lsp",
					kind = "progress",
					cond = function(message)
						local client = vim.tbl_get(message.opts, "progress", "client")
						return client == "dart"
					end,
				},
				opts = { skip = true },
			},
		},
	},
}
