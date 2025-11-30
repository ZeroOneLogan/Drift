-- Drift colorscheme colors module
local palette = require("drift.palette")
local cfg = vim.g.drift_config

local function get_colors()
  local style = cfg and cfg.style or "dark"
  local colors = palette[style] or palette.dark
  colors.none = "NONE"
  return colors
end

return get_colors()
