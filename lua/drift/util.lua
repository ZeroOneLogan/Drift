-- Drift colorscheme utility functions
local M = {}

--- Darken a color by mixing it with black
---@param hex string: hex color code
---@param amount number: amount to darken (0-1)
---@param bg string: background color to mix with
---@return string: darkened hex color
function M.darken(hex, amount, bg)
  if not hex or hex == "NONE" then
    return hex
  end
  bg = bg or "#000000"

  local function hex_to_rgb(h)
    h = h:gsub("#", "")
    return tonumber(h:sub(1, 2), 16), tonumber(h:sub(3, 4), 16), tonumber(h:sub(5, 6), 16)
  end

  local function rgb_to_hex(r, g, b)
    return string.format("#%02x%02x%02x", r, g, b)
  end

  local r1, g1, b1 = hex_to_rgb(hex)
  local r2, g2, b2 = hex_to_rgb(bg)

  local r = math.floor(r1 * amount + r2 * (1 - amount))
  local g = math.floor(g1 * amount + g2 * (1 - amount))
  local b = math.floor(b1 * amount + b2 * (1 - amount))

  return rgb_to_hex(r, g, b)
end

--- Lighten a color by mixing it with white
---@param hex string: hex color code
---@param amount number: amount to lighten (0-1)
---@return string: lightened hex color
function M.lighten(hex, amount)
  return M.darken(hex, amount, "#ffffff")
end

return M
