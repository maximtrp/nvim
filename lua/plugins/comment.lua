return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		toggler = {
			line = "gcc",
			block = "gcb",
		},
		opleader = {
			line = "cc",
			block = "cb",
		},
	},
}
