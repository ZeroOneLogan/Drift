-- ╔══════════════════════════════════════════════════════════════════════════╗
-- ║                           DRIFT UTILITIES                                ║
-- ║                  Color manipulation and helper functions                 ║
-- ╚══════════════════════════════════════════════════════════════════════════╝

local M = {}

---Convert hex color to RGB
---@param hex string
---@return number, number, number
function M.hex_to_rgb(hex)
  hex = hex:gsub("#", "")
  return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16)
end

---Convert RGB to hex color
---@param r number
---@param g number
---@param b number
---@return string
function M.rgb_to_hex(r, g, b)
  return string.format("#%02x%02x%02x", math.floor(r + 0.5), math.floor(g + 0.5), math.floor(b + 0.5))
end

---Convert RGB to HSL
---@param r number 0-255
---@param g number 0-255
---@param b number 0-255
---@return number, number, number h(0-360), s(0-1), l(0-1)
function M.rgb_to_hsl(r, g, b)
  r, g, b = r / 255, g / 255, b / 255
  local max, min = math.max(r, g, b), math.min(r, g, b)
  local h, s, l = 0, 0, (max + min) / 2

  if max ~= min then
    local d = max - min
    s = l > 0.5 and d / (2 - max - min) or d / (max + min)
    if max == r then
      h = (g - b) / d + (g < b and 6 or 0)
    elseif max == g then
      h = (b - r) / d + 2
    else
      h = (r - g) / d + 4
    end
    h = h / 6
  end

  return h * 360, s, l
end

---Convert HSL to RGB
---@param h number 0-360
---@param s number 0-1
---@param l number 0-1
---@return number, number, number r, g, b (0-255)
function M.hsl_to_rgb(h, s, l)
  h = h / 360
  local r, g, b

  if s == 0 then
    r, g, b = l, l, l
  else
    local function hue2rgb(p, q, t)
      if t < 0 then
        t = t + 1
      end
      if t > 1 then
        t = t - 1
      end
      if t < 1 / 6 then
        return p + (q - p) * 6 * t
      end
      if t < 1 / 2 then
        return q
      end
      if t < 2 / 3 then
        return p + (q - p) * (2 / 3 - t) * 6
      end
      return p
    end

    local q = l < 0.5 and l * (1 + s) or l + s - l * s
    local p = 2 * l - q
    r = hue2rgb(p, q, h + 1 / 3)
    g = hue2rgb(p, q, h)
    b = hue2rgb(p, q, h - 1 / 3)
  end

  return r * 255, g * 255, b * 255
end

---Blend two colors together
---@param color1 string hex color
---@param color2 string hex color
---@param factor number 0-1 (0 = color1, 1 = color2)
---@return string hex color
function M.blend(color1, color2, factor)
  if not color1 or color1 == "NONE" then
    return color2
  end
  if not color2 or color2 == "NONE" then
    return color1
  end

  local r1, g1, b1 = M.hex_to_rgb(color1)
  local r2, g2, b2 = M.hex_to_rgb(color2)

  local r = r1 + (r2 - r1) * factor
  local g = g1 + (g2 - g1) * factor
  local b = b1 + (b2 - b1) * factor

  return M.rgb_to_hex(r, g, b)
end

---Darken a color by blending it with a dark background
---@param hex string hex color
---@param amount number 0-1 (0 = no change, 1 = fully dark)
---@param bg? string optional background to blend with (default: "#000000")
---@return string
function M.darken(hex, amount, bg)
  if not hex or hex == "NONE" then
    return hex or "NONE"
  end
  bg = bg or "#000000"
  return M.blend(hex, bg, amount)
end

---Lighten a color by blending it with white
---@param hex string hex color
---@param amount number 0-1 (0 = no change, 1 = fully white)
---@return string
function M.lighten(hex, amount)
  return M.blend(hex, "#ffffff", amount)
end

---Saturate a color
---@param hex string hex color
---@param amount number adjustment (-1 to 1)
---@return string
function M.saturate(hex, amount)
  if not hex or hex == "NONE" then
    return hex or "NONE"
  end

  local r, g, b = M.hex_to_rgb(hex)
  local h, s, l = M.rgb_to_hsl(r, g, b)

  s = math.max(0, math.min(1, s + amount))
  r, g, b = M.hsl_to_rgb(h, s, l)

  return M.rgb_to_hex(r, g, b)
end

---Desaturate a color
---@param hex string hex color
---@param amount number adjustment (0-1)
---@return string
function M.desaturate(hex, amount)
  return M.saturate(hex, -amount)
end

---Shift hue of a color
---@param hex string hex color
---@param degrees number hue shift in degrees
---@return string
function M.hue_shift(hex, degrees)
  if not hex or hex == "NONE" then
    return hex or "NONE"
  end

  local r, g, b = M.hex_to_rgb(hex)
  local h, s, l = M.rgb_to_hsl(r, g, b)

  h = (h + degrees) % 360
  r, g, b = M.hsl_to_rgb(h, s, l)

  return M.rgb_to_hex(r, g, b)
