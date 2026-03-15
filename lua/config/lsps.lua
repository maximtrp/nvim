vim.lsp.config("astro", {})
vim.lsp.config("vue_ls", {})
vim.lsp.config("gopls", {})
vim.lsp.config("oxlint", {})
vim.lsp.config("oxfmt", {})
vim.lsp.config("emmet_language_server", {})
vim.lsp.config("docker_language_server", {})

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
  filetypes = { "javascript", "typescript", "vue" },
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


vim.lsp.config("efm", {
  init_options = { documentFormatting = true },
  settings = {
    languages = {
      javascript = { require("efmls-configs.formatters.prettier_d") },
      typescript = { require("efmls-configs.formatters.prettier_d") },
      javascriptreact = { require("efmls-configs.formatters.prettier_d") },
      typescriptreact = { require("efmls-configs.formatters.prettier_d") },
      astro = { require("efmls-configs.formatters.prettier_d") },
      vue = { require("efmls-configs.formatters.prettier_d") },
      css = { require("efmls-configs.formatters.prettier_d") },
      html = { require("efmls-configs.formatters.prettier_d") },
      json = { require("efmls-configs.formatters.prettier_d") },
      jsonc = { require("efmls-configs.formatters.prettier_d") },
      yaml = { require("efmls-configs.formatters.prettier_d") },
      markdown = { require("efmls-configs.formatters.prettier_d") },
      svelte = { require("efmls-configs.formatters.prettier_d") },
    },
  },
})

vim.lsp.enable({
  "astro",
  "basedpyright",
  "biome",
  "cssls",
  "dartls",
  "docker_language_server",
  "efm",
  "emmet_language_server",
  "eslint",
  "gopls",
  "html",
  "jsonls",
  "lua_ls",
  "oxlint",
  "oxfmt",
  "prismals",
  -- "pylsp",
  "ruff",
  "svelte",
  "tailwindcss",
  "vtsls",
  "vue_ls",
})
