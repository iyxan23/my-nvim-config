return {
  "folke/drop.nvim",
  event = "VeryLazy",
  config = function()
    require("drop").setup {
      theme = "stars",
      max = 20,
    }
  end,
}
