-- Name:         taili
-- Description:  My custom color scheme based on Vim's default one
-- Author:       Maksim Terpilovskii
-- Maintainer:   Maksim Terpilovskii
-- Website:      https://github.com/maximtrp/nvim
-- License:      Same as Vim
-- Last Updated: 2024 Nov 22

vim.cmd.highlight("clear")
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
}

--stylua: ignore start
-- General
--hi('Normal', { fg = "Black" })
hi('Conceal',      { fg = 'LightGrey', bg = 'DarkGrey', ctermfg = 'LightGrey', ctermbg = 'DarkGrey' })
hi('NotifyBackground', { fg = 'Black', bg = 'LightGrey', ctermfg = 'DarkGrey', ctermbg = 'LightGrey' })
hi('Cursor',       {})
hi('lCursor',      {})
hi('DiffText',     { bg = 'Red', bold = true,           ctermbg = 'Red', cterm = { bold = true } })
hi('ErrorMsg',     { fg = 'White', bg = 'Red',          ctermfg = 'White', ctermbg = 'DarkRed' })
hi('IncSearch',    { reverse = true,                    cterm = { reverse = true } })
hi('ModeMsg',      { bold = true,                       cterm = { bold = true } })
hi('NonText',      { fg = 'Blue', bold = true,          ctermfg = 'Blue' })
hi('PmenuSbar',    { bg = 'Grey',                       ctermbg = 'Grey' })
hi('StatusLine',   { bg = "none",                  cterm = { reverse = true, bold = true }})
hi('StatusLineNC', { bg = "none",                  cterm = { reverse = true } })
hi('TabLineFill',  { reverse = true,                    cterm = { reverse = true } })
hi('TabLineSel',   { bold = true,                       cterm = { bold = true } })
hi('TermCursor',   { reverse = true,                    cterm = { reverse = true } })
hi('WinBar',       { bold = true,                       cterm = { bold = true } })
hi('WildMenu',     { fg = 'Black', bg = 'Yellow',       ctermfg = 'Black', ctermbg = 'Yellow' })

hi('VertSplit',      { link = 'Normal' })
hi('WinSeparator',   { link = 'VertSplit' })
hi('WinBarNC',       { link = 'WinBar' })
hi('EndOfBuffer',    { link = 'NonText' })
hi('LineNrAbove',    { link = 'LineNr' })
hi('LineNrBelow',    { link = 'LineNr' })
hi('QuickFixLine',   { link = 'Search' })
hi('CursorLineSign', { link = 'SignColumn' })
hi('CursorLineFold', { link = 'FoldColumn' })
hi('CurSearch',      { link = 'Search' })
hi('PmenuKind',      { link = 'Pmenu' })
hi('PmenuKindSel',   { link = 'PmenuSel' })
hi('PmenuExtra',     { link = 'Pmenu' })
hi('PmenuExtraSel',  { link = 'PmenuSel' })
hi('Substitute',     { link = 'Search' })
hi('Whitespace',     { link = 'NonText' })
hi('MsgSeparator',   { link = 'StatusLine' })
hi('NormalFloat',    { link = 'Pmenu' })
hi('FloatBorder',    { link = 'WinSeparator' })
hi('FloatTitle',     { link = 'Title' })
hi('FloatFooter',    { link = 'Title' })

hi('FloatShadow',          { bg = 'Black', blend=80 })
hi('FloatShadowThrough',   { bg = 'Black', blend=100 })
hi('RedrawDebugNormal',    { reverse = true,             cterm = { reverse = true } })
hi('RedrawDebugClear',     { bg = 'Yellow',              ctermbg = 'Yellow' })
hi('RedrawDebugComposed',  { bg = 'Green',               ctermbg = 'Green' })
hi('RedrawDebugRecompose', { bg = 'Red',                 ctermbg = 'Red' })
hi('Error',                { fg = 'White', bg = 'Red',   ctermfg = 'White', ctermbg = 'Red' })
hi('Todo',                 { bg = 'Blue', fg = 'White', ctermfg = 'Black', ctermbg = 'Yellow' })

