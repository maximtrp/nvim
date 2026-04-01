local builtin = require("statuscol.builtin")
require("statuscol").setup({
	setopt = true,
	ft_ignore = { "neo-tree" },
	relculright = true,
	segments = {
		{ text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
		{ text = { "%s" }, click = "v:lua.ScSa" },
		{
			text = { builtin.lnumfunc, " " },
			condition = { true, builtin.not_empty },
			click = "v:lua.ScLa",
		},
	},
})