end

---Adjust brightness of a color
---@param hex string hex color
---@param amount number adjustment (-1 to 1)
---@return string
function M.brightness(hex, amount)
  if not hex or hex == "NONE" then
    return hex or "NONE"
  end

  local r, g, b = M.hex_to_rgb(hex)
  local h, s, l = M.rgb_to_hsl(r, g, b)

  l = math.max(0, math.min(1, l + amount))
  r, g, b = M.hsl_to_rgb(h, s, l)

  return M.rgb_to_hex(r, g, b)
end

---Get luminance of a color (for contrast calculations)
---@param hex string hex color
---@return number luminance 0-1
function M.luminance(hex)
  if not hex or hex == "NONE" then
    return 0
  end

  local r, g, b = M.hex_to_rgb(hex)
  r, g, b = r / 255, g / 255, b / 255

  local function adjust(c)
    return c <= 0.03928 and c / 12.92 or ((c + 0.055) / 1.055) ^ 2.4
  end

  return 0.2126 * adjust(r) + 0.7152 * adjust(g) + 0.0722 * adjust(b)
end

---Calculate contrast ratio between two colors
---@param fg string foreground hex color
---@param bg string background hex color
---@return number contrast ratio (1-21)
function M.contrast_ratio(fg, bg)
  local l1 = M.luminance(fg)
  local l2 = M.luminance(bg)

  local lighter = math.max(l1, l2)
  local darker = math.min(l1, l2)

  return (lighter + 0.05) / (darker + 0.05)
end

---Create a transparent version of a color (for blending effect)
---@param hex string hex color
---@param alpha number 0-1 (0 = fully transparent effect)
---@param bg string background to blend against
---@return string
function M.transparent(hex, alpha, bg)
  return M.blend(bg, hex, alpha)
end

---Invert a color
---@param hex string hex color
---@return string
function M.invert(hex)
  if not hex or hex == "NONE" then
    return hex or "NONE"
  end

  local r, g, b = M.hex_to_rgb(hex)
  return M.rgb_to_hex(255 - r, 255 - g, 255 - b)
end

---Create a highlight table
---@param opts table highlight options
---@return table
function M.highlight(opts)
  return {
    fg = opts.fg,
    bg = opts.bg,
    sp = opts.sp,
    fmt = opts.style or opts.fmt,
    bold = opts.bold,
    italic = opts.italic,
    underline = opts.underline,
    undercurl = opts.undercurl,
    strikethrough = opts.strikethrough,
    reverse = opts.reverse,
    nocombine = opts.nocombine,
  }
end

---Check if running in a light background
---@return boolean
function M.is_light()
  return vim.o.background == "light"
end

---Get a highlight attribute
---@param group string highlight group name
---@param attr string attribute name (fg, bg, etc.)
---@return string|nil
function M.get_highlight(group, attr)
  local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
  if attr == "fg" then
    return hl.fg and string.format("#%06x", hl.fg) or nil
  elseif attr == "bg" then
    return hl.bg and string.format("#%06x", hl.bg) or nil
  elseif attr == "sp" then
    return hl.sp and string.format("#%06x", hl.sp) or nil
  end
  return hl[attr]
end

---Merge multiple tables (deep merge)
---@vararg table
---@return table
function M.merge(...)
  local result = {}
  for _, t in ipairs({ ... }) do
    for k, v in pairs(t) do
      if type(v) == "table" and type(result[k]) == "table" then
        result[k] = M.merge(result[k], v)
      else
        result[k] = v
      end
    end
  end
  return result
end

---Create color variations
---@param base string base hex color
---@param bg string background color for blending
---@return table variations table with different intensities
function M.variations(base, bg)
  return {
    base = base,
    bright = M.lighten(base, 0.15),
    dim = M.darken(base, 0.7, bg),
    faint = M.darken(base, 0.5, bg),
    subtle = M.blend(bg, base, 0.15),
    muted = M.desaturate(base, 0.3),
  }
end

---Get semantic color based on type
---@param palette table color palette
---@param semantic string semantic name
---@return string hex color
function M.semantic(palette, semantic)
  local mapping = {
    -- Basic semantics
    error = palette.error or palette.mauve,
    warning = palette.warn or palette.amber,
    info = palette.info or palette.azure,
    hint = palette.hint or palette.mint,
    success = palette.ok or palette.sage,

    -- Code semantics
    keyword = palette.iris,
    func = palette.azure,
    string = palette.sage,
    number = palette.amber,
    type = palette.mint,
    constant = palette.cyan,
    variable = palette.fg1,
    parameter = palette.rose,
    property = palette.mint,
    operator = palette.iris,
    comment = palette.fg3,
    punctuation = palette.fg2,

    -- Git semantics
    added = palette.git_add or palette.sage,
    changed = palette.git_change or palette.amber,
    deleted = palette.git_delete or palette.mauve,
  }

  return mapping[semantic] or palette.fg1
end

return M
