-- Drift colorscheme colors module
local palette = require("drift.palette")

local function get_colors()
  local cfg = vim.g.drift_config or {}
  local style = cfg.style or "dark"
  local colors = palette[style] or palette.dark
  colors.none = "NONE"
  return colors
end

return get_colors()
