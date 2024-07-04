return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astroui.status"

    opts.statusline = { -- statusline
      hl = { fg = "fg", bg = "bg" },
      status.component.mode { mode_text = { padding = { left = 1, right = 1 } } },
      status.component.git_branch(),
      status.component.file_info(),
      status.component.git_diff(),
      status.component.diagnostics(),
      status.component.fill(),
      status.component.cmd_info(),
      status.component.fill(),
      status.component.lsp(),
      status.component.virtual_env(),
      status.component.treesitter(),
      status.component.nav(),
      -- Create a custom component to display the time
      status.component.builder {
        {
          provider = function()
            local time = os.date "%H:%M" -- show hour and minute in 24 hour format
            ---@cast time string
            return status.utils.stylize(time, {
              padding = { right = 1, left = 1 }, -- pad the right side so it's not cramped
            })
          end,
        },
        update = { -- update should happen when the mode has changed as well as when the time has changed
          "User", -- We can use the User autocmd event space to tell the component when to update
          "ModeChanged",
          callback = vim.schedule_wrap(function(_, args)
            if -- update on user UpdateTime event and mode change
              (args.event == "User" and args.match == "UpdateTime")
              or (args.event == "ModeChanged" and args.match:match ".*:.*")
            then
              vim.cmd.redrawstatus() -- redraw on update
            end
          end),
        },
        hl = status.hl.get_attributes "mode", -- highlight based on mode attributes
        surround = { separator = "right", color = status.hl.mode_bg }, -- background highlight based on mode
      },
    }

    local path_func = status.provider.filename { modify = ":.:h", fallback = "" }

    opts.winbar = { -- create custom winbar
      -- store the current buffer number
      init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
      fallthrough = false, -- pick the correct winbar based on condition
      -- inactive winbar
      {
        condition = function() return not status.condition.is_active() end,
        -- show the path to the file relative to the working directory
        status.component.separated_path { path_func = path_func },
        -- add the file name and icon
        status.component.file_info {
          file_icon = { hl = status.hl.file_icon "winbar", padding = { left = 0 } },
          filename = {},
          filetype = false,
          file_modified = false,
          file_read_only = false,
          hl = status.hl.get_attributes("winbarnc", true),
          surround = false,
          update = "BufEnter",
        },
      },
      -- active winbar
      {
        -- show the path to the file relative to the working directory
        status.component.separated_path { path_func = path_func },
        -- add the file name and icon
        status.component.file_info { -- add file_info to breadcrumbs
          file_icon = { hl = status.hl.filetype_color, padding = { left = 0 } },
          filename = {},
          filetype = false,
          file_modified = false,
          file_read_only = false,
          hl = status.hl.get_attributes("winbar", true),
          surround = false,
          update = "BufEnter",
        },
        -- show the breadcrumbs
        status.component.breadcrumbs {
          icon = { hl = true },
          hl = status.hl.get_attributes("winbar", true),
          prefix = true,
          padding = { left = 0 },
        },
      },
    }

    local buf_utils = require "astrocore.buffer"
    local get_icon = require("astroui").get_icon

    local harpoon_listName = nil
    local harpoon = require "harpoon"

    local augroup = vim.api.nvim_create_augroup("Iyxan", {})

    harpoon:extend { ADD = function() vim.cmd.redrawtabline() end }
    harpoon:extend { REMOVE = function() vim.cmd.redrawtabline() end }
    harpoon:extend { REPLACE = function() vim.cmd.redrawtabline() end }

    vim.api.nvim_create_autocmd("User", {
      group = augroup,
      pattern = "HarpoonSwitchedList",
      callback = function(event)
        harpoon_listName = event.data
        vim.cmd.redrawtabline()
      end,
    })

    opts.tabline = { -- bufferline
      { -- automatic sidebar padding
        condition = function(self)
          self.winid = vim.api.nvim_tabpage_list_wins(0)[1]
          self.winwidth = vim.api.nvim_win_get_width(self.winid)
          return self.winwidth ~= vim.o.columns -- only apply to sidebars
            and not require("astrocore.buffer").is_valid(vim.api.nvim_win_get_buf(self.winid)) -- if buffer is not in tabline
        end,
        provider = function(self) return (" "):rep(self.winwidth + 1) end,
        hl = { bg = "tabline_bg" },
      },
      -- status.heirline.make_buflist(status.component.tabline_file_info()), -- component for each buffer tab

      -- Copied from astroui
      (function(component)
        local overflow_hl = status.hl.get_attributes("buffer_overflow", true)
        return require("heirline.utils").make_buflist(
          status.utils.surround(
            "tab",
            function(self)
              return {
                main = status.heirline.tab_type(self) .. "_bg",
                left = "tabline_bg",
                right = "tabline_bg",
              }
            end,
            { -- bufferlist
              init = function(self) self.tab_type = status.heirline.tab_type(self) end,
              on_click = { -- add clickable component to each buffer
                callback = function(_, minwid) vim.api.nvim_win_set_buf(0, minwid) end,
                minwid = function(self) return self.bufnr end,
                name = "heirline_tabline_buffer_callback",
              },
              {
                condition = function(self)
                  local path = vim.fn.expand("#" .. self.bufnr .. ":p:.")
                  local harpoons = require("harpoon"):list(harpoon_listName)
                  for k, v in ipairs(harpoons.items) do
                    if v.value == path then
                      self.harpoon_idx = k
                      return true
                    end
                  end
                end,
                provider = function(self)
                  return status.provider.str {
                    str = tostring(self.harpoon_idx),
                    padding = { left = 1, right = 0 },
                  }
                end,
                hl = status.hl.get_attributes "buffer_visible",
              },
              { -- add buffer picker functionality to each buffer
                condition = function(self) return self._show_picker end,
                update = false,
                init = function(self)
                  if not vim.tbl_get(self._picker_labels, self.label) then
                    local bufname = status.provider.filename()(self)
                    local label = bufname:sub(1, 1)
                    local i = 2
                    while label ~= " " and self._picker_labels[label] do
                      if i > #bufname then break end
                      label = bufname:sub(i, i)
                      i = i + 1
                    end
                    self._picker_labels[label] = self.bufnr
                    self.label = label
                  end
                end,
                provider = function(self)
                  return status.provider.str { str = self.label, padding = { left = 1, right = 1 } }
                end,
                hl = status.hl.get_attributes "buffer_picker",
              },
              component, -- create buffer component
            },
            function(self) return buf_utils.is_valid(self.bufnr) end -- disable surrounding
          ),
          { provider = get_icon "ArrowLeft" .. " ", hl = overflow_hl },
          { provider = get_icon "ArrowRight" .. " ", hl = overflow_hl },
          function()
            vim.t.bufs = vim.tbl_filter(buf_utils.is_valid, vim.t.bufs or {})
            return vim.t.bufs
          end, -- use astronvim bufs variable
          false -- disable internal caching
        )
      end)(status.component.tabline_file_info()),

      status.component.fill { hl = { bg = "tabline_bg" } }, -- fill the rest of the tabline with background color
      { -- tab list
        condition = function() return #vim.api.nvim_list_tabpages() >= 2 end, -- only show tabs if there are more than one
        status.heirline.make_tablist { -- component for each tab
          provider = status.provider.tabnr(),
          hl = function(self) return status.hl.get_attributes(status.heirline.tab_type(self, "tab"), true) end,
        },
        { -- close button for current tab
          provider = status.provider.close_button { kind = "TabClose", padding = { left = 1, right = 1 } },
          hl = status.hl.get_attributes("tab_close", true),
          on_click = {
            callback = function() require("astrocore.buffer").close_tab() end,
            name = "heirline_tabline_close_tab_callback",
          },
        },
      },
    }

    -- Now that we have the component, we need a timer to emit the User UpdateTime event
    vim.uv.new_timer():start( -- timer for updating the time
      (60 - tonumber(os.date "%S")) * 1000, -- offset timer based on current seconds past the minute
      60000, -- update every 60 seconds
      vim.schedule_wrap(function()
        vim.api.nvim_exec_autocmds( -- emit our new User event
          "User",
          { pattern = "UpdateTime", modeline = false }
        )
      end)
    )
  end,
}
