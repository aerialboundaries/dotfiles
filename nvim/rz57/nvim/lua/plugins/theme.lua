return {
  -- 🌞 Solarized テーマ
  {
    "maxmx03/solarized.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      theme = "dark",
      transparent = { enabled = false },  -- ✅ 修正
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = { bold = true },
      },
    },
    config = function(_, opts)
      require("solarized").setup(opts)
      vim.cmd("colorscheme solarized")
    end,
  },

  -- 🌿 Gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("gruvbox").setup({ contrast = "soft" })
      vim.cmd("colorscheme gruvbox")
    end,
  },
}

