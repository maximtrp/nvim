local M = {}

-- Light mode palette
M.light = {
	foreground = "#3f3f3f",
	background = "#f0f0f0",
	red = "#b51c42",
	light_red = "#f43f5e",
	blue = "#2656d9",
	green = "#4d8019",
	purple = "#ba52e0",
	yellow = "#cfcf32",
	violet = "#774bc3",
	amber = "#b45309",
	cyan = "#0891b2",
	teal = "#0d9488",
	orange = "#c9793c",
	brown = "#b06933",
	grey = "#737373",
	bright_grey = "#dadada",
	selection = "#f59e0b",
	black = "#3f3f3f",
}

-- Dark mode palette
M.dark = {
	foreground = "#d4d4d4",
	background = "#3F3F3F",
	red = "#da5858",
	light_red = "#fb7185",
	blue = "#5288e0",
	green = "#339958",
	purple = "#b259c0",
	violet = "#9987c5",
	yellow = "#d9ac26",
	amber = "#fbbf24",
	cyan = "#48bfe3",
	teal = "#22c3b0",
	orange = "#d5986d",
	brown = "#b6897c",
	grey = "#888888",
	bright_grey = "#333333",
	selection = "#f59e0b",
	black = "#3f3f3f",
}

-- Apply the colors
local function set_highlight(group, opts)
	-- Make sure that `cterm` attribute is not populated from `gui`
	opts.cterm = opts.cterm or {}

	-- Define global highlight
	vim.api.nvim_set_hl(0, group, opts)
end

