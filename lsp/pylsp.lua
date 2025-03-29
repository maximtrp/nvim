---@type vim.lsp.Config
return {
	cmd = { "pylsp" },
	filetypes = { "python" },
	root_markers = {
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
	},
	settings = {
		pylsp = {
			plugins = {
				mypy = { enabled = true },
				mccabe = { enabled = false },
				pycodestyle = { enabled = false },
				pydocstyle = { enabled = false },
				pyflakes = { enabled = false },
				flake8 = { enabled = false },
				pylint = { enabled = false },
			},
		},
	},
	single_file_support = true,
}
