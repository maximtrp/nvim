vim.lsp.config("dartls", {
	settings = { dart = { completeFunctionCalls = true, lineLength = 120, showTodos = false } },
})

vim.lsp.config("lua_ls", {
	settings = { Lua = { runtime = { version = "LuaJIT" }, signatureHelp = { enabled = true } } },
})

vim.lsp.config("ts_ls", {
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = "/opt/homebrew/lib/node_modules/@vue/typescript-plugin",
				languages = { "javascript", "typescript", "vue" },
			},
		},
	},
	filetypes = {
		"javascript",
		"typescript",
		"vue",
	},
})

vim.lsp.config("vue_ls", {
	init_options = {
		typescript = {
			tsdk = "/opt/homebrew/lib/node_modules/typescript/lib",
		},
	},
	before_init = function(_, config)
		local lib_path = vim.fs.find("node_modules/typescript/lib", { path = config.root_dir, upward = true })[1]
		if lib_path then
			config.init_options.typescript.tsdk = lib_path
		end
	end,
})

vim.lsp.config("pylsp", {
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
})

vim.lsp.enable({
	"biome",
	"cssls",
	"dartls",
	"dockerls",
	"eslint",
	"html",
	"jsonls",
	"lua_ls",
	"oxlint",
	"prismals",
	"pylsp",
	"ruff",
	"svelte",
	"tailwindcss",
	"ts_ls",
	"vue_ls",
})

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰌵 ",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
})

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local directory = vim.fn.isdirectory(vim.fn.argv(0)) == 1
		if directory then
			vim.cmd("bd")
			vim.fn.chdir(vim.fn.argv(0))
			require("telescope").extensions.file_browser.file_browser({
				path = vim.fn.argv(0),
				select_buffer = true,
				no_ignore = true,
				grouped = true,
			})
		elseif vim.fn.argc() == 0 then
			vim.cmd("bd")
			require("telescope.builtin").find_files({ hidden = true, no_ignore = false })
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.opt_local.statusline = "  %f%=%l:%L "
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "lazygit",
	callback = function()
		vim.opt_local.statusline = "  "
	end,
})

vim.api.nvim_create_user_command("LspReload", function()
	vim.lsp.stop_client(vim.lsp.get_clients())
	-- vim.defer_fn(function()
	vim.cmd("edit")
	-- end, 1000)
end, { desc = "Reload all LSP attached", nargs = "*" })

vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
-- 	if vim.api.nvim_get_mode().mode == "i" then
-- 		return
-- 	end
-- 	vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
-- end

-- local original_did_change = vim.lsp.handlers["textDocument/didChange"]
-- vim.lsp.handlers["textDocument/didChange"] = function(err, result, ctx, config)
-- 	print("I'm your change handler!!!")
-- 	local mode = vim.api.nvim_get_mode().mode
--
-- 	if mode ~= "i" then
-- 		vim.notify("I'm your change ihandler!!!")
-- 		original_did_change(err, result, ctx, config)
-- 	end
-- end
