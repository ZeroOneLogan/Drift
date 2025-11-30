-- Drift colorscheme for Neovim
-- A soothing theme inspired by ocean waves and drifting

local M = {}

M.styles_list = { "dark", "light" }

---Change drift option (vim.g.drift_config.option)
---@param opt string: option name
---@param value any: new value
function M.set_options(opt, value)
  local cfg = vim.g.drift_config
  cfg[opt] = value
  vim.g.drift_config = cfg
end

---Apply the colorscheme (same as ':colorscheme drift')
function M.colorscheme()
  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end
  vim.o.termguicolors = true
  vim.g.colors_name = "drift"
  local cfg = vim.g.drift_config or {}
  if vim.o.background == "light" then
    M.set_options("style", "light")
  elseif cfg.style == "light" then
    M.set_options("style", "light")
  end
  require("drift.highlights").setup()
  require("drift.terminal").setup()
end

---Toggle between drift styles
function M.toggle()
  local index = vim.g.drift_config.toggle_style_index + 1
  if index > #vim.g.drift_config.toggle_style_list then
    index = 1
  end
  M.set_options("style", vim.g.drift_config.toggle_style_list[index])
  M.set_options("toggle_style_index", index)
  if vim.g.drift_config.style == "light" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
  vim.api.nvim_command("colorscheme drift")
end

local default_config = {
  -- Main options --
  style = "dark", -- choose between 'dark' and 'light'
  toggle_style_key = nil,
  toggle_style_list = M.styles_list,
  transparent = false, -- don't set background
  term_colors = true, -- enable terminal colors
  ending_tildes = false, -- show end-of-buffer tildes
  cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

  -- Changing Formats --
  code_style = {
    comments = "italic",
    keywords = "none",
    functions = "none",
    strings = "none",
    variables = "none",
  },

  -- Lualine options --
  lualine = {
    transparent = false, -- center bar (c) transparency
  },

  -- Custom Highlights --
  colors = {}, -- Override default colors
  highlights = {}, -- Override highlight groups

  -- Plugins Related --
  diagnostics = {
    darker = true, -- darker colors for diagnostic
    undercurl = true, -- use undercurl for diagnostics
    background = true, -- use background color for virtual text
  },
}

---Setup drift.nvim options, without applying colorscheme
---@param opts table: a table containing options
function M.setup(opts)
  if not vim.g.drift_config or not vim.g.drift_config.loaded then
    vim.g.drift_config = vim.tbl_deep_extend("keep", vim.g.drift_config or {}, default_config)
    M.set_options("loaded", true)
    M.set_options("toggle_style_index", 0)
  end
  if opts then
    vim.g.drift_config = vim.tbl_deep_extend("force", vim.g.drift_config, opts)
    if opts.toggle_style_list then
      M.set_options("toggle_style_list", opts.toggle_style_list)
    end
  end
  if vim.g.drift_config.toggle_style_key then
    vim.api.nvim_set_keymap(
      "n",
      vim.g.drift_config.toggle_style_key,
      '<cmd>lua require("drift").toggle()<cr>',
      { noremap = true, silent = true }
    )
  end
end

function M.load()
  vim.api.nvim_command("colorscheme drift")
end

return M
