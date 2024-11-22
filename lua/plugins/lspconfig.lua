return {
  "neovim/nvim-lspconfig",
  event = { "VeryLazy" },
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    lspconfig.ts_ls.setup({
      capabilities = capabilities,
      init_options = {
        plugins = {
          {
            name = "@vue/typescript-plugin",
            location = "/opt/homebrew/lib/node_modules/@vue/typescript-plugin",
            languages = { "javascript", "typescript", "vue" },
          },
        },
      },
      filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
    })

    lspconfig.volar.setup({
      handlers = {
        ["textDocument/hover"] = function(_, result, ctx, config)
          if not (result and result.contents) then
            return
          end
          vim.lsp.handlers.hover(_, result, ctx, config)
        end,
      },
      capabilities = capabilities
    })

    lspconfig.eslint.setup({})

    lspconfig.svelte.setup({ capabilities = capabilities })

    lspconfig.basedpyright.setup({ capabilities = capabilities })

    lspconfig.ruff.setup({ capabilities = capabilities })

    lspconfig.dartls.setup({
      capabilities = capabilities,
      settings = { dart = { lineLength = 120, showTodos = false } },
    })

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    })
  end,
}
