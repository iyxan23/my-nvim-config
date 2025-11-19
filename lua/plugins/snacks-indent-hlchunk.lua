-- credits: https://github.com/AstroNvim/astrocommunity/blob/df6d31cf0db216b85513bd571f37832e6824d9c4/lua/astrocommunity/indent/snacks-indent-hlchunk/init.lua#L2
return {
  "folke/snacks.nvim",
  opts = {
    indent = {
      enabled = true,
      animate = {
        enabled = true,
        easing = "inOutQuad"
      },
      scope = {
        enabled = true,
      },
      chunk = {
        enabled = true,
        char = {
          corner_top = "┌",
          corner_bottom = "└",
          horizontal = "",
          vertical = "│",
          arrow = "",
        },
      },
    },
  },
}
