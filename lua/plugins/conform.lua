return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    {
      "<leader>F",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = "",
    },
  },
  config = function()
    local conform = require("conform")

    local function nm_path(bufnr)
      local fname = vim.api.nvim_buf_get_name(bufnr)
      return fname ~= ""
        and vim.fs.find("node_modules", { path = fname, upward = true, type = "directory" })[1]
    end

    --- oxlint (linter) + first available formatter; empty list triggers LSP fallback.
    local function web_formatters(bufnr)
      local nm = nm_path(bufnr)
      local result = {}
      for _, name in ipairs({ "oxfmt", "biome", "prettier" }) do
        if nm and vim.fn.executable(nm .. "/.bin/" .. name) == 1 then
          table.insert(result, name)
          break
        end
      end
      return result
    end

    conform.setup({
      format_on_save = { lsp_fallback = true, timeout_ms = 1000 },
      formatters_by_ft = {
        lua = { "stylua" },
        rust = { "rustfmt", lsp_format = "fallback" },
        python = { "ruff_format" },
        javascript = web_formatters,
        typescript = web_formatters,
        javascriptreact = web_formatters,
        typescriptreact = web_formatters,
        vue = web_formatters,
        css = web_formatters,
        html = web_formatters,
        json = web_formatters,
        yaml = { "prettier", stop_after_first = true, lsp_format = "fallback" },
        markdown = { "prettier", stop_after_first = true, lsp_format = "fallback" },
        xml = { "xmllint" },
        svg = { "xmllint" },
        svelte = function(bufnr)
          local nm = nm_path(bufnr)
          if nm and vim.fn.executable(nm .. "/.bin/biome") == 1 then
            return { "biome" }
          end
          if nm and vim.fn.isdirectory(nm .. "/prettier-plugin-svelte") == 1 then
            return { "prettier" }
          end
          return {}
        end,
      },
    })
  end,
}
