-- ╔══════════════════════════════════════════════════════════════════════════╗
-- ║                              DRIFT PALETTE                               ║
-- ║         Inspired by bioluminescent oceans, auroras, and nebulae          ║
-- ╚══════════════════════════════════════════════════════════════════════════╝

---@class DriftPalette
---@field bg0 string Main background
---@field bg1 string Lighter background (status bars, float)
---@field bg2 string Selection background
---@field bg3 string Comments, line numbers background
---@field bg4 string Highlighted backgrounds
---@field fg0 string Brightest foreground (titles, bold)
---@field fg1 string Main foreground
---@field fg2 string Muted foreground
---@field fg3 string Comments, disabled text
---@field rose string Primary accent - warm pink/rose
---@field coral string Secondary warm accent
---@field amber string Warning, attention
---@field gold string Numbers, special values
---@field sage string Success, strings
---@field mint string Types, properties
---@field cyan string Builtins, constants
---@field azure string Functions, links
---@field iris string Keywords, operators
---@field lavender string Preprocessor, includes
---@field mauve string Errors, deletions
---@field blossom string Special highlights

local M = {}

-- ┌──────────────────────────────────────────────────────────────────────────┐
-- │                           NIGHT - Default                                │
-- │              Deep ocean at twilight with bioluminescent glow             │
-- └──────────────────────────────────────────────────────────────────────────┘
M.night = {
  -- Backgrounds - Deep ocean blues with subtle warmth
  bg0 = "#0f1419",       -- Main editor background - deep ocean
  bg1 = "#151b22",       -- Sidebars, status bars
  bg2 = "#1a222b",       -- Selection, visual
  bg3 = "#212a35",       -- Popups, floating windows
  bg4 = "#283442",       -- Highlighted, current line
  bg_float = "#121820",  -- Floating windows background
  bg_popup = "#161d26",  -- Popup menus
  bg_visual = "#264f78", -- Visual selection (ocean deep)
  bg_search = "#4d3d00", -- Search highlight (amber glow)
  bg_match = "#2f3d2f",  -- Match parentheses

  -- Foregrounds - Soft, warm white with ocean tint
  fg0 = "#f0f4f8",       -- Brightest - titles, bold
  fg1 = "#d8dee9",       -- Main text
  fg2 = "#a9b7c6",       -- Secondary text
  fg3 = "#6b7d8f",       -- Comments, line numbers
  fg4 = "#4a5568",       -- Disabled, subtle text

  -- Accent Colors - Bioluminescent palette
  rose = "#f5a9b8",      -- Warm rose - parameters, special
  coral = "#ff9e64",     -- Coral - warnings, operators  
  amber = "#e5c07b",     -- Amber - numbers, booleans
  gold = "#ffd700",      -- Gold - special highlights
  sage = "#98c379",      -- Sage green - strings
  mint = "#73daca",      -- Mint - types, properties
  cyan = "#56d4dd",      -- Cyan - builtins
  azure = "#61afef",     -- Azure - functions
  iris = "#c792ea",      -- Iris purple - keywords
  lavender = "#a9a1e1",  -- Lavender - preprocessor
  mauve = "#f07178",     -- Mauve red - errors
  blossom = "#fca7ea",   -- Pink blossom - special

  -- Semantic colors
  error = "#f07178",
  warn = "#e5c07b",
  info = "#61afef",
  hint = "#73daca",
  ok = "#98c379",

  -- Diff colors
  diff_add = "#1e3a2b",
  diff_add_fg = "#98c379",
  diff_delete = "#3a1e1e",
  diff_delete_fg = "#f07178",
  diff_change = "#1e2a3a",
  diff_change_fg = "#61afef",
  diff_text = "#2a3a4a",

  -- Git colors
  git_add = "#98c379",
  git_change = "#e5c07b",
  git_delete = "#f07178",

  -- Border
  border = "#3a4657",
  border_highlight = "#61afef",

  -- Special
  none = "NONE",
}

