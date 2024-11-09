return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    sources = { "filesystem" },
    source_selector = {
      sources = {
        { source = "filesystem", display_name = nil },
      },
      winbar = false,
      content_layout = "left",
    },
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {
          "node_modules",
          "dist",
          ".git",
        },
      },
      follow_current_file = {
        enabled = true,
        leave_dirs_open = true,
      },
      group_empty_dirs = true,
      hijack_netrw_behavior = "open_current",
    },
  },
}