function M.setup()
	local bg = vim.o.background
	local colors = (bg == "light") and M.light or M.dark

	set_highlight("StatusLine", { link = "Normal" })
	set_highlight("StatusLineNC", { link = "NormalNC" })
	set_highlight("Conditional", { link = "Conditional" })
	set_highlight("Repeat", { link = "Conditional" })
	set_highlight("Label", { link = "Statement" })
	set_highlight("Keyword", { link = "Statement" })
	set_highlight("Exception", { link = "Statement" })
	set_highlight("Include", { link = "PreProc" })
	set_highlight("Define", { link = "PreProc" })
	set_highlight("Macro", { link = "PreProc" })
	set_highlight("PreCondit", { link = "PreProc" })
	set_highlight("StorageClass", { link = "Type" })
	set_highlight("Structure", { link = "Type" })
	set_highlight("Typedef", { link = "Type" })
	set_highlight("SpecialChar", { link = "Special" })
	set_highlight("Delimiter", { link = "Special" })
	set_highlight("SpecialComment", { link = "Special" })
	set_highlight("Debug", { link = "Special" })

	set_highlight("DiagnosticVirtualTextError", { link = "DiagnosticError" })
	set_highlight("DiagnosticVirtualTextWarn", { link = "DiagnosticWarn" })
	set_highlight("DiagnosticVirtualTextInfo", { link = "DiagnosticInfo" })
	set_highlight("DiagnosticVirtualTextHint", { link = "DiagnosticHint" })
	set_highlight("DiagnosticVirtualTextOk", { link = "DiagnosticOk" })
	set_highlight("DiagnosticFloatingError", { link = "DiagnosticError" })
	set_highlight("DiagnosticFloatingWarn", { link = "DiagnosticWarn" })
	set_highlight("DiagnosticFloatingInfo", { link = "DiagnosticInfo" })
	set_highlight("DiagnosticFloatingHint", { link = "DiagnosticHint" })
	set_highlight("DiagnosticFloatingOk", { link = "DiagnosticOk" })
	set_highlight("DiagnosticSignError", { link = "DiagnosticError" })
	set_highlight("DiagnosticSignWarn", { link = "DiagnosticWarn" })
	set_highlight("DiagnosticSignInfo", { link = "DiagnosticInfo" })
	set_highlight("DiagnosticSignHint", { link = "DiagnosticHint" })
	set_highlight("DiagnosticSignOk", { link = "DiagnosticOk" })
	set_highlight("DiagnosticDeprecated", { sp = "Red", strikethrough = true })
	set_highlight("DiagnosticUnnecessary", { link = "Comment" })
	set_highlight("LspInlayHint", { link = "NonText" })
	set_highlight("SnippetTabstop", { link = "Visual" })

	-- Text
	set_highlight("@markup.raw", { link = "Comment" })
	set_highlight("@markup.link", { link = "Identifier" })
	set_highlight("@markup.heading", { link = "Title" })
	set_highlight("@markup.link.url", { link = "Underlined" })
	set_highlight("@markup.underline", { link = "Underlined" })
	set_highlight("@comment.todo", { link = "Todo" })

	-- Miscs
	set_highlight("@comment", { link = "Comment" })
	set_highlight("@punctuation", { link = "Delimiter" })

	-- Constants
	set_highlight("@constant", { link = "Constant" })
	set_highlight("@constant.builtin", { link = "Builtin" })
	set_highlight("@constant.regex", { link = "Constant" })
	set_highlight("@constant.macro", { link = "Define" })
	set_highlight("@keyword.directive", { link = "Define" })
	set_highlight("@string", { link = "String" })
	set_highlight("@string.escape", { link = "SpecialChar" })
	set_highlight("@string.special", { link = "SpecialChar" })
	set_highlight("@string.regexp", { link = "Constant" })
	set_highlight("@character", { link = "Character" })
	set_highlight("@character.special", { link = "SpecialChar" })
	set_highlight("@number", { link = "Number" })
	set_highlight("@boolean", { link = "Boolean" })
	set_highlight("@number.float", { link = "Float" })

	-- Functions
	set_highlight("@function", { link = "Function" })
	set_highlight("@function.builtin", { link = "Special" })
	set_highlight("@function.macro", { link = "Macro" })
	set_highlight("@function.method", { link = "Function" })
	set_highlight("@variable.parameter", { link = "Identifier" })
	set_highlight("@variable.parameter.builtin", { link = "Special" })
	set_highlight("@variable.member", { link = "Member" })
	set_highlight("@property", { link = "Identifier" })
	set_highlight("@attribute", { link = "Macro" })
	set_highlight("@attribute.builtin", { link = "Special" })
	set_highlight("@constructor", { link = "Special" })

	-- Keywords
	set_highlight("@keyword.conditional", { link = "Conditional" })
	set_highlight("@keyword.repeat", { link = "Repeat" })
	set_highlight("@keyword.type", { link = "Structure" })
	set_highlight("@label", { link = "Label" })
	set_highlight("@operator", { link = "Operator" })
	set_highlight("@keyword", { link = "Keyword" })
	set_highlight("@keyword.exception", { link = "Exception" })

	set_highlight("@variable", { link = "Identifier" })
	set_highlight("@type", { link = "Type" })
	set_highlight("@type.definition", { link = "Typedef" })
	set_highlight("@module", { link = "Identifier" })
	set_highlight("@keyword.import", { link = "Include" })
	set_highlight("@keyword.directive", { link = "PreProc" })
	set_highlight("@keyword.debug", { link = "Debug" })
	set_highlight("@tag", { link = "Tag" })
	set_highlight("@tag.attribute", { link = "TagAttribute" })
	set_highlight("@tag.delimiter", { link = "TagDelimiter" })
	set_highlight("@tag.builtin", { link = "Special" })
	set_highlight("@property.css", { link = "CSSprop" })

	-- LSP semantic tokens
	set_highlight("@lsp.type.class", { link = "Structure" })
	set_highlight("@lsp.type.comment", { link = "Comment" })
	set_highlight("@lsp.type.decorator", { link = "Function" })
	set_highlight("@lsp.type.enum", { link = "Structure" })
	set_highlight("@lsp.type.enumMember", { link = "Constant" })
	set_highlight("@lsp.type.function", { link = "Function" })
	set_highlight("@lsp.type.interface", { link = "Structure" })
	set_highlight("@lsp.type.macro", { link = "Macro" })
	set_highlight("@lsp.type.method", { link = "Function" })
	set_highlight("@lsp.type.namespace", { link = "Structure" })
	set_highlight("@lsp.type.parameter", { link = "Identifier" })
	set_highlight("@lsp.type.property", { link = "" })
	set_highlight("@lsp.type.struct", { link = "Structure" })
	set_highlight("@lsp.type.type", { link = "Type" })
	set_highlight("@lsp.type.typeParameter", { link = "TypeDef" })
	set_highlight("@lsp.type.variable", { link = "Identifier" })
	set_highlight("@lsp.typemod.property.annotation", { link = "PreProc" })
	set_highlight("@lsp.typemod.parameter.label", { link = "Parameter" })

	set_highlight("GitSignsChange", { fg = colors.orange })
	set_highlight("GitSignsAdd", { fg = colors.green })
	set_highlight("GitSignsDelete", { fg = colors.red })

	set_highlight("DiagnosticError", { fg = colors.red })
	set_highlight("DiagnosticWarn", { fg = colors.orange })
	set_highlight("DiagnosticInfo", { fg = colors.green })
	set_highlight("DiagnosticHint", { fg = colors.blue })
	set_highlight("DiagnosticOk", { fg = colors.green })
	set_highlight("DiagnosticUnderlineError", { sp = colors.red, underline = true })
	set_highlight("DiagnosticUnderlineWarn", { sp = colors.orange, underline = true })
	set_highlight("DiagnosticUnderlineInfo", { sp = colors.green, underline = true })
	set_highlight("DiagnosticUnderlineHint", { sp = colors.grey, underline = true })
	set_highlight("DiagnosticUnderlineOk", { sp = colors.green, underline = true })

	set_highlight("Normal", { fg = colors.foreground, bg = "none" })
	set_highlight("NormalNC", { fg = colors.grey, bg = "none" })
	set_highlight("NormalFloat", { bg = colors.bright_grey, fg = colors.foreground })
	set_highlight("Title", { fg = colors.foreground, bold = true })
	set_highlight("LazyGitFloat", { bg = colors.background, fg = colors.foreground })
	set_highlight("LazyGitBorder", { bg = colors.background, fg = colors.foreground })
	set_highlight("BufferLineBuffer", { fg = colors.grey, bold = true })
	set_highlight("BufferLineBufferSelected", { fg = colors.foreground, bold = true })
	set_highlight("BufferLineCloseButtonSelected", { fg = colors.red })
	set_highlight("IblIndent", { fg = colors.bright_grey })
	set_highlight("IblScope", { fg = colors.grey })

	set_highlight("Directory", { fg = colors.foreground, bold = true })
	set_highlight("MsgArea", { bg = colors.bright_grey, fg = colors.foreground })
	set_highlight("Visual", { bg = colors.bright_grey, fg = colors.foreground })
	set_highlight("LazyButtonActive", { bg = colors.yellow, fg = colors.black })
	set_highlight("YankHighlight", { bg = colors.yellow, fg = colors.black })
	set_highlight("Search", { bg = colors.selection, fg = colors.black })
	set_highlight("Pmenu", { bg = colors.bright_grey, fg = colors.foreground })
	set_highlight("PmenuSel", { bg = colors.selection, fg = colors.black })
	set_highlight("WarningMsg", { fg = colors.orange })
	set_highlight("ErrorMsg", { fg = colors.red })
	set_highlight("Special", { fg = colors.grey })
	set_highlight("CmpItemMenu", { fg = colors.foreground })
	set_highlight("CmpItemAbbr", { fg = colors.foreground })
	set_highlight("CmpItemAbbrMatch", { fg = colors.red })
	set_highlight("CmpItemAbbrMatchFuzzy", { link = "CmpItemAbbrMatch" })
	set_highlight("CmpItemKind", { fg = colors.orange })
	set_highlight("MatchParen", { fg = colors.orange })
	set_highlight("Conceal", { fg = colors.grey })
	set_highlight("NonText", { fg = colors.grey })

	set_highlight("Comment", { fg = colors.grey })
	set_highlight("Constant", { fg = colors.purple })
	set_highlight("Character", { fg = colors.green })
	set_highlight("Boolean", { fg = colors.purple })
	set_highlight("Member", { fg = colors.violet })
	set_highlight("Parameter", { fg = colors.brown })
	set_highlight("Number", { fg = colors.cyan })
	set_highlight("Builtin", { fg = colors.teal })
	set_highlight("CSStype", { fg = colors.red })
	set_highlight("CSSprop", { fg = colors.teal })
	set_highlight("Function", { fg = colors.blue })
	set_highlight("String", { fg = colors.green })
	set_highlight("Tag", { fg = colors.red })
	set_highlight("TagDelimiter", { fg = colors.grey })
	set_highlight("TagAttribute", { fg = colors.orange })
	set_highlight("Identifier", { fg = colors.foreground })
	set_highlight("Statement", { fg = colors.red })
	set_highlight("Operator", { fg = colors.orange })
	set_highlight("Conditional", { fg = colors.red, bold = true })
	set_highlight("PreProc", { fg = colors.red })
	set_highlight("Type", { fg = colors.teal })
	set_highlight("Underlined", { underline = true })
	set_highlight("Ignore", {})
end

-- Auto-reload colorscheme when background changes
vim.api.nvim_create_autocmd("OptionSet", {
	pattern = "background",
	callback = function()
		M.setup()
	end,
})

return M
