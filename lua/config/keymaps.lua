local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, opts)
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

vim.keymap.set(
	"n",
	"<leader>fb",
	':lua require("telescope").extensions.file_browser.file_browser({ path = vim.fn.expand("%:p:h"), select_buffer = true })<cr>',
	opts
)
vim.keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
vim.keymap.set("n", "<leader>fD", "<cmd>Telescope diagnostics<CR>", opts)
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files hidden=true<CR>", opts)
vim.keymap.set("n", "<leader>fF", "<cmd>Telescope git_files<CR>", opts)
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", opts)
vim.keymap.set("n", "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<CR>", opts)
vim.keymap.set("n", "<leader>ft", "<cmd>Telescope buffers previewer=false<CR>", opts)
vim.keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", opts)
vim.keymap.set("n", "<leader>fW", "<cmd>Telescope grep_string<CR>", opts)
vim.keymap.set("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", opts)
vim.keymap.set("n", "<leader>gr", "<cmd>Telescope lsp_references<cr>", opts)
vim.keymap.set("n", "<leader>gd", "<cmd>Telescope lsp_definitions", opts)
vim.keymap.set("n", "<leader>gi", "<cmd>Telescope lsp_implementations", opts)

vim.keymap.set("n", "<leader>m", "<cmd>Mason<cr>", opts)
vim.keymap.set("n", "<leader>l", "<cmd>Lazy update<cr>", opts)

vim.keymap.set({ "v", "n" }, "<leader>y", '"+y', opts)
vim.keymap.set({ "v", "n" }, "<leader>d", '"+d', opts)
vim.keymap.set({ "v", "n" }, "<leader>D", '"_d', opts)
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', opts)

vim.keymap.set("n", "[b", "<cmd>bprevious<cr>")
vim.keymap.set("n", "]b", "<cmd>bnext<cr>")
vim.keymap.set("n", "<leader>q", "<cmd>bd<cr>", opts)

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>")

vim.keymap.set("n", "<leader>gb", "<cmd>Gitsigns blame_line<cr>")
vim.keymap.set({ "n", "v" }, "<leader>gs", "<cmd>Telescope git_status<cr>")

vim.keymap.set("n", "<leader>wl", function()
	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, opts)

--vim.keymap.set("n", "zR", require("ufo").openAllFolds)
--vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
