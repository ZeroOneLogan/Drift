-- ╔══════════════════════════════════════════════════════════════════════════╗
-- ║                            DRIFT COLORS                                  ║
-- ║                    Dynamic color loading module                          ║
-- ╚══════════════════════════════════════════════════════════════════════════╝

local M = {}

local palette = require("drift.palette")
local util = require("drift.util")

---Get current configuration
---@return table
local function get_config()
  return vim.g.drift_config or { style = "night" }
end

---Get colors for current style
---@param style? string optional style override
---@return table colors
function M.get(style)
  local cfg = get_config()
  style = style or cfg.style or "night"

  -- Map background to style
  if vim.o.background == "light" and style ~= "day" then
    style = "day"
  end

  local colors = palette[style] or palette.night

  -- Apply user color overrides
  if cfg.colors and type(cfg.colors) == "table" then
    colors = vim.tbl_deep_extend("force", colors, cfg.colors)
  end

  return colors
end

---Generate extended semantic colors from base palette
---@param c table base colors
---@return table extended colors
function M.extend(c)
  local extended = vim.tbl_deep_extend("force", {}, c)

  -- Generate UI color variants
  extended.bg_dark = util.darken(c.bg0, 0.1)
  extended.bg_highlight = util.lighten(c.bg0, 0.05)
  extended.bg_sidebar = c.bg1
  extended.bg_statusline = c.bg1
  extended.bg_cursorline = util.blend(c.bg0, c.bg2, 0.6)

  -- Generate semantic colors for diagnostics
  extended.error_bg = util.blend(c.bg0, c.error, 0.1)
  extended.warn_bg = util.blend(c.bg0, c.warn, 0.1)
  extended.info_bg = util.blend(c.bg0, c.info, 0.1)
  extended.hint_bg = util.blend(c.bg0, c.hint, 0.1)
  extended.ok_bg = util.blend(c.bg0, c.ok, 0.1)

  -- Generate text variants
  extended.fg_dark = util.darken(c.fg1, 0.8, c.bg0)
  extended.fg_gutter = c.fg4
  extended.fg_sidebar = c.fg2

  -- Alias comment color (typically fg3)
  extended.comment = c.fg3

  -- Rainbow colors for brackets, indents, etc.
  extended.rainbow = {
    c.iris,
    c.azure,
    c.sage,
    c.amber,
    c.coral,
    c.mint,
    c.rose,
  }

  return extended
end

-- For backwards compatibility, return colors directly when module is required
-- This allows: local c = require("drift.colors")
setmetatable(M, {
  __index = function(_, key)
    local c = M.get()
    return c[key]
  end,
})

return M
