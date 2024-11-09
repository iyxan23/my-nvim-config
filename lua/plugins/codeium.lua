return {
  "Exafunction/codeium.vim",
  event = "BufEnter",
  config = function() vim.g.codeium_disable_bindings = true end,
}
