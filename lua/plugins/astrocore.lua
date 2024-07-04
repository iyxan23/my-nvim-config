-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = false, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "auto", -- sets vim.opt.signcolumn to auto
        wrap = false, -- sets vim.opt.wrap
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
        signcolumn = "yes"
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map
        gr = {
          function() require('telescope.builtin').lsp_references({}) end,
          desc = "References of current symbol",
        },

        -- navigate buffer tabs with `H` and `L`
        -- L = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        -- H = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        -- ["<Leader>bD"] = {
        --   function()
        --     require("astroui.status.heirline").buffer_picker(
        --       function(bufnr) require("astrocore.buffer").close(bufnr) end
        --     )
        --   end,
        --   desc = "Pick to close",
        -- },
        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },
        -- quick save
        -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
        --
          -- replaced by the awesome leap.nvim plugin
        -- ["<Leader><Leader>w"] = {
        --   function() vim.cmd.HopWord() end,
        --   desc = "Hop Words",
        -- },
        ["<Leader><Leader>k"] = {
          function() vim.cmd.HopLine() end,
          desc = "Hop Lines",
        },
        ["<Leader><Leader>j"] = {
          function() vim.cmd.HopLine() end,
          desc = "Hop Lines",
        },

        ["<Leader>c"] = {
          function()
            local bufs = vim.fn.getbufinfo { buflisted = true }
            require("astrocore.buffer").close(vim.api.nvim_get_current_buf())
            if require("astrocore").is_available "alpha-nvim" and not bufs[2] then require("alpha").start(true) end
          end,
          desc = "Close buffer",
        },
        ["<Leader>bc"] = {
          function()
            require("astroui.status.heirline").buffer_picker(function(bufnr)
              local bufs = vim.fn.getbufinfo { buflisted = true }
              require("astrocore.buffer").close(bufnr)
              if require("astrocore").is_available "alpha-nvim" and not bufs[2] then require("alpha").start(true) end
            end)
          end,
          desc = "Close buffer from tabline",
        },
        ["<Leader>bC"] = {
          function() require("astrocore.buffer").close_all(true) end,
          desc = "Close all buffers except current",
        },
        ["<Leader>bd"] = {},

        ["<Leader>tf"] = {
          "<cmd>ToggleTerm 1 direction=float name=first<cr>",
          desc = "ToggleTerm first terminal float",
        },
        ["<Leader>th"] = {
          "<cmd>ToggleTerm 1 size=10 direction=horizontal name=first<cr>",
          desc = "ToggleTerm first terminal horizontal split",
        },
        ["<Leader>tv"] = {
          "<cmd>ToggleTerm 1 size=80 direction=vertical name=first<cr>",
          desc = "ToggleTerm first terminal vertical split",
        },

        ["<Leader>t2f"] = {
          "<cmd>ToggleTerm 2 direction=float name=second<cr>",
          desc = "ToggleTerm second terminal float",
        },
        ["<Leader>t2h"] = {
          "<cmd>ToggleTerm 2 size=10 direction=horizontal name=second<cr>",
          desc = "ToggleTerm second terminal horizontal split",
        },
        ["<Leader>t2v"] = {
          "<cmd>ToggleTerm 2 size=80 direction=vertical name=second<cr>",
          desc = "ToggleTerm second terminal vertical split",
        },

        ["<Leader>t3f"] = {
          "<cmd>ToggleTerm 3 direction=float name=third<cr>",
          desc = "ToggleTerm third terminal float",
        },
        ["<Leader>t3h"] = {
          "<cmd>ToggleTerm 3 size=10 direction=horizontal name=third<cr>",
          desc = "ToggleTerm third terminal horizontal split",
        },
        ["<Leader>t3v"] = {
          "<cmd>ToggleTerm 3 size=80 direction=vertical name=third<cr>",
          desc = "ToggleTerm third terminal vertical split",
        },

        ["<Leader>fo"] = {
          function() require("telescope.builtin").oldfiles { cwd_only = true } end,
          desc = "Find history (cwd only)",
        },
        ["<Leader>fi"] = {
          function() require("telescope.builtin").oldfiles() end,
          desc = "Find history (everywhere)",
        },

        ["<Leader>bt"] = {
          "<cmd>if winnr('$') != 1 <Bar> tab split <Bar> endif<CR>",
          desc = "Something like a fullscreen mode"
        }
      },
      t = {
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
      },
      v = {
        -- ["<Leader><Leader>w"] = {
        --   function() require('hop').hint_words { extend_visual = true } end,
        --   desc = "Hop Words",
        -- },
        ["<Leader><Leader>k"] = {
          function() require('hop').hint_lines { extend_visual = true } end,
          desc = "Hop Lines",
        },
        ["<Leader><Leader>j"] = {
          function() require('hop').hint_lines { extend_visual = true } end,
          desc = "Hop Lines",
        },
      },
      i = {
        ["<C-e>"] = { "<esc><C-e>a", desc = "Go down one line" },
        ["<C-y>"] = { "<esc><C-y>a", desc = "Go up one line" },
        ["<C-d>"] = { "<esc><C-d>a", desc = "Go down half a screen" },
        ["<C-u>"] = { "<esc><C-u>a", desc = "Go up half a screen" },
      }
    },
  },
}
