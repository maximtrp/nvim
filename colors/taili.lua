-- Name:         taili
-- Description:  My custom color scheme based on Vim's default one
-- Author:       Maksim Terpilovskii
-- Maintainer:   Maksim Terpilovskii
-- Website:      https://github.com/maximtrp/nvim
-- License:      Same as Vim
-- Last Updated: 2024 Nov 22

-- vim.cmd.highlight("clear")
vim.g.colors_name = "taili"

local hi = function(name, val)
	-- Force links
	val.force = true

	-- Make sure that `cterm` attribute is not populated from `gui`
	val.cterm = val.cterm or {}

	-- Define global highlight
	vim.api.nvim_set_hl(0, name, val)
end

local light = {
	white = "#d2d2d2",
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
	black = "#3F3F3F",
	grey = "#737373",
	light_grey = "#dedede",
}

local dark = {
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
	black = "#3F3F3F",
	white = "#d4d4d4",
	grey = "#888888",
	dark_grey = "#444444",
}

hi("NotifyBackground", { fg = "Black", bg = "LightGrey" })

--hi('String',         { link = 'Constant' })
--hi('Character',      { link = 'Constant' })
--hi('Number',         { link = 'Constant' })
--hi('Boolean',        { link = 'Constant' })
--hi('Float',          { link = 'Number' })
--hi('Function',       { link = 'Identifier' })
hi("Conditional", { link = "Conditional" })
hi("Repeat", { link = "Conditional" })
hi("Label", { link = "Statement" })
hi("Keyword", { link = "Statement" })
hi("Exception", { link = "Statement" })
hi("Include", { link = "PreProc" })
hi("Define", { link = "PreProc" })
hi("Macro", { link = "PreProc" })
hi("PreCondit", { link = "PreProc" })
hi("StorageClass", { link = "Type" })
hi("Structure", { link = "Type" })
hi("Typedef", { link = "Type" })
--hi('Tag',            { link = 'Special' })
hi("SpecialChar", { link = "Special" })
hi("Delimiter", { link = "Special" })
hi("SpecialComment", { link = "Special" })
hi("Debug", { link = "Special" })

hi("GitSignsChange", { fg = light.orange })
hi("GitSignsAdd", { fg = light.green })
hi("GitSignsDelete", { fg = light.red })

hi("DiagnosticError", { fg = light.red })
hi("DiagnosticWarn", { fg = light.orange })
hi("DiagnosticInfo", { fg = light.green })
hi("DiagnosticHint", { fg = light.blue })
hi("DiagnosticOk", { fg = light.green })
hi("DiagnosticUnderlineError", { sp = light.red, underline = true })
hi("DiagnosticUnderlineWarn", { sp = light.orange, underline = true })
hi("DiagnosticUnderlineInfo", { sp = light.green, underline = true })
hi("DiagnosticUnderlineHint", { sp = light.grey, underline = true })
hi("DiagnosticUnderlineOk", { sp = light.green, underline = true })
hi("DiagnosticVirtualTextError", { link = "DiagnosticError" })
hi("DiagnosticVirtualTextWarn", { link = "DiagnosticWarn" })
hi("DiagnosticVirtualTextInfo", { link = "DiagnosticInfo" })
hi("DiagnosticVirtualTextHint", { link = "DiagnosticHint" })
hi("DiagnosticVirtualTextOk", { link = "DiagnosticOk" })
hi("DiagnosticFloatingError", { link = "DiagnosticError" })
hi("DiagnosticFloatingWarn", { link = "DiagnosticWarn" })
hi("DiagnosticFloatingInfo", { link = "DiagnosticInfo" })
hi("DiagnosticFloatingHint", { link = "DiagnosticHint" })
hi("DiagnosticFloatingOk", { link = "DiagnosticOk" })
hi("DiagnosticSignError", { link = "DiagnosticError" })
hi("DiagnosticSignWarn", { link = "DiagnosticWarn" })
hi("DiagnosticSignInfo", { link = "DiagnosticInfo" })
hi("DiagnosticSignHint", { link = "DiagnosticHint" })
hi("DiagnosticSignOk", { link = "DiagnosticOk" })
hi("DiagnosticDeprecated", { sp = "Red", strikethrough = true, cterm = { strikethrough = true } })
hi("DiagnosticUnnecessary", { link = "Comment" })
hi("LspInlayHint", { link = "NonText" })
hi("SnippetTabstop", { link = "Visual" })

