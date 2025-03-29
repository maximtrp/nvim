local M = {}

function M.insert_package_json(config_files, field, fname)
	local path = vim.fn.fnamemodify(fname, ":h")
	local root_with_package = vim.fs.dirname(vim.fs.find("package.json", { path = path, upward = true })[1])

	if root_with_package then
		local iswin = vim.loop.os_uname().version:match("Windows")
		local path_sep = iswin and "\\" or "/"
		for line in io.lines(root_with_package .. path_sep .. "package.json") do
			if line:find(field) then
				config_files[#config_files + 1] = "package.json"
				break
			end
		end
	end
	return config_files
end

return M
