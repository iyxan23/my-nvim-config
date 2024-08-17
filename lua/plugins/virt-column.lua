return {
  "lukas-reineke/virt-column.nvim",
  event = "BufRead",
  config = function()
    vim.cmd("set colorcolumn=80")
    require('virt-column').setup()
  end
}