-- ┌──────────────────────────────────────────────────────────────────────────┐
-- │                              STORM                                       │
-- │              Darker, high contrast - stormy ocean depths                 │
-- └──────────────────────────────────────────────────────────────────────────┘
M.storm = {
  -- Backgrounds - Deepest darkness
  bg0 = "#0a0e14",
  bg1 = "#0f141a",
  bg2 = "#151b23",
  bg3 = "#1a222c",
  bg4 = "#222c38",
  bg_float = "#080c10",
  bg_popup = "#0d1218",
  bg_visual = "#1e4466",
  bg_search = "#4d3800",
  bg_match = "#2a3a2a",

  -- Foregrounds - Higher contrast
  fg0 = "#f4f8fc",
  fg1 = "#e0e6ee",
  fg2 = "#b8c4d0",
  fg3 = "#6a7a8c",
  fg4 = "#4a5666",

  -- Accent Colors - Electric storm palette
  rose = "#ff6e9c",
  coral = "#ff8f40",
  amber = "#ffd580",
  gold = "#ffe700",
  sage = "#a6e22e",
  mint = "#66ffcc",
  cyan = "#50e3f0",
  azure = "#59b3ff",
  iris = "#d499ff",
  lavender = "#b4a6ff",
  mauve = "#ff5555",
  blossom = "#ff99dd",

  error = "#ff5555",
  warn = "#ffd580",
  info = "#59b3ff",
  hint = "#66ffcc",
  ok = "#a6e22e",

  diff_add = "#1a3328",
  diff_add_fg = "#a6e22e",
  diff_delete = "#3a1818",
  diff_delete_fg = "#ff5555",
  diff_change = "#182838",
  diff_change_fg = "#59b3ff",
  diff_text = "#283848",

  git_add = "#a6e22e",
  git_change = "#ffd580",
  git_delete = "#ff5555",

  border = "#2a3644",
  border_highlight = "#59b3ff",

  none = "NONE",
}

-- ┌──────────────────────────────────────────────────────────────────────────┐
-- │                              AURORA                                      │
-- │              Vibrant northern lights dancing across the sky              │
-- └──────────────────────────────────────────────────────────────────────────┘
M.aurora = {
  -- Backgrounds - Deep polar night with subtle warmth
  bg0 = "#11131f",
  bg1 = "#161927",
  bg2 = "#1c2030",
  bg3 = "#242839",
  bg4 = "#2c3145",
  bg_float = "#0e1018",
  bg_popup = "#14171f",
  bg_visual = "#3d4466",
  bg_search = "#4d4400",
  bg_match = "#2d3d2d",

  -- Foregrounds - Cool polar light
  fg0 = "#ecf0f8",
  fg1 = "#d4dce8",
  fg2 = "#a8b4c4",
  fg3 = "#6a7688",
  fg4 = "#4a5464",

  -- Accent Colors - Aurora palette (greens, purples, pinks)
  rose = "#ff8eb3",
  coral = "#ff9966",
  amber = "#ebcb8b",
  gold = "#ffd866",
  sage = "#a3be8c",
  mint = "#88ffcc",
  cyan = "#8fbcbb",
  azure = "#88c0d0",
  iris = "#b48ead",
  lavender = "#d4bfff",
  mauve = "#bf616a",
  blossom = "#ea9aff",

  error = "#bf616a",
  warn = "#ebcb8b",
  info = "#88c0d0",
  hint = "#a3be8c",
  ok = "#a3be8c",

  diff_add = "#1e3328",
  diff_add_fg = "#a3be8c",
  diff_delete = "#381e1e",
  diff_delete_fg = "#bf616a",
  diff_change = "#1e2838",
  diff_change_fg = "#88c0d0",
  diff_text = "#283848",

  git_add = "#a3be8c",
  git_change = "#ebcb8b",
  git_delete = "#bf616a",

  border = "#3b4261",
  border_highlight = "#88c0d0",

  none = "NONE",
}

