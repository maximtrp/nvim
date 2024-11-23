return {
	"rebelot/heirline.nvim",
	event = "UiEnter",
	dependencies = { "lewis6991/gitsigns.nvim" },
	config = function()
		local heirline = require("heirline")
		local conditions = require("heirline.conditions")
		local utils = require("heirline.utils")

		-- Define colors
		local colors = {
			black = utils.get_highlight("Normal").fg,
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
					return "[No Name]"
				end
				if not conditions.width_percent_below(#filename, 0.4) then
					filename = vim.fn.pathshorten(filename)
				end
				return filename
			end,
			hl = { fg = "black", bold = true },
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
					return { fg = "black", bold = true, italic = true, force = true }
				end
			end,
		}

		-- let's add the children to our FileNameBlock component
		file_name_block = utils.insert(
			file_name_block,
			file_icon,
			utils.insert(file_name_modifier, file_name), -- a new table where FileName is a child of FileNameModifier
			file_flags,
			{ provider = "%<" } -- this means that the statusline is cut here when there's not enough space
		)

		-- File type component
		local file_type = {
			provider = function()
				return vim.bo.filetype ~= "" and vim.bo.filetype or "Plain Text"
			end,
			hl = { fg = "black", bold = true },
			separator = " | ",
		}

		local file_format = {
			provider = function()
				local fmt = vim.bo.fileformat
				return fmt:upper()
			end,
			hl = { fg = "grey" },
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
					return self.hints > 0 and (self.hint_icon .. self.hints)
				end,
				hl = { fg = "diag_hint" },
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
			hl = { fg = "grey" },
			separator = " | ",
		}

		local lsp_active = {
			condition = conditions.lsp_attached,
			update = { "LspAttach", "LspDetach" },

			provider = function()
				local names = {}
				for i, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
					table.insert(names, server.name)
				end
				return " " .. table.concat(names, ", ")
			end,
			hl = { fg = "green", bold = true },
		}

		local space = { provider = "  " }

		-- Statusline
		local statusline = {
			mode,
			space,
			file_name_block,
			space,
			git_branch,
			space,
			{ provider = "%=", separator = " " },
			diagnostics,
			space,
			lsp_active,
			space,
			file_format,
			space,
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
