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
	use({
		"williamboman/nvim-lsp-installer",
		"neovim/nvim-lspconfig",
	})
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-vsnip")
	use("hrsh7th/vim-vsnip")
	use("rafamadriz/friendly-snippets")

	--Configurations
	vim.opt.termguicolors = true
	vim.wo.number = true
	local formatting = require("null-ls").builtins.formatting
	local sources = {
		formatting.prettier,
		formatting.eslint,
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
						vim.lsp.buf.formatting()
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

	local cmp = require("cmp")
	cmp.setup({
		snippet = {
			expand = function(args)
				vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			end,
		},
		window = {},

		mapping = cmp.mapping.preset.insert({
			["<C-k>"] = cmp.mapping.select_prev_item(),
			["<C-j>"] = cmp.mapping.select_next_item(),
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
			["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		}),
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "vsnip" }, -- For vsnip users.
		}, {
			{ name = "buffer" },
		}),
	})
	require("nvim-lsp-installer").setup({
		automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
		ui = {
			icons = {
				server_installed = "✓",
				server_pending = "➜",
				server_uninstalled = "✗",
			},
		},
	})

	-- Mapping
	function map(mode, lhs, rhs, opts)
		local options = { noremap = true }
		if opts then
			options = vim.tbl_extend("force", options, opts)
		end
		vim.api.nvim_set_keymap(mode, lhs, rhs, options)
	end
	map("n", "<Space>e", ":NvimTreeToggle<CR>", { silent = true })
	map("n", "<Space>f", ":Telescope find_files<CR>", { silent = true })
	map("i", "jj", "<esc>")
	map("n", "<Space>q", ":q<CR>", { silent = true })
	map("n", "<Space>Q", ":q!<CR>", { silent = true })
	map("n", "<Space>w", ":w<CR>", { silent = true })
	map("n", "<Space>W", ":wq<CR>", { silent = true })
	map("n", "<S-h>", ":bp<CR>", { silent = true })
	map("n", "<S-l>", ":bn<CR>", { silent = true })
	map("n", "<Space>k", ":bd<CR>", { silent = true })
	map("n", "<c-h>", "<c-w>h")
	map("n", "<c-l>", "<c-w>l")
end)