-- ┌──────────────────────────────────────────────────────────────────────────┐
-- │                               MOON                                       │
-- │              Soft moonlit beach, gentle and calming                      │
-- └──────────────────────────────────────────────────────────────────────────┘
M.moon = {
  -- Backgrounds - Softer, more muted
  bg0 = "#1a1b26",
  bg1 = "#1f2133",
  bg2 = "#24273a",
  bg3 = "#2a2e42",
  bg4 = "#32374d",
  bg_float = "#16171f",
  bg_popup = "#1c1d28",
  bg_visual = "#3d4466",
  bg_search = "#443300",
  bg_match = "#2d3d2d",

  -- Foregrounds - Moonlit silver
  fg0 = "#c8d3f5",
  fg1 = "#b4c2e6",
  fg2 = "#8893b3",
  fg3 = "#5a6380",
  fg4 = "#444b66",

  -- Accent Colors - Moonlit palette (softer, pastel)
  rose = "#fca7ea",
  coral = "#ff966c",
  amber = "#ffc777",
  gold = "#ffe066",
  sage = "#c3e88d",
  mint = "#86e1fc",
  cyan = "#7dcfff",
  azure = "#82aaff",
  iris = "#c099ff",
  lavender = "#b4a6ff",
  mauve = "#ff757f",
  blossom = "#fca7ea",

  error = "#ff757f",
  warn = "#ffc777",
  info = "#82aaff",
  hint = "#c3e88d",
  ok = "#c3e88d",

  diff_add = "#1e3328",
  diff_add_fg = "#c3e88d",
  diff_delete = "#381e1e",
  diff_delete_fg = "#ff757f",
  diff_change = "#1e2838",
  diff_change_fg = "#82aaff",
  diff_text = "#283848",

  git_add = "#c3e88d",
  git_change = "#ffc777",
  git_delete = "#ff757f",

  border = "#3b4261",
  border_highlight = "#82aaff",

  none = "NONE",
}

-- ┌──────────────────────────────────────────────────────────────────────────┐
-- │                            MOONLIGHT                                     │
-- │      Port of the iconic VS Code "Moonlight" theme by @atomiks            │
-- └──────────────────────────────────────────────────────────────────────────┘
M.moonlight = {
  -- Backgrounds - indigo night base
  bg0 = "#1e2030",       -- Main editor background
  bg1 = "#222436",       -- Sidebars, status bars
  bg2 = "#2a2d3f",       -- Selection, subtle panels
  bg3 = "#2f334d",       -- Popups, floating windows
  bg4 = "#3b4261",       -- Highlighted / cursorline
  bg_float = "#1f2233",  -- Floating windows background
  bg_popup = "#1f2233",  -- Popup menus
  bg_visual = "#31374f", -- Visual selection
  bg_search = "#3f2d1c", -- Search highlight (amber glow)
  bg_match = "#2a2f4e",  -- Match parentheses

  -- Foregrounds - crisp moonlit text
  fg0 = "#dfe6ff",       -- Brightest - titles, bold
  fg1 = "#c8d3f5",       -- Main text
  fg2 = "#a9b8d1",       -- Secondary text
  fg3 = "#7a88cf",       -- Comments, line numbers
  fg4 = "#5c6185",       -- Disabled, subtle text

  -- Accent Colors - bubblegum on indigo
  rose = "#f4a6d6",
  coral = "#ff966c",
  amber = "#ffc777",
  gold = "#ffd8a1",
  sage = "#c3e88d",
  mint = "#4fd6be",
  cyan = "#86e1fc",
  azure = "#82aaff",
  iris = "#c099ff",
  lavender = "#b4befe",
  mauve = "#ff5370",
  blossom = "#ffbde7",

  -- Semantic colors
  error = "#ff5370",
  warn = "#ffc777",
  info = "#82aaff",
  hint = "#4fd6be",
  ok = "#c3e88d",

  -- Diff colors
  diff_add = "#1f2b2d",
  diff_add_fg = "#c3e88d",
  diff_delete = "#2f1f2a",
  diff_delete_fg = "#ff5370",
  diff_change = "#1f2a3a",
  diff_change_fg = "#82aaff",
  diff_text = "#2b3a55",

  -- Git colors
  git_add = "#c3e88d",
  git_change = "#ffc777",
  git_delete = "#ff5370",

  -- Border
  border = "#3b4261",
  border_highlight = "#82aaff",

  -- Special
  none = "NONE",
}

