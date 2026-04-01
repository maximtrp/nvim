vim.api.nvim_create_autocmd("FileType", {
	callback = function(ev)
		local max_filesize = 512 * 1024
		local stat = vim.uv.fs_stat(vim.api.nvim_buf_get_name(ev.buf))
		if stat and stat.size > max_filesize then
			return
		end

		local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
		if not lang then
			return
		end

		if pcall(vim.treesitter.start, ev.buf, lang) then
			vim.bo[ev.buf].indentexpr = "v:lua.vim.treesitter.indentexpr()"
		end
	end,
})

-- Install/update parsers — requires tree-sitter CLI: brew install tree-sitter
if vim.fn.executable("tree-sitter") == 1 then
	vim.schedule(function()
		require("nvim-treesitter.install").install({
			"c", "lua", "vim", "vimdoc", "javascript", "html", "css",
			"typescript", "python", "go", "svelte", "vue", "dart", "json",
			"yaml", "markdown", "bash", "dockerfile", "prisma", "graphql",
			"scss", "tsx",
		})
	end)
end
