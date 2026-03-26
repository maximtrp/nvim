local priority = { "ruff", "lua_ls", "efm", "biome", "oxfmt", "svelte", "jsonls" }

local format_first = function(bufnr)
  local clients = vim.lsp.get_clients({ bufnr = bufnr })

  -- Pick the highest-priority client available for this buffer
  local chosen_id
  for _, name in ipairs(priority) do
    for _, client in ipairs(clients) do
      if client.name == name then
        chosen_id = client.id
        break
      end
    end
    if chosen_id then break end
  end

  vim.lsp.buf.format({
    bufnr = bufnr,
    filter = function(client) return client.id == chosen_id end,
    timeout_ms = 1000,
  })
end

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    format_first(args.buf)
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end

    if client.name == "ts_ls" or client.name == "vtsls" or client.name == "vue_ls" then
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end
  end
})

return {
  lsp_formatters = priority
}