--hi('String',         { link = 'Constant' })
--hi('Character',      { link = 'Constant' })
--hi('Number',         { link = 'Constant' })
--hi('Boolean',        { link = 'Constant' })
--hi('Float',          { link = 'Number' })
--hi('Function',       { link = 'Identifier' })
hi('Conditional',    { link = 'Conditional' })
hi('Repeat',         { link = 'Conditional' })
hi('Label',          { link = 'Statement' })
hi('Keyword',        { link = 'Statement' })
hi('Exception',      { link = 'Statement' })
hi('Include',        { link = 'PreProc' })
hi('Define',         { link = 'PreProc' })
hi('Macro',          { link = 'PreProc' })
hi('PreCondit',      { link = 'PreProc' })
hi('StorageClass',   { link = 'Type' })
hi('Structure',      { link = 'Type' })
hi('Typedef',        { link = 'Type' })
--hi('Tag',            { link = 'Special' })
hi('SpecialChar',    { link = 'Special' })
hi('Delimiter',      { link = 'Special' })
hi('SpecialComment', { link = 'Special' })
hi('Debug',          { link = 'Special' })

hi('GitSignsChange', { fg = 'Orange' })
hi('GitSignsAdd', { fg = 'Green' })
hi('GitSignsDelete', { fg = 'Red' })

hi('DiagnosticError',            { fg = light.red,                          ctermfg = 1 })
hi('DiagnosticWarn',             { fg = light.orange,                       ctermfg = 3 })
hi('DiagnosticInfo',             { fg = light.green,                    ctermfg = 4 })
hi('DiagnosticHint',             { fg = light.blue,                    ctermfg = 7 })
hi('DiagnosticOk',               { fg = light.green,                   ctermfg = 10 })
hi('DiagnosticUnderlineError',   { sp = light.red,         cterm = {  } })
hi('DiagnosticUnderlineWarn',    { sp = light.orange,      cterm = {  } })
hi('DiagnosticUnderlineInfo',    { sp = light.green,   cterm = {  } })
hi('DiagnosticUnderlineHint',    { sp = 'LightGrey',   cterm = { } })
hi('DiagnosticUnderlineOk',      { sp = light.green,  cterm = { } })
hi('DiagnosticVirtualTextError', { link = 'DiagnosticError' })
hi('DiagnosticVirtualTextWarn',  { link = 'DiagnosticWarn' })
hi('DiagnosticVirtualTextInfo',  { link = 'DiagnosticInfo' })
hi('DiagnosticVirtualTextHint',  { link = 'DiagnosticHint' })
hi('DiagnosticVirtualTextOk',    { link = 'DiagnosticOk' })
hi('DiagnosticFloatingError',    { link = 'DiagnosticError' })
hi('DiagnosticFloatingWarn',     { link = 'DiagnosticWarn' })
hi('DiagnosticFloatingInfo',     { link = 'DiagnosticInfo' })
hi('DiagnosticFloatingHint',     { link = 'DiagnosticHint' })
hi('DiagnosticFloatingOk',       { link = 'DiagnosticOk' })
hi('DiagnosticSignError',        { link = 'DiagnosticError' })
hi('DiagnosticSignWarn',         { link = 'DiagnosticWarn' })
hi('DiagnosticSignInfo',         { link = 'DiagnosticInfo' })
hi('DiagnosticSignHint',         { link = 'DiagnosticHint' })
hi('DiagnosticSignOk',           { link = 'DiagnosticOk' })
hi('DiagnosticDeprecated',       { sp = 'Red', strikethrough = true,    cterm = { strikethrough = true } })
hi('DiagnosticUnnecessary', { link = 'Comment', })
hi('LspInlayHint',          { link = 'NonText' })
hi('SnippetTabstop',        { link = 'Visual' })

