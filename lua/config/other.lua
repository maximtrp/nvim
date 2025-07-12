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

vim.lsp.config("vtsls", {
	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = {
					{
						name = "@vue/typescript-plugin",
						location = "/opt/homebrew/lib/node_modules/@vue/typescript-plugin",
						languages = { "vue" },
						configNamespace = "typescript",
					},
				},
			},
		},
	},
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
})

vim.lsp.config("vue_ls", {
	--[[ init_options = {
		typescript = {
			tsdk = "/opt/homebrew/lib/node_modules/typescript/lib",
		},
	}, ]]
	on_init = function(client)
		client.handlers["tsserver/request"] = function(_, result, context)
			local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
			if #clients == 0 then
				vim.notify(
					"Could not found `vtsls` lsp client, vue_lsp would not work without it.",
					vim.log.levels.ERROR
				)
				return
			end
			local ts_client = clients[1]

			local param = unpack(result)
			local id, command, payload = unpack(param)
			ts_client:exec_cmd({
				title = "vue_request_forward", -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
				command = "typescript.tsserverRequest",
				arguments = {
					command,
					payload,
				},
			}, { bufnr = context.bufnr }, function(_, r)
				local response_data = { { id, r.body } }
				---@diagnostic disable-next-line: param-type-mismatch
				client:notify("tsserver/response", response_data)
			end)
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
	"vtsls",
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
