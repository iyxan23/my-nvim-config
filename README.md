# iyxan's nvim config

This config is built on top of [AstroNvim](https://github.com/AstroNvim/AstroNvim),
with the [Lazy package manager](https://github.com/folke/lazy.nvim). I added
and modified a few things to it to make it fit for my own personal use:

- Global mappings

  - Normal Mode
    - `<S-J>` to `O<esc>o`
    - `<S-H>` to `^`
    - `<S-L>` to `$`
    - `<LDR>j` to `:HopLine` with hop.nvim
    - `<LDR>c` to close the current buffer, instead of AstroNvim's `<LDR>bc`
    - `<LDR>bc` to select a buffer to be closed, instead of AstroNvim's `<LDR>bC`
    - `<LDR>bC` to close every buffer except the current, instead of AstroNvim's `<LDR>bd`
    - `<LDR>tf` to create a floating terminal
    - `<LDR>th` to toggle the 1st terminal horizontally
    - `<LDR>tv` to toggle the 1st terminal vertically
    - `<LDR>t2h` to toggle the 2nd terminal horizontally
    - `<LDR>t2v` to toggle the 2nd terminal vertically
    - `<LDR>t3h` to toggle the 3rd terminal horizontally
    - `<LDR>t3v` to toggle the 3rd terminal vertically
    - `<LDR>fo` to use telescope to find and open recent closed files in cwd
    - `<LDR>fi` to use telescope to find and open recent closed files everywhere
    - `<LDR>bt` does "fullscreen" a buffer, essentially just `:tab split` if `winr('$') != 1`
  - Visual Mode
    - `<LDR>j` twin mapping to `<LDR>j` in normal mode
    - `<S-H>` to `^`
    - `<S-L>` to `$`
  - Insert mode
    - Make `<C-e>`, `<C-y>`, `<C-d>`, and `<C-u>` accessible by binding them to `<esc><C-e/y/d/u>a`
    - Movement with `<C-h>`, `<C-j>`, `<C-k>`, and `<C-l>` without going to normal mode

- Make moving between windows in a terminal easier by allowing these mappings:

  - `<esc>` to `[[<C-\><C-n>]]`
  - `<C-h>`, `<C-j>`, `<C-k>`, and `<C-l>` to just work inside of it

- sets `vim.opt.showtabline = 0`, disables tabline by default

- [`nvim-early-retirement`](https://github.com/chrisgrieser/nvim-early-retirement) to automatically close tabs that are unused

- `catpuccin-mocha` as default theme

- `AstroNvim/astrolsp`

  - Disabled inlay hints and autoformat because my laptop literally can't
    handle it

- `ThePrimeagen/harpoon2`

  - Bound `<LDR>k` to `:lua require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())`
  - Bound `<LDR>a` to `:lua require("harpoon"):list():add()`
  - Bound `<LDR>m` to `:Telescope harpoon marks`
  - Bound `<C-p>` to `:lua require("harpoon"):list():prev()`
  - Bound `<C-n>` to `:lua require("harpoon"):list():next()`
  - Bound `<LDR>1` to `:lua require("harpoon").ui.nav_file(1)`
  - ... until `<LDR>5`

- `vyfor/cord.nvim`

  - Optional discord integration

- `goolord/alpha-nvim`

  - My own custom logo
  - And add harpoon rows on it

- `lukas-reineke/virt-column.nvim`

  - Display a simple line on the 80th col

- `xiyaowong/transparent.nvim`

  - `:TransparentEnable`
  - `:TransparentDisable`
  - `:TransparentToggle`

- `folke/drop.nvim`

  - Screensaver-like animation

- `smoka7/hop.nvim`

  - Really quick and easy motion, substitute to `leap.nvim` when I need to
    jump into lines rather than individual words.

- Heirline

  - Time on the bottom right corner for the status line
  - There was a commit where I implemented a way to make harpoon buffers to
    appear pinned, but the implementation is kind of ugly, so I decided to
    leave it out.

- And the following community packages:
  ```lua
  return {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.lua" },
    { import = "astrocommunity.pack.rust" },
    { import = "astrocommunity.pack.typescript" },
    { import = "astrocommunity.pack.json" },
    { import = "astrocommunity.completion.codeium-vim" },
    { import = "astrocommunity.debugging.nvim-bqf" },
    { import = "astrocommunity.motion.nvim-spider" },
    { import = "astrocommunity.motion.portal-nvim" },
    { import = "astrocommunity.motion.leap-nvim" },
    { import = "astrocommunity.colorscheme.catppuccin" },
    { import = "astrocommunity.media.vim-wakatime" },
  }
  ```

> Huge thanks to the entire Neovim community and AstroNvim!
