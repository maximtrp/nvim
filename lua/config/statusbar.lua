local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local mode = {
  init = function(self)
    self.mode = vim.fn.mode(1)
  end,
  static = {
    mode_names = {
      ["n"] = "NORM",
      ["no"] = "O-PEND",
      ["nov"] = "O-PEND",
      ["noV"] = "O-PEND",
      ["no\22"] = "O-PEND",
      ["niI"] = "NORM",
      ["niR"] = "NORM",
      ["niV"] = "NORM",
      ["nt"] = "NORM",
      ["ntT"] = "NORM",
      ["v"] = "VIS",
      ["vs"] = "VIS",
      ["V"] = "V-LINE",
      ["Vs"] = "V-LINE",
      ["\22"] = "V-BLOCK",
      ["\22s"] = "V-BLOCK",
      ["s"] = "SEL",
      ["S"] = "S-LINE",
      ["\19"] = "S-BLOCK",
      ["i"] = "INS",
      ["ic"] = "INS",
      ["ix"] = "INS",
      ["R"] = "REPL",
      ["Rc"] = "REPL",
      ["Rx"] = "REPL",
      ["Rv"] = "V-REPL",
      ["Rvc"] = "V-REPL",
      ["Rvx"] = "V-REPL",
      ["c"] = "COMMAND",
      ["cv"] = "EX",
      ["ce"] = "EX",
      ["r"] = "REPL",
      ["rm"] = "MORE",
      ["r?"] = "CONFIRM",
      ["!"] = "SHELL",
      ["t"] = "TERM",
    },
    mode_colors = {
      n = "blue",
      i = "green",
      v = "purple",
      V = "purple",
      ["\22"] = "purple",
      c = "orange",
      s = "cyan",
      S = "cyan",
      ["\19"] = "cyan",
      R = "red",
      r = "red",
      ["!"] = "red",
      t = "red",
    },
  },
  provider = function(self)
    local fmt = vim.bo.fileformat
    local icons = { mac = "  ", unix = "  ", dos = "  " }
    return icons[fmt] .. "%2(" .. self.mode_names[self.mode] .. " %)"
  end,
  hl = function(self)
    local mode = self.mode:sub(1, 1)
    return { bg = self.mode_colors[mode], fg = "background", bold = true }
  end,
  update = { "ModeChanged" },
}

-- File name component
local file_name_block = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
  update = { "BufEnter", "BufWritePost" },
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
      return "..."
    end
    if not conditions.width_percent_below(#filename, 0.6) then
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
  { provider = " " },
  file_icon,
  utils.insert(file_name_modifier, file_name),
  file_flags,
  { provider = "  " },
  { provider = "%<" }
)

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
    return string.format(" %d/%d  ", search.current, math.min(search.total, search.maxcount))
  end,
}

local diagnostics = {
  condition = conditions.has_diagnostics,
  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
  end,
  update = { "DiagnosticChanged", "BufEnter" },
  on_click = {
    callback = function()
      vim.defer_fn(function()
        vim.cmd("Telescope diagnostics")
      end, 100)
    end,
    name = "heirline_diag",
  },
  -- Bug icon, color reflects highest severity
  {
    provider = function(self)
      if self.errors > 0 then
        return vim.diagnostic.config().signs.text[1]
      elseif self.warnings > 0 then
        return vim.diagnostic.config().signs.text[2]
      elseif self.info > 0 then
        return vim.diagnostic.config().signs.text[3]
      elseif self.hints > 0 then
        return vim.diagnostic.config().signs.text[4]
      end
    end,
    hl = function(self)
      if self.errors > 0 then
        return { fg = "diag_error" }
      elseif self.warnings > 0 then
        return { fg = "diag_warn" }
      elseif self.info > 0 then
        return { fg = "diag_info" }
      else
        return { fg = "diag_hint" }
      end
    end,
  },
  {
    condition = function(self)
      return self.errors > 0
    end,
    provider = function(self)
      return self.errors
    end,
    hl = { fg = "diag_error" },
  },
  {
    condition = function(self)
      return self.errors > 0 and (self.warnings > 0 or self.info > 0 or self.hints > 0)
    end,
    provider = ":",
    hl = { fg = "gray" },
  },
  {
    condition = function(self)
      return self.warnings > 0
    end,
    provider = function(self)
      return self.warnings
    end,
    hl = { fg = "diag_warn" },
  },
  {
    condition = function(self)
      return self.warnings > 0 and (self.info > 0 or self.hints > 0)
    end,
    provider = ":",
    hl = { fg = "gray" },
  },
  {
    condition = function(self)
      return self.info > 0
    end,
    provider = function(self)
      return self.info
    end,
    hl = { fg = "diag_info" },
  },
  {
    condition = function(self)
      return self.info > 0 and self.hints > 0
    end,
    provider = ":",
    hl = { fg = "gray" },
  },
  {
    condition = function(self)
      return self.hints > 0
    end,
    provider = function(self)
      return self.hints
    end,
    hl = { fg = "diag_hint" },
  },
  { provider = "  " },
}