-- Text
hi('@markup.raw',       { link = 'Comment' })
hi('@markup.link',      { link = 'Identifier' })
hi('@markup.heading',   { link = 'Title' })
hi('@markup.link.url',  { link = 'Underlined' })
hi('@markup.underline', { link = 'Underlined' })
hi('@comment.todo',     { link = 'Todo' })

-- Miscs
hi('@comment',     { link = 'Comment' })
hi('@punctuation', { link = 'Delimiter' })

-- Constants
hi('@constant',          { link = 'Constant' })
hi('@constant.builtin',  { link = 'Builtin' })
hi('@constant.regex',  { link = 'Constant' })
hi('@constant.macro',    { link = 'Define' })
hi('@keyword.directive', { link = 'Define' })
hi('@string',            { link = 'String' })
hi('@string.escape',     { link = 'SpecialChar' })
hi('@string.special',    { link = 'SpecialChar' })
hi('@string.regexp',     { link = 'Constant' })
hi('@character',         { link = 'Character' })
hi('@character.special', { link = 'SpecialChar' })
hi('@number',            { link = 'Number' })
hi('@boolean',           { link = 'Boolean' })
hi('@number.float',      { link = 'Float' })

-- Functions
hi('@function',                   { link = 'Function' })
hi('@function.builtin',           { link = 'Special' })
hi('@function.macro',             { link = 'Macro' })
hi('@function.method',            { link = 'Function' })
hi('@variable.parameter',         { link = 'Identifier' })
hi('@variable.parameter.builtin', { link = 'Special' })
hi('@variable.member',            { link = 'Member' })
hi('@property',                   { link = 'Identifier' })
hi('@attribute',                  { link = 'Macro' })
hi('@attribute.builtin',          { link = 'Special' })
hi('@constructor',                { link = 'Special' })

-- Keywords
hi('@keyword.conditional', { link = 'Conditional' })
hi('@keyword.repeat',      { link = 'Repeat' })
hi('@keyword.type',        { link = 'Structure' })
hi('@label',               { link = 'Label' })
hi('@operator',            { link = 'Operator' })
hi('@keyword',             { link = 'Keyword' })
hi('@keyword.exception',   { link = 'Exception' })

hi('@variable',           { link = 'Identifier' })
hi('@type',               { link = 'Type' })
hi('@type.definition',    { link = 'Typedef' })
hi('@module',             { link = 'Identifier' })
hi('@keyword.import',     { link = 'Include' })
hi('@keyword.directive',  { link = 'PreProc' })
hi('@keyword.debug',      { link = 'Debug' })
hi('@tag',                { link = 'Tag' })
hi('@tag.attribute',      { link = 'TagAttribute' })
hi('@tag.delimiter',      { link = 'TagDelimiter' })
hi('@tag.builtin',        { link = 'Special' })
hi('@property.css',       { link = 'CSSprop' })

-- LSP semantic tokens
hi('@lsp.type.class',         { link = 'Structure' })
hi('@lsp.type.comment',       { link = 'Comment' })
hi('@lsp.type.decorator',     { link = 'Function' })
hi('@lsp.type.enum',          { link = 'Structure' })
hi('@lsp.type.enumMember',    { link = 'Constant' })
hi('@lsp.type.function',      { link = 'Function' })
hi('@lsp.type.interface',     { link = 'Structure' })
hi('@lsp.type.macro',         { link = 'Macro' })
hi('@lsp.type.method',        { link = 'Function' })
hi('@lsp.type.namespace',     { link = 'Structure' })
hi('@lsp.type.parameter',     { link = 'Identifier' })
hi('@lsp.type.property',      { link = '' })
hi('@lsp.type.struct',        { link = 'Structure' })
hi('@lsp.type.type',          { link = 'Type' })
hi('@lsp.type.typeParameter', { link = 'TypeDef' })
hi('@lsp.type.variable',      { link = 'Identifier' })
hi('@lsp.typemod.property.annotation',      { link = 'PreProc' })
hi('@lsp.typemod.parameter.label',      { link = 'Parameter' })

