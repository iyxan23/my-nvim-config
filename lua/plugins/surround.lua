return {
  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  opts = {
    keymaps = {
      insert = "<C-f>,",
      -- insert_line = "<C-f>,",
      normal = ",",
      -- normal_cur = "mss",
      -- normal_line = "mS",
      -- normal_cur_line = "mSS",
      visual = ",",
      -- visual_line = "g,",
      delete = "d,",
      change = "c,",
      -- change_line = "cM",
    },
  },
}
