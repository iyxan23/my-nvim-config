-- Mason tool installer configuration for AstroNvim v5
-- This replaces the previous mason-lspconfig, mason-null-ls, and mason-nvim-dap configurations

return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  opts = {
    ensure_installed = {
      -- LSP servers (converted from lua_ls to lua-language-server format)
      "lua-language-server",
      "gopls",
      "rust-analyzer",

      -- Formatters/Linters (from mason-null-ls)
      "prettierd",
      "stylua",

      -- DAP configurations (from mason-nvim-dap)
      "delve", -- for Go debugging
    },

    -- Additional mason-tool-installer options
    auto_update = false,
    run_on_start = true,
    start_delay = 3000, -- 3 second delay
    debounce_hours = 24, -- at most check for outdated packages once a day
  },
}