if vim.o.background == 'light' then
  -- Default colors only used with a light background.
  hi('Normal',       { fg = light.black,                            ctermbg = 'White' })
  hi('ColorColumn',  { bg = 'LightRed',                            ctermbg = 'LightRed' })
  hi('CursorColumn', { bg = 'Grey90',                              ctermbg = 'LightGrey' })
  hi('CursorLine',   { bg = 'Grey90',                              cterm = { underline = true } })
  hi('CursorLineNr', { fg = 'Brown', bold = true,                  ctermfg = 'Brown', cterm = { underline = true } })
  hi('DiffAdd',      { bg = 'Green',                           ctermbg = 'LightBlue' })
  hi('DiffChange',   { bg = 'Orange',                        ctermbg = 'LightMagenta' })
  hi('DiffDelete',   { fg = 'Red',                          ctermfg = 'Blue', ctermbg = 'LightCyan' })
  hi('Directory',    { fg = 'Black', bold = true,                                ctermfg = 'DarkBlue' })
  hi('FoldColumn',   { fg = 'Grey',                            ctermfg = 'DarkBlue', ctermbg = 'Grey' })
  hi('Folded',       { fg = 'Red',                            ctermfg = 'DarkBlue', ctermbg = 'Grey' })
  hi('LineNr',       { fg = 'Grey',                                ctermfg = 'Brown' })
  hi('MatchParen',   { fg = 'Magenta', bg = "White",                                ctermbg = 'Cyan' })
  hi('MoreMsg',      { fg = 'SeaGreen', bold = true,               ctermfg = 'DarkGreen' })
  hi('Pmenu',        { bg = '#cccccc',                        ctermfg = 'Black', ctermbg = 'LightMagenta' })
  hi('PmenuSel',     { bg = 'Grey',                                ctermfg = 'Black', ctermbg = 'LightGrey' })
  hi('PmenuThumb',   { bg = 'Black',                               ctermbg = 'Black' })
  hi('Question',     { fg = 'SeaGreen', bold = true,               ctermfg = 'DarkGreen' })
  hi('Search',       { bg = 'Yellow',                              ctermbg = 'Yellow' })
  hi('SignColumn',   { fg = 'DarkBlue', bg = 'Grey',               ctermfg = 'DarkBlue', ctermbg = 'Grey' })
  hi('SpecialKey',   { fg = 'Blue',                                ctermfg = 'DarkBlue' })
  hi('SpellBad',     { sp = 'Red', undercurl = true,               ctermbg = 'LightRed' })
  hi('SpellCap',     { sp = 'Blue', undercurl = true,              ctermbg = 'LightBlue' })
  hi('SpellLocal',   { sp = 'DarkCyan', undercurl = true,          ctermbg = 'Cyan' })
  hi('SpellRare',    { sp = 'Magenta', undercurl = true,           ctermbg = 'LightMagenta' })
  hi('TabLine',      { bg = 'LightGrey',          ctermfg = 'Black', ctermbg = 'LightGrey', cterm = { underline = true } })
  hi('NonText',      { fg = 'LightGrey',         ctermfg = 'White', ctermbg = 'DarkGrey', cterm = { underline = true } })
  hi('Title',        { fg = 'Black', bold = true,                ctermfg = 'DarkMagenta' })
  hi('Visual',       { fg = 'Black', bg = 'LightGrey',             ctermfg = 'Black', ctermbg = 'Grey' })

  hi('WarningMsg',   { fg = light.red,                                 ctermfg = 'DarkRed' })
  hi('Comment',      { fg = light.grey,                                ctermfg = 'DarkBlue' })
  hi('Constant',     { fg = light.purple,                             ctermfg = 'DarkRed' })
  hi('Character',    { fg = light.green,                             ctermfg = 'DarkRed' })
  hi('Boolean',      { fg = light.purple,                             ctermfg = 'DarkRed' })
  hi('Member',      { fg = light.violet,                             ctermfg = 'Red' })
  hi('Parameter',   { fg = light.brown,                               ctermfg = 'DarkCyan' })
  hi('Number',       { fg = light.cyan,                             ctermfg = 'Cyan' })
  hi('Builtin',       { fg = light.teal,                             ctermfg = 'Red' })
  hi('CSStype',       { fg = light.red,                             ctermfg = 'DarkRed' })
  hi('CSSprop',       { fg = light.teal,                             ctermfg = 'Red' })
  hi('Function',     { fg = light.blue,                                ctermfg = 'DarkRed' })
  hi('String',       { fg = light.green,                               ctermfg = 'Green' })
  hi('Tag',          { fg = light.red,                               ctermfg = 'Green' })
  hi('TagDelimiter', { fg = light.grey,                               ctermfg = 'Green' })
  hi('TagAttribute', { fg = light.orange,                               ctermfg = 'Green' })
  hi('Special',      { fg = '',                             ctermfg = 'DarkMagenta' })
  hi('Identifier',   { fg = light.black,                               ctermfg = 'DarkCyan' })
  hi('Statement',    { fg = light.red,                     ctermfg = 'Red' })
  hi('Conditional',  { fg = light.red, bold = true,                    ctermfg = 'Red' })
  hi('PreProc',      { fg = light.red,                             ctermfg = 'DarkMagenta' })
  hi('Type',         { fg = light.teal,               ctermfg = 'DarkGreen' })
  hi('Underlined',   { fg = light.blue, underline = true,         ctermfg = 'DarkMagenta', cterm = { underline = true } })
  hi('Ignore',       {                                             ctermfg = 'White' })
  hi('IblIndent',    { fg = "#f5f5f4",                           ctermfg = 'White' })
  hi('IblScope',     { fg = "#a8a29e",                                ctermfg = 'White' })
