return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		toggler = {
			line = "gcc",
			block = "gbc",
		},
		opleader = {
			line = "cc",
			block = "cb",
		},
	},
}
