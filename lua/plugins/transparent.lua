return {
	"xiyaowong/transparent.nvim",
	config = function()
		local transparent = require("transparent")
		transparent.setup({})
		transparent.clear_prefix("BufferLine")
	end,
}
