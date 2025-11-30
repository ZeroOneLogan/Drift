# Drift

A soothing dark colorscheme for Neovim, inspired by ocean waves and drifting.

![Neovim](https://img.shields.io/badge/Neovim-0.8%2B-blue?logo=neovim&logoColor=green)

## Features

- 🌊 Ocean-inspired color palette with soothing tones
- 🌗 Dark and light variants
- 🌳 Full Treesitter support
- 🔧 LSP semantic highlighting support
- 📦 Support for popular plugins (telescope, nvim-tree, gitsigns, etc.)
- ⚡ Written in Lua for fast loading
- 🎨 Lualine theme included

## Requirements

- Neovim >= 0.8.0
- `termguicolors` enabled

## Installation

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "ZeroOneLogan/Drift",
  lazy = false,
  priority = 1000,
  config = function()
    require("drift").setup()
    vim.cmd.colorscheme("drift")
  end,
}
```

### [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  "ZeroOneLogan/Drift",
  config = function()
    require("drift").setup()
    vim.cmd.colorscheme("drift")
  end,
}
```

### [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'ZeroOneLogan/Drift'

" In your init.vim, after plug#end()
lua require('drift').setup()
colorscheme drift
```

## Configuration

Drift comes with sensible defaults, but you can customize it to your liking:

```lua
require("drift").setup({
  -- Main options
  style = "dark", -- "dark" or "light"
  transparent = false, -- Enable transparent background
  term_colors = true, -- Enable terminal colors
  ending_tildes = false, -- Show end-of-buffer tildes

  -- Code style options
  code_style = {
    comments = "italic",
    keywords = "none",
    functions = "none",
    strings = "none",
    variables = "none",
  },

  -- Lualine options
  lualine = {
    transparent = false, -- Lualine center bar transparency
  },

  -- Custom highlights
  colors = {}, -- Override default colors
  highlights = {}, -- Override highlight groups

  -- Diagnostics options
  diagnostics = {
    darker = true, -- Darker diagnostic colors
    undercurl = true, -- Use undercurl for diagnostics
    background = true, -- Background for virtual text
  },

  -- Toggle style
  toggle_style_key = nil, -- Keybind to toggle between styles
  toggle_style_list = { "dark", "light" }, -- List of styles to toggle through
})
```

## Lualine

Drift includes a matching lualine theme:

```lua
require("lualine").setup({
  options = {
    theme = "drift",
  },
})
```

## Supported Plugins

- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [blink.cmp](https://github.com/Saghen/blink.cmp)
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)
- [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- [vim-gitgutter](https://github.com/airblade/vim-gitgutter)
- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
- [dashboard-nvim](https://github.com/nvimdev/dashboard-nvim)
- [which-key.nvim](https://github.com/folke/which-key.nvim)
- [mini.nvim](https://github.com/echasnovski/mini.nvim)
- [vim-illuminate](https://github.com/RRethy/vim-illuminate)
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)

## License

MIT