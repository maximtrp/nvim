return {
	"jackMort/ChatGPT.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("chatgpt").setup({
			api_key_cmd = "echo " .. os.getenv("OPENAPI"),
			openai_params = {
				max_tokens = 16000,
				model = "gpt-4o",
			},
			popup_window = {
				border = {
					highlight = "TelescopePreviewBorder",
				},
				win_options = {
					winhighlight = "Normal:TelescopePreviewNormal,FloatBorder:FloatBorder",
				},
			},
			system_window = {
				border = {
					highlight = "TelescopePromptBorder",
				},
				win_options = {
					winhighlight = "Normal:TelescopePromptNormal,FloatBorder:FloatBorder",
				},
			},
			popup_input = {
				border = {
					highlight = "TelescopePromptBorder",
				},
				win_options = {
					winhighlight = "Normal:TelescopePromptNormal,FloatBorder:FloatBorder",
				},
			},
			settings_window = {
				win_options = {
					winhighlight = "Normal:TelescopePromptNormal,FloatBorder:FloatBorder",
				},
			},
		})
	end,
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
}
