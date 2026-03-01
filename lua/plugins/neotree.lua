return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	lazy = true,
	cmd = "Neotree",
	config = function()
		require("neo-tree").setup({
			event_handlers = {
				{
					event = "neo_tree_buffer_enter",
					handler = function()
						vim.opt_local.signcolumn = "no"
						vim.opt_local.foldcolumn = "0"
						vim.opt_local.statuscolumn = ""
					end,
				},
			},
			close_if_last_window = true,
			popup_border_style = "rounded",
			enable_git_status = true,
			enable_diagnostics = true,
			git_status_async = false,
			window = {
				position = "left",
				width = 30,
				mappings = {
					["<space>"] = "none",
					["l"] = "open",
					["h"] = "close_node",
				},
			},
			filesystem = {
				filtered_items = {
					visible = false,
					hide_dotfiles = false,
					hide_gitignored = true,
					hide_ignored = true,
					hide_by_name = { "node_modules", ".git" },
				},
				follow_current_file = {
					enabled = true,
				},
				use_libuv_file_watcher = true,
			},
			buffers = {
				follow_current_file = {
					enabled = true,
				},
			},
			default_component_configs = {
				indent = {
					with_expanders = true,
					expander_collapsed = "",
					expander_expanded = "",
				},
				git_status = {
					symbols = {
						added = "",
						modified = "",
						deleted = "✖",
						renamed = "󰁕",
						untracked = "",
						ignored = "",
						unstaged = "󰄱",
						staged = "",
						conflict = "",
					},
				},
			},
		})
	end,
}
