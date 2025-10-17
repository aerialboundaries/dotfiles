return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({
      sort_by = "name",
      view = { width = 30 },
      renderer = { group_empty = true },
    })
  end,
}

