-- =============================================================================
-- DRIFT COLORSCHEME - TERMINAL COLORS
-- 16-color terminal palette for integrated terminal support
-- =============================================================================

local M = {}

function M.setup()
  local colors = require("drift.colors")
  local cfg = vim.g.drift_config or {}
  local c = colors.get(cfg.style)
  c = colors.extend(c)

  -- Terminal color palette (0-15)
  -- Uses the semantic colors from our palette for consistency

  -- Normal colors (0-7)
  vim.g.terminal_color_0 = c.bg0        -- Black
  vim.g.terminal_color_1 = c.mauve      -- Red
  vim.g.terminal_color_2 = c.sage       -- Green
  vim.g.terminal_color_3 = c.amber      -- Yellow
  vim.g.terminal_color_4 = c.azure      -- Blue
  vim.g.terminal_color_5 = c.iris       -- Magenta
  vim.g.terminal_color_6 = c.cyan       -- Cyan
  vim.g.terminal_color_7 = c.fg2        -- White

  -- Bright colors (8-15)
  vim.g.terminal_color_8 = c.bg3        -- Bright Black (Gray)
  vim.g.terminal_color_9 = c.rose       -- Bright Red
  vim.g.terminal_color_10 = c.mint      -- Bright Green
  vim.g.terminal_color_11 = c.gold      -- Bright Yellow
  vim.g.terminal_color_12 = c.lavender  -- Bright Blue
  vim.g.terminal_color_13 = c.blossom   -- Bright Magenta
  vim.g.terminal_color_14 = c.cyan      -- Bright Cyan
  vim.g.terminal_color_15 = c.fg1       -- Bright White

  -- Background and foreground (used by some terminal emulators)
  vim.g.terminal_color_background = c.bg0
  vim.g.terminal_color_foreground = c.fg1
end

return M
