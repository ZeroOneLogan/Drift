-- =============================================================================
-- DRIFT COLORSCHEME - LUALINE THEME
-- A beautiful statusline theme that complements the Drift colorscheme
-- =============================================================================

local drift = require("drift")
local colors = require("drift.colors")
local util = require("drift.util")

local M = {}

-- Generate lualine theme based on current style
function M.get()
  local c = colors.get()
  c = colors.extend(c)

  -- Determine if using light or dark background
  local is_light = vim.o.background == "light"

  -- Create accent variations for visual interest
  local bg_status = util.darken(c.bg0, 0.8)
  local bg_inactive = util.lighten(c.bg0, 0.03)

  return {
    normal = {
      a = { fg = c.bg0, bg = c.azure, gui = "bold" },
      b = { fg = c.azure, bg = c.bg2 },
      c = { fg = c.fg2, bg = bg_status },
    },
    insert = {
      a = { fg = c.bg0, bg = c.sage, gui = "bold" },
      b = { fg = c.sage, bg = c.bg2 },
      c = { fg = c.fg2, bg = bg_status },
    },
    visual = {
      a = { fg = c.bg0, bg = c.iris, gui = "bold" },
      b = { fg = c.iris, bg = c.bg2 },
      c = { fg = c.fg2, bg = bg_status },
    },
    replace = {
      a = { fg = c.bg0, bg = c.mauve, gui = "bold" },
      b = { fg = c.mauve, bg = c.bg2 },
      c = { fg = c.fg2, bg = bg_status },
    },
    command = {
      a = { fg = c.bg0, bg = c.amber, gui = "bold" },
      b = { fg = c.amber, bg = c.bg2 },
      c = { fg = c.fg2, bg = bg_status },
    },
    terminal = {
      a = { fg = c.bg0, bg = c.mint, gui = "bold" },
      b = { fg = c.mint, bg = c.bg2 },
      c = { fg = c.fg2, bg = bg_status },
    },
    inactive = {
      a = { fg = c.fg3, bg = bg_inactive },
      b = { fg = c.fg3, bg = bg_inactive },
      c = { fg = c.fg3, bg = bg_inactive },
    },
  }
end

-- Return theme when required
return M.get()
