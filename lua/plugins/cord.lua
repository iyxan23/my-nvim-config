-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
return {
  "vyfor/cord.nvim",
  build = "./build",
  event = "VeryLazy",
  opts = {
    editor = {
      client = "astronvim",
      tooltip = "Better than VSCode",
    },
    buttons = {
      { label = "My Github", url = "https://github.com/iyxan23" },
    },
  },
}
