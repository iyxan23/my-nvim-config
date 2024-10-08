if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  "supermaven-inc/supermaven-nvim",
  event = "VeryLazy",
  opts = {
    keymaps = {
      accept_suggestion = "<C-g>",
      clear_suggestion = "<C-\\>",
      accept_word = "<C-x>",
    },
    log_level = "warn",
    disable_inline_completion = false, -- disables inline completion for use with cmp
    disable_keymaps = false, -- disables built in keymaps for more manual control
  },
}
