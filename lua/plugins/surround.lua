return {
  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  opts = {
    keymaps = {
      insert = "<C-f>m",
      insert_line = "<C-f>M",
      normal = "ms",
      normal_cur = "mss",
      normal_line = "mS",
      normal_cur_line = "mSS",
      visual = "m",
      visual_line = "gm",
      delete = "dm",
      change = "cm",
      change_line = "cM",
    },
  },
}