-- Text
hi("@markup.raw", { link = "Comment" })
hi("@markup.link", { link = "Identifier" })
hi("@markup.heading", { link = "Title" })
hi("@markup.link.url", { link = "Underlined" })
hi("@markup.underline", { link = "Underlined" })
hi("@comment.todo", { link = "Todo" })

-- Miscs
hi("@comment", { link = "Comment" })
hi("@punctuation", { link = "Delimiter" })

-- Constants
hi("@constant", { link = "Constant" })
hi("@constant.builtin", { link = "Builtin" })
hi("@constant.regex", { link = "Constant" })
hi("@constant.macro", { link = "Define" })
hi("@keyword.directive", { link = "Define" })
hi("@string", { link = "String" })
hi("@string.escape", { link = "SpecialChar" })
hi("@string.special", { link = "SpecialChar" })
hi("@string.regexp", { link = "Constant" })
hi("@character", { link = "Character" })
hi("@character.special", { link = "SpecialChar" })
hi("@number", { link = "Number" })
hi("@boolean", { link = "Boolean" })
hi("@number.float", { link = "Float" })

-- Functions
hi("@function", { link = "Function" })
hi("@function.builtin", { link = "Special" })
hi("@function.macro", { link = "Macro" })
hi("@function.method", { link = "Function" })
hi("@variable.parameter", { link = "Identifier" })
hi("@variable.parameter.builtin", { link = "Special" })
hi("@variable.member", { link = "Member" })
hi("@property", { link = "Identifier" })
hi("@attribute", { link = "Macro" })
hi("@attribute.builtin", { link = "Special" })
hi("@constructor", { link = "Special" })

-- Keywords
hi("@keyword.conditional", { link = "Conditional" })
hi("@keyword.repeat", { link = "Repeat" })
hi("@keyword.type", { link = "Structure" })
hi("@label", { link = "Label" })
hi("@operator", { link = "Operator" })
hi("@keyword", { link = "Keyword" })
hi("@keyword.exception", { link = "Exception" })

hi("@variable", { link = "Identifier" })
hi("@type", { link = "Type" })
hi("@type.definition", { link = "Typedef" })
hi("@module", { link = "Identifier" })
hi("@keyword.import", { link = "Include" })
hi("@keyword.directive", { link = "PreProc" })
hi("@keyword.debug", { link = "Debug" })
hi("@tag", { link = "Tag" })
hi("@tag.attribute", { link = "TagAttribute" })
hi("@tag.delimiter", { link = "TagDelimiter" })
hi("@tag.builtin", { link = "Special" })
hi("@property.css", { link = "CSSprop" })

-- LSP semantic tokens
hi("@lsp.type.class", { link = "Structure" })
hi("@lsp.type.comment", { link = "Comment" })
hi("@lsp.type.decorator", { link = "Function" })
hi("@lsp.type.enum", { link = "Structure" })
hi("@lsp.type.enumMember", { link = "Constant" })
hi("@lsp.type.function", { link = "Function" })
hi("@lsp.type.interface", { link = "Structure" })
hi("@lsp.type.macro", { link = "Macro" })
hi("@lsp.type.method", { link = "Function" })
hi("@lsp.type.namespace", { link = "Structure" })
hi("@lsp.type.parameter", { link = "Identifier" })
hi("@lsp.type.property", { link = "" })
hi("@lsp.type.struct", { link = "Structure" })
hi("@lsp.type.type", { link = "Type" })
hi("@lsp.type.typeParameter", { link = "TypeDef" })
hi("@lsp.type.variable", { link = "Identifier" })
hi("@lsp.typemod.property.annotation", { link = "PreProc" })
hi("@lsp.typemod.parameter.label", { link = "Parameter" })

