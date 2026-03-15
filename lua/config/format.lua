local priority = { "efm", "biome", "oxfmt", "svelte", "lua_ls", "jsonls" }

local function first_formatter(client)
  -- Find the first client (in priority order) that supports formatting
  for _, name in ipairs(priority) do
    if client.name == name then
      return true
    end
  end
  return false
end

local format_first = function(bufnr)
  vim.lsp.buf.format({
    bufnr = bufnr,
    filter = first_formatter,
    timeout_ms = 1000,
  })
end

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    format_first(args.buf)
  end,
})

return {
  lsp_formatters = priority
}
