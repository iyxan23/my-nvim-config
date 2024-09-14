return {
  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  opts = {
    keymaps = {
      insert = "<C-g>m",
      insert_line = "<C-g>M",
      normal = "ms",
      normal_cur = "mss",
      normal_line = "mS",
      normal_cur_line = "mSS",
      visual = "M",
      visual_line = "gM",
      delete = "dm",
      change = "cm",
      change_line = "cM",
    },
  },
}
