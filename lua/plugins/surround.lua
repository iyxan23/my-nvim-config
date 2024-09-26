return {
  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  opts = {
    keymaps = {
      insert = "<C-f>,",
      insert_line = false,
      normal = ",",
      normal_cur = false,
      normal_line = false,
      normal_cur_line = false,
      visual = ",",
      visual_line = false,
      delete = "d,",
      change = "c,",
      change_line = false,
    },
  },
}
