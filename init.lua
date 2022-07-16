local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'folke/tokyonight.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'akinsho/bufferline.nvim'
Plug ('akinsho/toggleterm.nvim', {tag = 'v2.*'})
Plug ('glepnir/dashboard-nvim')
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug ('neoclide/coc.nvim', {branch= 'release'})
Plug 'windwp/nvim-autopairs'
Plug 'lewis6991/gitsigns.nvim'
Plug 'mlaursen/vim-react-snippets'

vim.call('plug#end')

-- Setups.
 require('gitsigns').setup{
    signcolumn = auto,
    on_attach = function()
    vim.wo.signcolumn = "yes"
    end
    }

require("nvim-autopairs").setup{}
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

vim.opt.termguicolors = true
require("bufferline").setup{
options={
    offsets = {{filetype = "NvimTree", text = "File Explorer"}} 
}
}
vim.cmd[[colorscheme tokyonight]]
require("toggleterm").setup{
open_mapping = [[<Leader>]],
terminal_mappings = true,
  direction = 'float'
}

local db = require('dashboard')
  db.preview_file_height = 12
  db.preview_file_width = 80
  db.custom_center = {
      {icon = '  ',
      desc = 'Find  File                              ',
      action = 'Telescope find_files find_command=rg,--hidden,--files',
      shortcut = 'SPC f f'},
    }

    require("null-ls").setup({
    sources = {
        require("null-ls").builtins.formatting.prettier,
        require("null-ls").builtins.diagnostics.eslint,
        require("null-ls").builtins.completion.spell,
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    vim.lsp.buf.formatting_sync()
                end,
            })
        end
    end,

})



-- Mapping
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
map("n", "<Space>e", ":NvimTreeToggle<CR>", {silent = true})
map("n", "<Space>f", ":Telescope find_files<CR>", {silent = true})
map("i", "jj","<esc>")
map("n","<Space>q",":q<CR>",{silent = true})
map("n","<Space>Q",":q!<CR>",{silent = true})
map("n","<Space>w",":w<CR>",{silent = true})
map("n","<Space>W",":wq<CR>",{silent = true})
map("n","<S-h>",":bp<CR>",{silent = true})
map("n","<S-l>",":bn<CR>",{silent = true})
map("n","<Space>k",":bd<CR>",{silent = true})
map("n","<c-h>","<c-w>h")
map("n","<c-l>","<c-w>l")
-- Options
vim.wo.number = true
vim.cmd("source $HOME/.config/nvim/coc_config.vim")
