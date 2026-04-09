local ft_formatters = {
  javascript      = { "efm", "biome", "oxfmt" },
  javascriptreact = { "efm", "biome", "oxfmt" },
  typescript      = { "efm", "biome", "oxfmt" },
  typescriptreact = { "efm", "biome", "oxfmt" },
  svelte          = { "efm", "biome", "oxfmt", "svelte", },
  vue             = { "efm", "biome", "oxfmt" },
  lua             = { "lua_ls" },
  dart            = { "dartls" },
  sh              = { "efm" },
  bash            = { "efm" },
  zsh             = { "efm" },
}

local function pick_client(bufnr, priority)
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  for _, name in ipairs(priority) do
    for _, client in ipairs(clients) do
      if client.name == name then
        return client.id
      end
    end
  end
end

local function format_buf(bufnr)
  local ft = vim.bo[bufnr].filetype
  local priority = ft_formatters[ft]

  local chosen_id
  if priority then
    chosen_id = pick_client(bufnr, priority)
  else
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    if clients[1] then
      chosen_id = clients[1].id
    end
  end

  if not chosen_id then return end

  vim.lsp.buf.format({
    bufnr = bufnr,
    filter = function(client) return client.id == chosen_id end,
    timeout_ms = 1000,
  })
end

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    format_buf(args.buf)
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then return end

    if client.name == "ts_ls" or client.name == "vtsls" or client.name == "vue_ls" then
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end
  end,
})

return {
  ft_formatters = ft_formatters,
  format_buf = format_buf,
}