local git_branch = {
  condition = conditions.is_git_repo,
  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    local entries = {
      { count = self.status_dict.added or 0,   color = "git_add" },
      { count = self.status_dict.removed or 0, color = "git_del" },
      { count = self.status_dict.changed or 0, color = "git_change" },
    }
    table.sort(entries, function(a, b)
      return a.count > b.count
    end)
    self.sorted_changes = {}
    for _, e in ipairs(entries) do
      if e.count > 0 then
        table.insert(self.sorted_changes, e)
      end
    end
    self.has_changes = #self.sorted_changes > 0
  end,

  hl = { fg = "purple" },
  {
    provider = function(self)
      return "󰘬 " .. self.status_dict.head .. "  "
    end,
    hl = { bold = false },
  },

  -- Icon colored by dominant change type
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = " ",
    hl = function(self)
      return { fg = self.sorted_changes[1].color }
    end,
  },
  -- 1st number
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = function(self)
      return tostring(self.sorted_changes[1].count)
    end,
    hl = function(self)
      return { fg = self.sorted_changes[1].color }
    end,
  },
  -- Separator + 2nd number
  {
    condition = function(self)
      return #self.sorted_changes >= 2
    end,
    { provider = ":", hl = { fg = "gray" } },
    {
      provider = function(self)
        return tostring(self.sorted_changes[2].count)
      end,
      hl = function(self)
        return { fg = self.sorted_changes[2].color }
      end,
    },
  },
  -- Separator + 3rd number
  {
    condition = function(self)
      return #self.sorted_changes >= 3
    end,
    { provider = ":", hl = { fg = "gray" } },
    {
      provider = function(self)
        return tostring(self.sorted_changes[3].count)
      end,
      hl = function(self)
        return { fg = self.sorted_changes[3].color }
      end,
    },
  },
  { provider = "  " },

  on_click = {
    callback = function()
      vim.cmd("LazyGit")
    end,
    name = "heirline_git",
  },
}

local conform_formatters = {
  provider = "󰃢  ",
  hl = { fg = "green" },
  update = { "BufEnter", "BufWritePost" },
  condition = function()
    return #require("conform").list_formatters(0) > 0
  end,
  on_click = {
    callback = function()
      vim.cmd("ConformInfo")
    end,
    name = "heirline_conform",
  },
}

local lsp_formatters = {
  provider = "󰃢  ",
  hl = { fg = "green" },
  update = { "BufEnter", "BufWritePost" },
  condition = function()
    local lsps_active = vim.lsp.get_clients({ bufnr = 0 })
    local lsps = require("config.format").lsp_formatters
    for _, lsp_active in ipairs(lsps_active) do
      for _, lsp in ipairs(lsps) do
        if lsp_active.name == lsp then
          return true
        end
      end
    end
    return false
  end,
}

local lsp_active = {
  provider = "󰣘  ",
  hl = { fg = "green" },
  condition = function()
    return #vim.lsp.get_clients({ bufnr = 0 }) > 0
  end,
  on_click = {
    callback = function()
      vim.cmd("LspInfo")
    end,
    name = "heirline_lsp",
  },
}

-- Ruler component
local ruler = {
  provider = " %l:%c:%p%% ",
  hl = { fg = "gray" },
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
  -- conform_formatters,
  lsp_formatters,
  lsp_active,
  ruler,
}

return statusline
