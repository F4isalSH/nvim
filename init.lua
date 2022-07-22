return require("packer").startup(function()
	--Plugins
	use({ "wbthomason/packer.nvim" })
	use({ "folke/tokyonight.nvim", config = "vim.cmd[[colorscheme tokyonight]]" })
	use({ "windwp/nvim-autopairs" })
	use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } })
	use({ "akinsho/bufferline.nvim", tag = "v2.*", requires = "kyazdani42/nvim-web-devicons" })
	use({ "kyazdani42/nvim-tree.lua", requires = { "kyazdani42/nvim-web-devicons" }, tag = "nightly" })
	use({ "akinsho/toggleterm.nvim", tag = "v2.*" })
	use({ "lewis6991/gitsigns.nvim" })
	use({ "norcalli/nvim-colorizer.lua" })
	use({ "jose-elias-alvarez/null-ls.nvim" })
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	--Configurations
	vim.opt.termguicolors = true
	vim.wo.number = true
	local formatting = require("null-ls").builtins.formatting
	local sources = {
		formatting.eslint,
		formatting.prettier,
		formatting.stylua,
	}
	require("null-ls").setup({
		sources = sources,
		on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.formatting_sync()
					end,
				})
			end
		end,
	})
	require("bufferline").setup({
		options = {
			offsets = { { filetype = "NvimTree", text = "File Explorer" } },
		},
	})
	require("lualine").setup()
	require("nvim-autopairs").setup()
	require("nvim-tree").setup()
	require("toggleterm").setup({
		open_mapping = [[<c-\>]],
		direction = "float",
	})
	require("gitsigns").setup()
	require("colorizer").setup({
		"css",
		"javascript",
		html = {
			mode = "foreground",
		},
	})
end)
