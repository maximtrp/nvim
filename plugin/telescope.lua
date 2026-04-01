-- Build telescope-fzf-native if missing (first install) or after update
local fzf_plugin_path = vim.fn.stdpath("data") .. "/site/pack/core/opt/telescope-fzf-native.nvim"
local fzf_lib = fzf_plugin_path .. "/build/libfzf.so"
if vim.fn.filereadable(fzf_lib) == 0 and vim.fn.executable("make") == 1 then
  vim.fn.system({ "make", "-C", fzf_plugin_path })
end

vim.api.nvim_create_autocmd("User", {
  pattern = "PackChanged",
  callback = function(ev)
    if ev.data and ev.data.name == "telescope-fzf-native.nvim" and vim.fn.executable("make") == 1 then
      vim.fn.system({ "make", "-C", ev.data.path })
    end
  end,
})

local actions = require("telescope.actions")

require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<ESC>"] = actions.close,
      },
      n = {
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<ESC>"] = actions.close,
      },
    },
    sorting_strategy = "ascending",
    layout_strategy = "vertical",
    layout_config = {
      horizontal = {
        size = {
          width = "90%",
          height = "80%",
        },
      },
      vertical = {
        prompt_position = "top",
        size = {
          width = "90%",
          height = "90%",
        },
      },
    },
    path_display = { "truncate" },
  },
  media_files = {
    filetypes = { "png", "webp", "jpg", "jpeg" },
    find_cmd = "rg",
  },
  pickers = {
    find_files = {
      find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
    },
  },
})

require("telescope").load_extension("media_files")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("ui-select")
if vim.fn.filereadable(fzf_lib) == 1 then
  require("telescope").load_extension("fzf")
end
