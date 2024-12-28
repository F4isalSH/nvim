return {
  -- Configuration for flutter-tools
  {
    "akinsho/flutter-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    config = function()
      require("flutter-tools").setup({})
    end,
  },
  -- Telescope configuration
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }, -- Ensure Plenary is listed as a dependency
    config = function()
      require("telescope").setup({})
      -- Load the Flutter extension
      require("telescope").load_extension("flutter")
    end,
  },
}