-- ┌──────────────────────────────────────────────────────────────────────────┐
-- │                               DAY                                        │
-- │              Light theme - morning ocean with sun sparkles               │
-- └──────────────────────────────────────────────────────────────────────────┘
M.day = {
  -- Backgrounds - Clean, bright
  bg0 = "#f8fafc",
  bg1 = "#f1f4f8",
  bg2 = "#e8ecf2",
  bg3 = "#dde3eb",
  bg4 = "#d2dae4",
  bg_float = "#ffffff",
  bg_popup = "#f4f7fa",
  bg_visual = "#b8d4f0",
  bg_search = "#ffe8b3",
  bg_match = "#d4e8d4",

  -- Foregrounds - Rich, readable
  fg0 = "#1a1a2e",
  fg1 = "#2e3440",
  fg2 = "#4c566a",
  fg3 = "#7b8799",
  fg4 = "#9aa5b8",

  -- Accent Colors - Vibrant but not harsh
  rose = "#d23669",
  coral = "#e55039",
  amber = "#c18401",
  gold = "#b58900",
  sage = "#28a745",
  mint = "#0a9396",
  cyan = "#0891b2",
  azure = "#0969da",
  iris = "#7c3aed",
  lavender = "#8b5cf6",
  mauve = "#be123c",
  blossom = "#db2777",

  error = "#be123c",
  warn = "#c18401",
  info = "#0969da",
  hint = "#28a745",
  ok = "#28a745",

  diff_add = "#d4edda",
  diff_add_fg = "#28a745",
  diff_delete = "#f8d7da",
  diff_delete_fg = "#be123c",
  diff_change = "#cce5ff",
  diff_change_fg = "#0969da",
  diff_text = "#b8daff",

  git_add = "#28a745",
  git_change = "#c18401",
  git_delete = "#be123c",

  border = "#c8d1dc",
  border_highlight = "#0969da",

  none = "NONE",
}

-- ┌──────────────────────────────────────────────────────────────────────────┐
-- │                              NEBULA                                      │
-- │              Cosmic purples and deep space wonder                        │
-- └──────────────────────────────────────────────────────────────────────────┘
M.nebula = {
  -- Backgrounds - Deep space purple-black
  bg0 = "#120f18",
  bg1 = "#181520",
  bg2 = "#1f1b28",
  bg3 = "#282433",
  bg4 = "#322d40",
  bg_float = "#0e0c14",
  bg_popup = "#161320",
  bg_visual = "#4a3d66",
  bg_search = "#4a4400",
  bg_match = "#2d3d2d",

  -- Foregrounds - Starlight
  fg0 = "#f0ecf8",
  fg1 = "#dcd8e8",
  fg2 = "#b4aec4",
  fg3 = "#7a7490",
  fg4 = "#5a5470",

  -- Accent Colors - Nebula palette (purples, magentas, cyans)
  rose = "#ff6b9d",
  coral = "#ff8b6b",
  amber = "#ffd580",
  gold = "#ffe066",
  sage = "#95e6b0",
  mint = "#80eeca",
  cyan = "#6be5f0",
  azure = "#6bb3ff",
  iris = "#d38aff",
  lavender = "#c4b5ff",
  mauve = "#f05f70",
  blossom = "#ff7dc6",

  error = "#f05f70",
  warn = "#ffd580",
  info = "#6bb3ff",
  hint = "#95e6b0",
  ok = "#95e6b0",

  diff_add = "#1e3328",
  diff_add_fg = "#95e6b0",
  diff_delete = "#381e22",
  diff_delete_fg = "#f05f70",
  diff_change = "#1e2838",
  diff_change_fg = "#6bb3ff",
  diff_text = "#283848",

  git_add = "#95e6b0",
  git_change = "#ffd580",
  git_delete = "#f05f70",

  border = "#403858",
  border_highlight = "#d38aff",

  none = "NONE",
}

-- Alias for default
M.dark = M.night
M.light = M.day

return M
