require("config.settings")
require("config.colorscheme")

vim.pack.add({
	-- LSP
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/creativenull/efmls-configs-nvim" },
	-- Completion
	{ src = "https://github.com/hrsh7th/nvim-cmp" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/saadparwaiz1/cmp_luasnip" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
	{ src = "https://github.com/hrsh7th/cmp-buffer" },
	{ src = "https://github.com/hrsh7th/cmp-path" },
	{ src = "https://github.com/hrsh7th/cmp-cmdline" },
	-- Treesitter
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
	-- Telescope
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-lua/popup.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-file-browser.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-media-files.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
	-- Neo-tree
	{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	-- UI
	{ src = "https://github.com/folke/noice.nvim" },
	{ src = "https://github.com/rebelot/heirline.nvim" },
	-- Git
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/kdheepak/lazygit.nvim" },
	-- Editor
	{ src = "https://github.com/numToStr/Comment.nvim" },
	{ src = "https://github.com/folke/trouble.nvim" },
	{ src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
	{ src = "https://github.com/AckslD/nvim-neoclip.lua" },
	{ src = "https://github.com/hedyhli/outline.nvim" },
	{ src = "https://github.com/luukvbaal/statuscol.nvim" },
	-- Misc
	{ src = "https://github.com/olrtg/nvim-emmet" },
	{ src = "https://github.com/vuki656/package-info.nvim" },
})

vim.loader.enable()

require("config.format")
require("config.keymaps")
require("config.lsps")
require("config.other")
