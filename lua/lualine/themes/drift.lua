-- Drift lualine theme
local colors = require("drift.colors")

local drift = {}

drift.normal = {
  a = { fg = colors.bg0, bg = colors.green, gui = "bold" },
  b = { fg = colors.fg, bg = colors.bg2 },
  c = { fg = colors.fg, bg = colors.bg1 },
}

drift.insert = {
  a = { fg = colors.bg0, bg = colors.blue, gui = "bold" },
}

drift.visual = {
  a = { fg = colors.bg0, bg = colors.purple, gui = "bold" },
}

drift.replace = {
  a = { fg = colors.bg0, bg = colors.red, gui = "bold" },
}

drift.command = {
  a = { fg = colors.bg0, bg = colors.yellow, gui = "bold" },
}

drift.terminal = {
  a = { fg = colors.bg0, bg = colors.cyan, gui = "bold" },
}

drift.inactive = {
  a = { fg = colors.grey, bg = colors.bg1 },
  b = { fg = colors.grey, bg = colors.bg1 },
  c = { fg = colors.grey, bg = colors.bg1 },
}

return drift
