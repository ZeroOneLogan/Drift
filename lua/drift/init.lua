-- =============================================================================
-- DRIFT COLORSCHEME
-- A unique, beautiful Neovim colorscheme with 7 stunning variants
-- =============================================================================

local M = {}

-- Available style variants
M.styles_list = { "night", "storm", "aurora", "moon", "moonlight", "day", "nebula" }

-- Default configuration
local default_config = {
  -- The base style: "night", "storm", "aurora", "moon", "moonlight", "day", "nebula"
  style = "night",

  -- Show "~" at end of buffer (default: false)
  ending_tildes = false,

  -- Transparent background (default: false)
  transparent = false,

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
    -- Use undercurl for diagnostic underlines (default: true)
    undercurl = true,
    -- Show background for virtual text (default: true)
    background = true,
  },

  -- Custom color overrides (merged into palette)
  colors = {},

  -- Custom highlight overrides (applied after all highlights)
  highlights = {},
}

-- Store the currently active style
M.current_style = nil

-- Initialize options
function M.set_options(opts)
  opts = opts or {}
  vim.g.drift_config = vim.tbl_deep_extend("force", default_config, opts)
end

-- Apply the colorscheme
function M.colorscheme(style)
  -- Prepare configuration
  local cfg = vim.g.drift_config or default_config
  style = style or cfg.style or "night"

  -- Validate style
  local valid_style = false
  for _, s in ipairs(M.styles_list) do
    if s == style then
      valid_style = true
      break
    end
  end

  if not valid_style then
    vim.notify(
      string.format("Drift: Invalid style '%s'. Using 'night'.", style),
      vim.log.levels.WARN
    )
    style = "night"
  end

  -- Store current style
  M.current_style = style

  -- Update config with style
  vim.g.drift_config = vim.tbl_deep_extend("force", cfg, { style = style })

  -- Determine light/dark background
  if style == "day" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end

  -- Clear existing highlights
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end

  -- Reset syntax if enabled
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end

  -- Set colorscheme name
  vim.g.colors_name = "drift"

  -- Ensure termguicolors
  vim.o.termguicolors = true

  -- Apply highlights
  require("drift.highlights").setup()

  -- Apply terminal colors
  require("drift.terminal").setup()
end

-- Toggle between styles
function M.toggle(reverse)
  local cfg = vim.g.drift_config or default_config
  local toggle_list = cfg.toggle_style_list or M.styles_list
  local current = M.current_style or cfg.style or "night"

  -- Find current index
  local current_idx = 1
  for i, style in ipairs(toggle_list) do
    if style == current then
      current_idx = i
      break
    end
  end

  -- Calculate next index
  local next_idx
  if reverse then
    next_idx = current_idx - 1
    if next_idx < 1 then
      next_idx = #toggle_list
    end
  else
    next_idx = current_idx + 1
    if next_idx > #toggle_list then
      next_idx = 1
    end
  end

  -- Apply next style
  local next_style = toggle_list[next_idx]
  M.colorscheme(next_style)

  -- Notify user
  vim.notify(
    string.format("Drift: Switched to '%s' style", next_style),
    vim.log.levels.INFO
  )
end

-- Setup function
function M.setup(opts)
  M.set_options(opts)
end

-- Load function (called by colorscheme file)
function M.load(style)
  M.colorscheme(style)
end

-- Get palette colors (for external use)
function M.get_colors(style)
  local colors = require("drift.colors")
  local c = colors.get(style)
  return colors.extend(c)
end

-- Get current style
function M.get_style()
  return M.current_style or (vim.g.drift_config and vim.g.drift_config.style) or "night"
end

return M
