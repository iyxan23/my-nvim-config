return {
  "jay-babu/mason-nvim-dap.nvim",
  opts = {
    handlers = {
      delve = function()
        local dap = require "dap"

        dap.adapters.delve = {
          type = "server",
          port = "${port}",
          executable = {
            command = vim.fn.exepath "dlv",
            args = { "dap", "-l", "127.0.0.1:${port}" },
          },
        }

        -- configure delve dap (golang's dap) to specify build flags, which are
        -- the build tags that I specifically use
        dap.configurations.go = {
          {
            type = "delve",
            name = "Delve: Debug",
            request = "launch",
            program = "${workspaceFolder}",
          },
          {
            type = "delve",
            name = "Delve: Debug test with tags",
            request = "launch",
            mode = "test",
            program = "${file}",
            buildFlags = { "-tags=test,integration" },
          },
          {
            type = "delve",
            name = "Delve: Debug test (go.mod) with tags",
            request = "launch",
            mode = "test",
            program = "./${relativeFileDirname}",
            buildFlags = { "-tags=test,integration" },
          },
        }
      end,
    },
  },
}
