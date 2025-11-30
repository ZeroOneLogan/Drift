# 🌊 Drift

> A **unique**, **beautiful**, and **meticulously crafted** Neovim colorscheme with **6 stunning variants** designed to elevate your coding experience.

Drift isn't just another colorscheme—it's a visual language that adapts to your mood and workflow. From the deep, contemplative tones of **Night** to the ethereal glow of **Nebula**, each variant is carefully designed with semantic coloring, optimal contrast ratios, and a cohesive aesthetic that makes code not just readable, but *beautiful*.

## ✨ Features

- **6 Unique Variants**: Night, Storm, Aurora, Moon, Day (light), and Nebula
- **Semantic Highlighting**: Colors that *mean* something—errors are red, warnings amber, success green
- **Full Treesitter Support**: 100+ modern `@` captures for accurate syntax highlighting
- **LSP Semantic Tokens**: Complete integration with LSP for intelligent highlighting
- **40+ Plugin Integrations**: Native support for your favorite plugins
- **Fully Customizable**: Override any color or highlight group
- **Terminal Colors**: Beautiful 16-color terminal palette
- **Lualine Theme**: Matching statusline theme included

## 🎨 Variants

### Night (Default)
*Deep, focused, contemplative*

The flagship variant. A carefully balanced dark theme with warm accents that reduces eye strain during long coding sessions while maintaining excellent readability.

### Storm
*Electric, intense, dramatic*

Higher contrast than Night with cooler tones. Perfect for those who prefer a more striking visual experience.

### Aurora
*Mystical, dreamy, unique*

Inspired by the Northern Lights. Features distinctive purple and teal undertones that create an otherworldly atmosphere.

### Moon
*Soft, gentle, refined*

A softer dark variant with muted tones. Ideal for those who find typical dark themes too harsh.

### Day (Light)
*Clean, bright, professional*

A carefully crafted light theme that proves light themes can be beautiful. Features warm undertones instead of the harsh blue-whites of typical light themes.

### Nebula
*Cosmic, vibrant, expressive*

The boldest variant. Deep space blacks with vivid accent colors. For those who want their editor to feel like a window into the cosmos.

## 📦 Installation

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "your-username/drift.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    -- your configuration here
  },
  config = function(_, opts)
    require("drift").setup(opts)
    vim.cmd.colorscheme("drift")
  end,
}
```

### [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  "your-username/drift.nvim",
  config = function()
    require("drift").setup({
      -- your configuration here
    })
    vim.cmd.colorscheme("drift")
  end,
}
```

### Manual

Clone the repository to your Neovim packages directory:

```bash
git clone https://github.com/your-username/drift.nvim \
  ~/.local/share/nvim/site/pack/plugins/start/drift.nvim
```

## ⚙️ Configuration

Drift works out of the box with sensible defaults, but every aspect can be customized:

```lua
require("drift").setup({
  -- Choose your variant: "night", "storm", "aurora", "moon", "day", "nebula"
  style = "night",

  -- Transparent background
  transparent = false,

  -- Show "~" characters at end of buffer
  ending_tildes = false,

  -- Code styling options
  code_style = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    strings = {},
    variables = {},
    types = {},
  },

  -- Diagnostic options
  diagnostics = {
    undercurl = true,    -- Use undercurl for diagnostics
    background = true,   -- Show background for virtual text
  },

  -- Override palette colors
  colors = {
    -- Example: make the background even darker
    -- bg0 = "#0a0c0f",
  },

  -- Override specific highlight groups
  highlights = {
    -- Example: make comments stand out more
    -- Comment = { fg = "#7f8c8d", italic = true },
  },
})

-- Load the colorscheme
vim.cmd.colorscheme("drift")
```

## 🔄 Switching Variants

### Via Configuration

```lua
require("drift").setup({ style = "aurora" })
vim.cmd.colorscheme("drift")
```

### Programmatically

```lua
-- Switch to a specific variant
require("drift").colorscheme("storm")

-- Toggle through variants
require("drift").toggle()

-- Toggle in reverse order
require("drift").toggle(true)
```

### Create a Keymap

```lua
vim.keymap.set("n", "<leader>ts", function()
  require("drift").toggle()
end, { desc = "Toggle Drift style" })
```

## 🔌 Supported Plugins

Drift includes carefully crafted highlight groups for:

| Category | Plugins |
|----------|---------|
| **Completion** | nvim-cmp, blink.cmp |
| **File Explorer** | neo-tree, nvim-tree, oil.nvim |
| **Fuzzy Finder** | telescope.nvim, mini.pick |
| **Git** | gitsigns.nvim, neogit, diffview.nvim, vim-gitgutter, octo.nvim |
| **UI** | noice.nvim, nvim-notify, dashboard-nvim, alpha-nvim, bufferline.nvim |
| **Navigation** | flash.nvim, harpoon |
| **LSP** | lspsaga.nvim, trouble.nvim, fidget.nvim, nvim-navic, aerial.nvim |
| **Testing** | neotest |
| **Debug** | nvim-dap, nvim-dap-ui |
| **Package Manager** | lazy.nvim, mason.nvim |
| **Utilities** | which-key.nvim, indent-blankline.nvim, mini.nvim (all modules), illuminate.vim, rainbow-delimiters.nvim |
| **Statusline** | lualine.nvim, mini.statusline |
| **AI** | copilot.lua |
| **Snacks** | snacks.nvim (all modules) |

## 📊 Lualine Integration

Drift includes a matching lualine theme:

```lua
require("lualine").setup({
  options = {
    theme = "drift",
  },
})
```

## 🎨 Color Palette

Each variant includes a carefully designed palette with semantic meaning:

| Color | Purpose |
|-------|---------|
| `rose` | Variables, parameters, soft accents |
| `coral` | Numbers, constants, literals |
| `amber` | Types, warnings, search highlights |
| `gold` | Special highlights, bright accents |
| `sage` | Strings, success, git additions |
| `mint` | Special characters, escape sequences |
| `cyan` | Properties, operators |
| `azure` | Functions, links, info |
| `iris` | Keywords modifier, preprocessor |
| `lavender` | Modules, namespaces |
| `mauve` | Keywords, control flow, errors |
| `blossom` | Special, decorative elements |

## 🛠️ API

### Functions

```lua
local drift = require("drift")

-- Setup with options
drift.setup(opts)

-- Apply colorscheme with optional style
drift.colorscheme(style?)

-- Toggle between styles
drift.toggle(reverse?)

-- Get current style name
drift.get_style()

-- Get palette colors for external use
drift.get_colors(style?)
```

### Get Colors for Plugins

```lua
local colors = require("drift").get_colors()

-- Use colors in your configuration
print(colors.azure)  -- "#61afef"
print(colors.sage)   -- "#98c379"
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### Development

1. Clone the repository
2. Link it to your Neovim packages
3. Make your changes
4. Test with `:colorscheme drift`

## 📜 License

MIT License - see [LICENSE](LICENSE) for details.

## 💖 Acknowledgments

Drift draws inspiration from many beautiful colorschemes while striving to create something unique:

- [Tokyo Night](https://github.com/folke/tokyonight.nvim) for its attention to detail
- [Catppuccin](https://github.com/catppuccin/nvim) for its variant system
- [Rose Pine](https://github.com/rose-pine/neovim) for its romantic aesthetic
- [Gruvbox](https://github.com/morhetz/gruvbox) for proving warm colors work

---

<p align="center">
  Made with 💙 for Neovim
</p>