else
  -- Default colors only used with a dark background.
  hi('Normal',       { fg = dark.white,                            ctermbg = 'DarkRed' })
  hi('ColorColumn',  { bg = 'DarkRed',                            ctermbg = 'DarkRed' })
  hi('CursorColumn', { bg = 'Grey40',                             ctermbg = 'DarkGrey' })
  hi('CursorLine',   { bg = 'Grey40',                             cterm = { underline = true } })
  hi('CursorLineNr', { fg = 'Yellow', bold = true,                ctermfg = 'Yellow', cterm = { underline = true } })
  hi('DiffAdd',      { bg = 'DarkBlue',                           ctermbg = 'DarkBlue' })
  hi('DiffChange',   { bg = 'DarkMagenta',                        ctermbg = 'DarkMagenta' })
  hi('DiffDelete',   { fg = 'Blue', bg = 'DarkCyan', bold = true, ctermfg = 'Blue', ctermbg = 'DarkCyan' })
  hi('Directory',    { fg = 'White', bold = true,                              ctermfg = 'LightCyan' })
  hi('FoldColumn',   { fg = 'Grey',                   ctermfg = 'Cyan', ctermbg = 'DarkGrey' })
  hi('Folded',       { fg = 'Red',               ctermfg = 'Cyan', ctermbg = 'DarkGrey' })
  hi('LineNr',       { fg = 'Grey',                             ctermfg = 'Yellow' })
  hi('MatchParen',   { fg = 'Magenta',                           ctermbg = 'DarkCyan' })
  hi('MoreMsg',      { fg = 'SeaGreen', bold = true,              ctermfg = 'LightGreen' })
  hi('Pmenu',        { bg = '#323232',                            ctermfg = 'Black', ctermbg = 'Magenta' })
  hi('PmenuSel',     { bg = 'Grey',                           ctermfg = 'DarkGrey', ctermbg = 'Black' })
  hi('PmenuThumb',   { bg = 'White',                              ctermbg = 'White' })
  hi('Question',     { fg = 'Green', bold = true,                 ctermfg = 'LightGreen' })
  hi('Search',       { fg = 'Black', bg = 'Yellow',               ctermfg = 'Black', ctermbg = 'Yellow' })
  hi('SignColumn',   { fg = 'Cyan', bg = 'Grey',                  ctermfg = 'Cyan', ctermbg = 'DarkGrey' })
  hi('SpecialKey',   { fg = 'Cyan',                               ctermfg = 'LightBlue' })
  hi('SpellBad',     { sp = 'Red', undercurl = true,              ctermbg = 'Red' })
  hi('SpellCap',     { sp = 'Blue', undercurl = true,             ctermbg = 'Blue' })
  hi('SpellLocal',   { sp = 'Cyan', undercurl = true,             ctermbg = 'Cyan' })
  hi('SpellRare',    { sp = 'Magenta', undercurl = true,          ctermbg = 'Magenta' })
  hi('TabLine',      { bg = 'DarkGrey', underline = true,         ctermfg = 'White', ctermbg = 'DarkGrey', cterm = { underline = true } })
  hi('NonText',      { fg = 'DarkGrey',         ctermfg = 'White', ctermbg = 'DarkGrey', cterm = { underline = true } })
  hi('Title',        { fg = 'White', bold = true,               ctermfg = 'LightMagenta' })
  hi('Visual',       { fg = 'LightGrey', bg = '#575757',          ctermfg = 'Black', ctermbg = 'Grey' })
  
  hi('WarningMsg',   { fg = 'Red',                                 ctermfg = 'DarkRed' })
  hi('Comment',      { fg = dark.grey,                                ctermfg = 'DarkBlue' })
  hi('Constant',     { fg = dark.purple,                             ctermfg = 'DarkRed' })
  hi('Character',    { fg = dark.green,                             ctermfg = 'DarkRed' })
  hi('Boolean',      { fg = dark.purple,                             ctermfg = 'DarkRed' })
  hi('Member',      { fg = dark.violet,                             ctermfg = 'DarkRed' })
  hi('Number',       { fg = dark.cyan,                             ctermfg = 'Cyan' })
  hi('Builtin',       { fg = dark.teal,                             ctermfg = 'Red' })
  hi('CSSprop',       { fg = dark.teal,                             ctermfg = 'DarkRed' })
  hi('CSStype',       { fg = dark.red,                             ctermfg = 'DarkRed' })
  hi('Function',     { fg = dark.blue,                                ctermfg = 'DarkRed' })
  hi('String',       { fg = dark.green,                               ctermfg = 'Green' })
  hi('Tag',          { fg = dark.red,                               ctermfg = 'Green' })
  hi('TagDelimiter', { fg = dark.grey,                               ctermfg = 'Green' })
  hi('TagAttribute', { fg = dark.orange,                               ctermfg = 'Green' })
  hi('Special',      { fg = '',                             ctermfg = 'DarkMagenta' })
  hi('Identifier',   { fg = dark.white,                               ctermfg = 'DarkCyan' })
  hi('Parameter',   { fg = dark.brown,                               ctermfg = 'DarkCyan' })
  hi('Statement',    { fg = dark.red,                     ctermfg = 'Red' })
  hi('Operator',    { fg = dark.yellow,                     ctermfg = 'Yellow' })
  hi('Conditional',  { fg = dark.red, bold = true,                    ctermfg = 'Red' })
  hi('PreProc',      { fg = dark.red,                             ctermfg = 'DarkMagenta' })
  hi('Type',         { fg = dark.teal,               ctermfg = 'DarkGreen' })
  hi('Underlined',   { fg = dark.blue, underline = true,         ctermfg = 'DarkMagenta', cterm = { underline = true } })
  hi('Ignore',       {                                            ctermfg = 'Black' })
  hi('IblIndent',    { fg = "#292524",                           ctermfg = 'White' })
  hi('IblScope',     { fg = "#57534e",                                ctermfg = 'White' })
end
--stylua: ignore end
