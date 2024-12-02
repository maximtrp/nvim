return {
	"rebelot/heirline.nvim",
	event = "UIEnter",
	dependencies = { "lewis6991/gitsigns.nvim" },
	config = function()
		local heirline = require("heirline")
		local conditions = require("heirline.conditions")
		local utils = require("heirline.utils")

		-- Define colors
		local colors = {
			none = utils.get_highlight("Normal").bg,
			red = utils.get_highlight("DiagnosticError").fg,
			green = utils.get_highlight("String").fg,
			blue = utils.get_highlight("Function").fg,
			gray = utils.get_highlight("NonText").fg,
			orange = utils.get_highlight("GitSignsChange").fg,
			purple = utils.get_highlight("Constant").fg,
			violet = utils.get_highlight("Member").fg,
			cyan = utils.get_highlight("Number").fg,
			diag_warn = utils.get_highlight("DiagnosticWarn").fg,
			diag_error = utils.get_highlight("DiagnosticError").fg,
			diag_hint = utils.get_highlight("DiagnosticHint").fg,
			diag_info = utils.get_highlight("DiagnosticInfo").fg,
			git_del = utils.get_highlight("GitSignsDelete").fg,
			git_add = utils.get_highlight("GitSignsAdd").fg,
			git_change = utils.get_highlight("GitSignsChange").fg,
		}

		local mode = {
			init = function(self)
				self.mode = vim.fn.mode(1)
			end,
			static = {
				mode_names = {
					["n"] = "NORMAL",
					["no"] = "O-PENDING",
					["nov"] = "O-PENDING",
					["noV"] = "O-PENDING",
					["no\22"] = "O-PENDING",
					["niI"] = "NORMAL",
					["niR"] = "NORMAL",
					["niV"] = "NORMAL",
					["nt"] = "NORMAL",
					["ntT"] = "NORMAL",
					["v"] = "VISUAL",
					["vs"] = "VISUAL",
					["V"] = "V-LINE",
					["Vs"] = "V-LINE",
					["\22"] = "V-BLOCK",
					["\22s"] = "V-BLOCK",
					["s"] = "SELECT",
					["S"] = "S-LINE",
					["\19"] = "S-BLOCK",
					["i"] = "INSERT",
					["ic"] = "INSERT",
					["ix"] = "INSERT",
					["R"] = "REPLACE",
					["Rc"] = "REPLACE",
					["Rx"] = "REPLACE",
					["Rv"] = "V-REPLACE",
					["Rvc"] = "V-REPLACE",
					["Rvx"] = "V-REPLACE",
					["c"] = "COMMAND",
					["cv"] = "EX",
					["ce"] = "EX",
					["r"] = "REPLACE",
					["rm"] = "MORE",
					["r?"] = "CONFIRM",
					["!"] = "SHELL",
					["t"] = "TERMINAL",
				},
				mode_colors = {
					n = "blue",
					i = "green",
					v = "cyan",
					V = "cyan",
					["\22"] = "cyan",
					c = "orange",
					s = "purple",
					S = "purple",
					["\19"] = "purple",
					R = "red",
					r = "red",
					["!"] = "red",
					t = "red",
				},
			},
			provider = function(self)
				return "   %2(" .. self.mode_names[self.mode] .. " %)"
			end,
			hl = function(self)
				local mode = self.mode:sub(1, 1)
				return { bg = self.mode_colors[mode], fg = "#ffffff", bold = true }
			end,
			update = { "ModeChanged" },
		}

		-- File name component
		local file_name_block = {
			init = function(self)
				self.filename = vim.api.nvim_buf_get_name(0)
			end,
		}

		local file_icon = {
			init = function(self)
				local filename = self.filename
				local extension = vim.fn.fnamemodify(filename, ":e")
				self.icon, self.icon_color =
					require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
			end,
			provider = function(self)
				return self.icon and (self.icon .. " ")
			end,
			hl = function(self)
				return { fg = self.icon_color }
			end,
		}

		local file_name = {
			provider = function(self)
				local filename = vim.fn.fnamemodify(self.filename, ":.")
				if filename == "" then
					return "void"
				end
				if not conditions.width_percent_below(#filename, 0.5) then
					filename = vim.fn.pathshorten(filename)
				end
				return filename
			end,
			hl = { bold = true },
		}

		local file_flags = {
			{
				condition = function()
					return vim.bo.modified
				end,
				provider = " 󱇧 ",
				hl = { fg = "orange" },
			},
			{
				condition = function()
					return not vim.bo.modifiable or vim.bo.readonly
				end,
				provider = " 󰈡 ",
				hl = { fg = "red" },
			},
		}

		local file_name_modifier = {
			hl = function()
				if vim.bo.modified then
					return { bold = true, italic = true, force = true }
				end
			end,
		}

		file_name_block = utils.insert(
			file_name_block,
			{ provider = "  " },
			file_icon,
			utils.insert(file_name_modifier, file_name),
			file_flags,
			{ provider = "  " },
			{ provider = "%<" }
		)

		-- File type component
		-- local file_type = {
		-- 	provider = function()
		-- 		return vim.bo.filetype ~= "" and vim.bo.filetype or "Plain Text"
		-- 	end,
		-- 	hl = { fg = "foreground", bold = true },
		-- }

		local macro_rec = {
			condition = function()
				return vim.fn.reg_recording() ~= "" and vim.o.cmdheight == 0
			end,
			provider = " ",
			hl = { fg = "orange", bold = true },
			utils.surround({ "@", "  " }, nil, {
				provider = function()
					return vim.fn.reg_recording()
				end,
			}),
			update = {
				"RecordingEnter",
				"RecordingLeave",
			},
		}

		local search_count = {
			condition = function()
				return vim.v.hlsearch ~= 0 and vim.o.cmdheight == 0
			end,
			init = function(self)
				local ok, search = pcall(vim.fn.searchcount)
				if ok and search.total then
					self.search = search
				end
			end,
			provider = function(self)
				local search = self.search
				return string.format("[%d/%d]  ", search.current, math.min(search.total, search.maxcount))
			end,
		}

		local file_format = {
			provider = function()
				local fmt = vim.bo.fileformat
				return fmt:upper() .. "  "
			end,
			hl = {},
		}

		-- Diagnostics component
		local diagnostics = {
			condition = conditions.has_diagnostics,

			static = {
				error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
				warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
				info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
				hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
			},

			init = function(self)
				self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
				self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
				self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
				self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
			end,

			update = { "DiagnosticChanged", "BufEnter" },

			{
				provider = function(self)
					-- 0 is just another output, we can decide to print it or not!
					return self.errors > 0 and (self.error_icon .. self.errors .. " ")
				end,
				hl = { fg = "diag_error" },
			},
			{
				provider = function(self)
					return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
				end,
				hl = { fg = "diag_warn" },
			},
			{
				provider = function(self)
					return self.info > 0 and (self.info_icon .. self.info .. " ")
				end,
				hl = { fg = "diag_info" },
			},
			{
				provider = function(self)
					return self.hints > 0 and (self.hint_icon .. self.hints .. " ")
				end,
				hl = { fg = "diag_hint" },
			},
			{
				provider = " ",
			},
		}

		local git_branch = {
			condition = conditions.is_git_repo,
			init = function(self)
				self.status_dict = vim.b.gitsigns_status_dict
				self.has_changes = self.status_dict.added ~= 0
					or self.status_dict.removed ~= 0
					or self.status_dict.changed ~= 0
			end,

			hl = { fg = "purple" },
			{
				provider = function(self)
					return " " .. self.status_dict.head .. " "
				end,
				hl = { bold = true },
			},

			{
				provider = function(self)
					local count = self.status_dict.added or 0
					return count > 0 and ("+" .. count)
				end,
				hl = { fg = "git_add" },
			},
			{
				provider = function(self)
					local count = self.status_dict.removed or 0
					return count > 0 and ("-" .. count)
				end,
				hl = { fg = "git_del" },
			},
			{
				provider = function(self)
					local count = self.status_dict.changed or 0
					return count > 0 and ("~" .. count)
				end,
				hl = { fg = "git_change" },
			},

			on_click = {
				callback = function()
					vim.defer_fn(function()
						vim.cmd("LazyGit")
					end, 100)
				end,
				name = "heirline_git",
			},
		}

		-- Ruler component
		local ruler = {
			provider = "%l:%c",
			hl = { fg = "grey", bg = "none" },
		}

		local lsp_active = {
			condition = conditions.lsp_attached,
			update = { "LspAttach", "LspDetach" },

			provider = function()
				local names = {}
				for i, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
					table.insert(names, server.name)
				end
				return " " .. table.concat(names, ", ") .. "  "
			end,
			hl = { fg = "green", bg = "none", bold = true },
			on_click = {
				callback = function()
					vim.defer_fn(function()
						vim.cmd("LspInfo")
					end, 100)
				end,
				name = "heirline_lsp",
			},
		}

		-- Statusline
		local statusline = {
			macro_rec,
			mode,
			file_name_block,
			git_branch,
			{ provider = "%=", separator = " " },
			search_count,
			diagnostics,
			lsp_active,
			file_format,
			ruler,
		}

		-- Setup Heirline
		heirline.setup({
			statusline = statusline,
			opts = {
				colors = colors,
			},
		})
	end,
}