if vim.o.background == "light" then
	hi("Normal", { fg = light.black })
	hi("Title", { fg = light.black, bold = true })
	hi("NormalFloat", { bg = light.light_grey, fg = light.black })
	hi("NormalNC", { fg = light.grey })

	hi("Directory", { fg = light.black, bold = true })
	hi("MsgArea", { bg = light.light_grey, fg = light.black })
	hi("Visual", { bg = light.light_grey, fg = light.black })
	hi("Search", { bg = light.yellow, fg = light.black })
	hi("Pmenu", { bg = light.light_grey, fg = light.black })
	hi("PmenuSel", { bg = light.grey, fg = light.white })
	hi("WarningMsg", { fg = light.red })
	hi("Special", { fg = light.grey })
	hi("MatchParen", { fg = light.orange })

	hi("Comment", { fg = light.grey })
	hi("Constant", { fg = light.purple })
	hi("Character", { fg = light.green })
	hi("Boolean", { fg = light.purple })
	hi("Member", { fg = light.violet })
	hi("Parameter", { fg = light.brown })
	hi("Number", { fg = light.cyan })
	hi("Builtin", { fg = light.teal })
	hi("CSStype", { fg = light.red })
	hi("CSSprop", { fg = light.teal })
	hi("Function", { fg = light.blue })
	hi("String", { fg = light.green })
	hi("Tag", { fg = light.red })
	hi("TagDelimiter", { fg = light.grey })
	hi("TagAttribute", { fg = light.orange })
	hi("Identifier", { fg = light.black })
	hi("Statement", { fg = light.red })
	hi("Operator", { fg = light.orange })
	hi("Conditional", { fg = light.red, bold = true })
	hi("PreProc", { fg = light.red })
	hi("Type", { fg = light.teal })
	hi("Underlined", { underline = true })
	hi("Ignore", {})
	hi("IblIndent", { fg = "#f5f5f4" })
	hi("IblScope", { fg = "#a8a29e" })
else
	-- Default colors only used with a dark background.
	hi("Normal", { fg = dark.black })
	hi("Title", { fg = dark.black, bold = true })
	hi("NormalFloat", { bg = dark.dark_grey, fg = dark.black })
	hi("NormalNC", { fg = dark.grey })

	hi("Directory", { fg = dark.black, bold = true })
	hi("MsgArea", { bg = dark.dark_grey, fg = dark.black })
	hi("Visual", { bg = dark.dark_grey, fg = dark.black })
	hi("Search", { bg = dark.yellow, fg = dark.black })
	hi("Pmenu", { bg = dark.dark_grey, fg = dark.black })
	hi("PmenuSel", { bg = dark.grey, fg = dark.white })
	hi("WarningMsg", { fg = dark.red })
	hi("Special", { fg = dark.orange })
	hi("MatchParen", { fg = dark.violet })

	hi("Comment", { fg = dark.grey })
	hi("Comment", { fg = dark.grey })
	hi("Constant", { fg = dark.purple })
	hi("Character", { fg = dark.green })
	hi("Boolean", { fg = dark.purple })
	hi("Member", { fg = dark.violet })
	hi("Number", { fg = dark.cyan })
	hi("Builtin", { fg = dark.teal })
	hi("CSSprop", { fg = dark.teal })
	hi("CSStype", { fg = dark.red })
	hi("Function", { fg = dark.blue })
	hi("String", { fg = dark.green })
	hi("Tag", { fg = dark.red })
	hi("TagDelimiter", { fg = dark.grey })
	hi("TagAttribute", { fg = dark.orange })
	hi("Identifier", { fg = dark.white })
	hi("Parameter", { fg = dark.brown })
	hi("Statement", { fg = dark.red })
	hi("Operator", { fg = dark.yellow })
	hi("Conditional", { fg = dark.red, bold = true })
	hi("PreProc", { fg = dark.red })
	hi("Type", { fg = dark.teal })
	hi("Underlined", { underline = true })
	hi("Ignore", {})
	hi("IblIndent", { fg = "#292524" })
	hi("IblScope", { fg = "#57534e" })
end
