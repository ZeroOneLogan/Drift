-- Drift colorscheme highlight definitions
local c = require("drift.colors")
local cfg = vim.g.drift_config
local util = require("drift.util")

local M = {}
local hl = { langs = {}, plugins = {} }

local function vim_highlights(highlights)
  for group_name, group_settings in pairs(highlights) do
    vim.api.nvim_command(
      string.format(
        "highlight %s guifg=%s guibg=%s guisp=%s gui=%s",
        group_name,
        group_settings.fg or "none",
        group_settings.bg or "none",
        group_settings.sp or "none",
        group_settings.fmt or "none"
      )
    )
  end
end

local colors = {
  Fg = { fg = c.fg },
  LightGrey = { fg = c.light_grey },
  Grey = { fg = c.grey },
  Red = { fg = c.red },
  Cyan = { fg = c.cyan },
  Yellow = { fg = c.yellow },
  Orange = { fg = c.orange },
  Green = { fg = c.green },
  Blue = { fg = c.blue },
  Purple = { fg = c.purple },
}

hl.common = {
  Normal = { fg = c.fg, bg = cfg.transparent and c.none or c.bg0 },
  Terminal = { fg = c.fg, bg = cfg.transparent and c.none or c.bg0 },
  EndOfBuffer = { fg = cfg.ending_tildes and c.grey or c.bg0, bg = cfg.transparent and c.none or c.bg0 },
  FoldColumn = { fg = c.fg, bg = cfg.transparent and c.none or c.bg1 },
  Folded = { fg = c.fg, bg = cfg.transparent and c.none or c.bg1 },
  SignColumn = { fg = c.fg, bg = cfg.transparent and c.none or c.bg0 },
  ToolbarLine = { fg = c.fg },
  Cursor = { fmt = "reverse" },
  vCursor = { fmt = "reverse" },
  iCursor = { fmt = "reverse" },
  lCursor = { fmt = "reverse" },
  CursorIM = { fmt = "reverse" },
  CursorColumn = { bg = c.bg1 },
  CursorLine = { bg = c.bg1 },
  ColorColumn = { bg = c.bg1 },
  CursorLineNr = { fg = c.fg },
  LineNr = { fg = c.grey },
  Conceal = { fg = c.grey, bg = c.bg1 },
  Added = colors.Green,
  Removed = colors.Red,
  Changed = colors.Blue,
  DiffAdd = { fg = c.none, bg = c.diff_add },
  DiffChange = { fg = c.none, bg = c.diff_change },
  DiffDelete = { fg = c.none, bg = c.diff_delete },
  DiffText = { fg = c.none, bg = c.diff_text },
  DiffAdded = colors.Green,
  DiffChanged = colors.Blue,
  DiffRemoved = colors.Red,
  DiffDeleted = colors.Red,
  DiffFile = colors.Cyan,
  DiffIndexLine = colors.Grey,
  Directory = { fg = c.blue },
  ErrorMsg = { fg = c.red, fmt = "bold" },
  WarningMsg = { fg = c.yellow, fmt = "bold" },
  MoreMsg = { fg = c.blue, fmt = "bold" },
  CurSearch = { fg = c.bg0, bg = c.orange },
  IncSearch = { fg = c.bg0, bg = c.orange },
  Search = { fg = c.bg0, bg = c.bg_yellow },
  Substitute = { fg = c.bg0, bg = c.green },
  MatchParen = { fg = c.none, bg = c.bg3 },
  NonText = { fg = c.grey },
  Whitespace = { fg = c.grey },
  SpecialKey = { fg = c.grey },
  Pmenu = { fg = c.fg, bg = c.bg1 },
  PmenuSbar = { fg = c.none, bg = c.bg1 },
  PmenuSel = { fg = c.bg0, bg = c.bg_blue },
  WildMenu = { fg = c.bg0, bg = c.blue },
  PmenuThumb = { fg = c.none, bg = c.grey },
  Question = { fg = c.yellow },
  SpellBad = { fg = c.none, fmt = "undercurl", sp = c.red },
  SpellCap = { fg = c.none, fmt = "undercurl", sp = c.yellow },
  SpellLocal = { fg = c.none, fmt = "undercurl", sp = c.blue },
  SpellRare = { fg = c.none, fmt = "undercurl", sp = c.purple },
  StatusLine = { fg = c.fg, bg = c.bg2, fmt = "NONE" },
  StatusLineTerm = { fg = c.fg, bg = c.bg2, fmt = "NONE" },
  StatusLineNC = { fg = c.grey, bg = c.bg1, fmt = "NONE" },
  StatusLineTermNC = { fg = c.grey, bg = c.bg1, fmt = "NONE" },
  TabLine = { fg = c.fg, bg = c.bg1 },
  TabLineFill = { fg = c.grey, bg = c.bg1 },
  TabLineSel = { fg = c.bg0, bg = c.fg },
  WinSeparator = { fg = c.bg3 },
  VertSplit = { fg = c.bg3 },
  Visual = { bg = c.bg3 },
  VisualNOS = { fg = c.none, bg = c.bg2, fmt = "underline" },
  QuickFixLine = { fg = c.blue, fmt = "underline" },
  Debug = { fg = c.yellow },
  debugPC = { fg = c.bg0, bg = c.green },
  debugBreakpoint = { fg = c.bg0, bg = c.red },
  ToolbarButton = { fg = c.bg0, bg = c.bg_blue },
  FloatBorder = { fg = c.grey, bg = c.bg1 },
  NormalFloat = { fg = c.fg, bg = c.bg1 },
  WinBar = { fg = c.fg, bg = cfg.transparent and c.none or c.bg0 },
  WinBarNC = { fg = c.grey, bg = cfg.transparent and c.none or c.bg0 },
}

hl.syntax = {
  String = { fg = c.green, fmt = cfg.code_style.strings },
  Character = colors.Orange,
  Number = colors.Orange,
  Float = colors.Orange,
  Boolean = colors.Orange,
  Type = colors.Yellow,
  Structure = colors.Yellow,
  StorageClass = colors.Yellow,
  Identifier = { fg = c.red, fmt = cfg.code_style.variables },
  Constant = colors.Cyan,
  PreProc = colors.Purple,
  PreCondit = colors.Purple,
  Include = colors.Purple,
  Keyword = { fg = c.purple, fmt = cfg.code_style.keywords },
  Define = colors.Purple,
  Typedef = colors.Yellow,
  Exception = colors.Purple,
  Conditional = { fg = c.purple, fmt = cfg.code_style.keywords },
  Repeat = { fg = c.purple, fmt = cfg.code_style.keywords },
  Statement = colors.Purple,
  Macro = colors.Red,
  Error = colors.Purple,
  Label = colors.Purple,
  Special = colors.Red,
  SpecialChar = colors.Red,
  Function = { fg = c.blue, fmt = cfg.code_style.functions },
  Operator = colors.Purple,
  Title = colors.Cyan,
  Tag = colors.Green,
  Delimiter = colors.LightGrey,
  Comment = { fg = c.grey, fmt = cfg.code_style.comments },
  SpecialComment = { fg = c.grey, fmt = cfg.code_style.comments },
  Todo = { fg = c.red, fmt = cfg.code_style.comments },
}

if vim.api.nvim_call_function("has", { "nvim-0.8" }) == 1 then
  hl.treesitter = {
    -- Modern standardized nvim-treesitter captures (Neovim 0.9+)
    -- Attributes
    ["@attribute"] = colors.Cyan,
    ["@attribute.builtin"] = colors.Blue,

    -- Primitives
    ["@boolean"] = colors.Orange,
    ["@character"] = colors.Orange,
    ["@character.special"] = colors.Red,
    ["@number"] = colors.Orange,
    ["@number.float"] = colors.Orange,

    -- Comments
    ["@comment"] = { fg = c.grey, fmt = cfg.code_style.comments },
    ["@comment.documentation"] = { fg = c.grey, fmt = cfg.code_style.comments },
    ["@comment.error"] = { fg = c.red, fmt = cfg.code_style.comments },
    ["@comment.note"] = { fg = c.blue, fmt = cfg.code_style.comments },
    ["@comment.todo"] = { fg = c.purple, fmt = cfg.code_style.comments },
    ["@comment.warning"] = { fg = c.yellow, fmt = cfg.code_style.comments },

    -- Constants
    ["@constant"] = colors.Cyan,
    ["@constant.builtin"] = colors.Orange,
    ["@constant.macro"] = colors.Orange,

    -- Constructors
    ["@constructor"] = { fg = c.yellow, fmt = "bold" },

    -- Diffs
    ["@diff.plus"] = colors.Green,
    ["@diff.minus"] = colors.Red,
    ["@diff.delta"] = colors.Blue,

    -- Functions
    ["@function"] = { fg = c.blue, fmt = cfg.code_style.functions },
    ["@function.builtin"] = { fg = c.cyan, fmt = cfg.code_style.functions },
    ["@function.call"] = { fg = c.blue, fmt = cfg.code_style.functions },
    ["@function.macro"] = { fg = c.cyan, fmt = cfg.code_style.functions },
    ["@function.method"] = { fg = c.blue, fmt = cfg.code_style.functions },
    ["@function.method.call"] = { fg = c.blue, fmt = cfg.code_style.functions },

    -- Keywords
    ["@keyword"] = { fg = c.purple, fmt = cfg.code_style.keywords },
    ["@keyword.conditional"] = { fg = c.purple, fmt = cfg.code_style.keywords },
    ["@keyword.conditional.ternary"] = { fg = c.purple, fmt = cfg.code_style.keywords },
    ["@keyword.coroutine"] = { fg = c.purple, fmt = cfg.code_style.keywords },
    ["@keyword.debug"] = { fg = c.red, fmt = cfg.code_style.keywords },
    ["@keyword.directive"] = colors.Purple,
    ["@keyword.directive.define"] = colors.Purple,
    ["@keyword.exception"] = colors.Purple,
    ["@keyword.function"] = { fg = c.purple, fmt = cfg.code_style.functions },
    ["@keyword.import"] = colors.Purple,
    ["@keyword.modifier"] = { fg = c.purple, fmt = cfg.code_style.keywords },
    ["@keyword.operator"] = { fg = c.purple, fmt = cfg.code_style.keywords },
    ["@keyword.repeat"] = { fg = c.purple, fmt = cfg.code_style.keywords },
    ["@keyword.return"] = { fg = c.purple, fmt = cfg.code_style.keywords },
    ["@keyword.type"] = { fg = c.purple, fmt = cfg.code_style.keywords },

    -- Labels
    ["@label"] = colors.Red,

    -- Markup (Markdown, etc.)
    ["@markup.strong"] = { fg = c.fg, fmt = "bold" },
    ["@markup.italic"] = { fg = c.fg, fmt = "italic" },
    ["@markup.strikethrough"] = { fg = c.fg, fmt = "strikethrough" },
    ["@markup.underline"] = { fg = c.fg, fmt = "underline" },
    ["@markup.heading"] = { fg = c.orange, fmt = "bold" },
    ["@markup.heading.1"] = { fg = c.red, fmt = "bold" },
    ["@markup.heading.2"] = { fg = c.purple, fmt = "bold" },
    ["@markup.heading.3"] = { fg = c.orange, fmt = "bold" },
    ["@markup.heading.4"] = { fg = c.red, fmt = "bold" },
    ["@markup.heading.5"] = { fg = c.purple, fmt = "bold" },
    ["@markup.heading.6"] = { fg = c.orange, fmt = "bold" },
    ["@markup.link"] = colors.Blue,
    ["@markup.link.label"] = colors.Cyan,
    ["@markup.link.url"] = { fg = c.cyan, fmt = "underline" },
    ["@markup.list"] = colors.Red,
    ["@markup.list.checked"] = { fg = c.green, fmt = cfg.code_style.comments },
    ["@markup.list.unchecked"] = { fg = c.red, fmt = cfg.code_style.comments },
    ["@markup.math"] = colors.Fg,
    ["@markup.quote"] = { fg = c.grey, fmt = "italic" },
    ["@markup.raw"] = colors.Green,
    ["@markup.raw.block"] = colors.Green,

    -- Modules
    ["@module"] = colors.Yellow,
    ["@module.builtin"] = colors.Orange,

    -- Misc
    ["@none"] = colors.Fg,
    ["@conceal"] = colors.Grey,

    -- Operators
    ["@operator"] = colors.Fg,

    -- Properties
    ["@property"] = colors.Cyan,

    -- Punctuation
    ["@punctuation.bracket"] = colors.LightGrey,
    ["@punctuation.delimiter"] = colors.LightGrey,
    ["@punctuation.special"] = colors.Red,

    -- Strings
    ["@string"] = { fg = c.green, fmt = cfg.code_style.strings },
    ["@string.documentation"] = { fg = c.green, fmt = cfg.code_style.strings },
    ["@string.escape"] = { fg = c.red, fmt = cfg.code_style.strings },
    ["@string.regexp"] = { fg = c.orange, fmt = cfg.code_style.strings },
    ["@string.special"] = { fg = c.dark_cyan, fmt = cfg.code_style.strings },
    ["@string.special.path"] = { fg = c.green, fmt = cfg.code_style.strings },
    ["@string.special.symbol"] = colors.Cyan,
    ["@string.special.url"] = { fg = c.cyan, fmt = "underline" },

    -- Tags (HTML, JSX, TSX, XML)
    ["@tag"] = colors.Purple,
    ["@tag.builtin"] = colors.Purple,
    ["@tag.attribute"] = colors.Yellow,
    ["@tag.delimiter"] = colors.Purple,

    -- Types
    ["@type"] = colors.Yellow,
    ["@type.builtin"] = colors.Orange,
    ["@type.definition"] = colors.Yellow,

    -- Variables
    ["@variable"] = { fg = c.fg, fmt = cfg.code_style.variables },
    ["@variable.builtin"] = { fg = c.red, fmt = cfg.code_style.variables },
    ["@variable.member"] = colors.Cyan,
    ["@variable.parameter"] = colors.Red,
    ["@variable.parameter.builtin"] = { fg = c.orange, fmt = cfg.code_style.variables },
  }
  if vim.api.nvim_call_function("has", { "nvim-0.9" }) == 1 then
    hl.lsp = {
      ["@lsp.type.comment"] = hl.treesitter["@comment"],
      ["@lsp.type.enum"] = hl.treesitter["@type"],
      ["@lsp.type.enumMember"] = hl.treesitter["@constant.builtin"],
      ["@lsp.type.interface"] = hl.treesitter["@type"],
      ["@lsp.type.typeParameter"] = hl.treesitter["@type"],
      ["@lsp.type.keyword"] = hl.treesitter["@keyword"],
      ["@lsp.type.namespace"] = hl.treesitter["@module"],
      ["@lsp.type.parameter"] = hl.treesitter["@variable.parameter"],
      ["@lsp.type.property"] = hl.treesitter["@property"],
      ["@lsp.type.variable"] = hl.treesitter["@variable"],
      ["@lsp.type.macro"] = hl.treesitter["@function.macro"],
      ["@lsp.type.method"] = hl.treesitter["@function.method"],
      ["@lsp.type.number"] = hl.treesitter["@number"],
      ["@lsp.type.generic"] = colors.Fg,
      ["@lsp.type.builtinType"] = hl.treesitter["@type.builtin"],
      ["@lsp.typemod.method.defaultLibrary"] = hl.treesitter["@function"],
      ["@lsp.typemod.function.defaultLibrary"] = hl.treesitter["@function"],
      ["@lsp.typemod.operator.injected"] = hl.treesitter["@operator"],
      ["@lsp.typemod.string.injected"] = hl.treesitter["@string"],
      ["@lsp.typemod.variable.defaultLibrary"] = hl.treesitter["@variable.builtin"],
      ["@lsp.typemod.variable.injected"] = hl.treesitter["@variable"],
      ["@lsp.typemod.variable.static"] = hl.treesitter["@constant"],
    }
  end
else
  hl.treesitter = {
    TSAnnotation = colors.Fg,
    TSAttribute = colors.Cyan,
    TSBoolean = colors.Orange,
    TSCharacter = colors.Orange,
    TSComment = { fg = c.grey, fmt = cfg.code_style.comments },
    TSConditional = { fg = c.purple, fmt = cfg.code_style.keywords },
    TSConstant = colors.Orange,
    TSConstBuiltin = colors.Orange,
    TSConstMacro = colors.Orange,
    TSConstructor = { fg = c.yellow, fmt = "bold" },
    TSError = colors.Fg,
    TSException = colors.Purple,
    TSField = colors.Cyan,
    TSFloat = colors.Orange,
    TSFunction = { fg = c.blue, fmt = cfg.code_style.functions },
    TSFuncBuiltin = { fg = c.cyan, fmt = cfg.code_style.functions },
    TSFuncMacro = { fg = c.cyan, fmt = cfg.code_style.functions },
    TSInclude = colors.Purple,
    TSKeyword = { fg = c.purple, fmt = cfg.code_style.keywords },
    TSKeywordFunction = { fg = c.purple, fmt = cfg.code_style.functions },
    TSKeywordOperator = { fg = c.purple, fmt = cfg.code_style.keywords },
    TSLabel = colors.Red,
    TSMethod = { fg = c.blue, fmt = cfg.code_style.functions },
    TSNamespace = colors.Yellow,
    TSNone = colors.Fg,
    TSNumber = colors.Orange,
    TSOperator = colors.Fg,
    TSParameter = colors.Red,
    TSParameterReference = colors.Fg,
    TSProperty = colors.Cyan,
    TSPunctDelimiter = colors.LightGrey,
    TSPunctBracket = colors.LightGrey,
    TSPunctSpecial = colors.Red,
    TSRepeat = { fg = c.purple, fmt = cfg.code_style.keywords },
    TSString = { fg = c.green, fmt = cfg.code_style.strings },
    TSStringRegex = { fg = c.orange, fmt = cfg.code_style.strings },
    TSStringEscape = { fg = c.red, fmt = cfg.code_style.strings },
    TSSymbol = colors.Cyan,
    TSTag = colors.Purple,
    TSTagDelimiter = colors.Purple,
    TSText = colors.Fg,
    TSStrong = { fg = c.fg, fmt = "bold" },
    TSEmphasis = { fg = c.fg, fmt = "italic" },
    TSUnderline = { fg = c.fg, fmt = "underline" },
    TSStrike = { fg = c.fg, fmt = "strikethrough" },
    TSTitle = { fg = c.orange, fmt = "bold" },
    TSLiteral = colors.Green,
    TSURI = { fg = c.cyan, fmt = "underline" },
    TSMath = colors.Fg,
    TSTextReference = colors.Blue,
    TSEnvironment = colors.Fg,
    TSEnvironmentName = colors.Fg,
    TSNote = colors.Fg,
    TSWarning = colors.Fg,
    TSDanger = colors.Fg,
    TSType = colors.Yellow,
    TSTypeBuiltin = colors.Orange,
    TSVariable = { fg = c.fg, fmt = cfg.code_style.variables },
    TSVariableBuiltin = { fg = c.red, fmt = cfg.code_style.variables },
  }
end

local diagnostics_error_color = cfg.diagnostics.darker and c.dark_red or c.red
local diagnostics_hint_color = cfg.diagnostics.darker and c.dark_purple or c.purple
local diagnostics_warn_color = cfg.diagnostics.darker and c.dark_yellow or c.yellow
local diagnostics_info_color = cfg.diagnostics.darker and c.dark_cyan or c.cyan

hl.plugins.lsp = {
  LspCxxHlGroupEnumConstant = colors.Orange,
  LspCxxHlGroupMemberVariable = colors.Orange,
  LspCxxHlGroupNamespace = colors.Blue,
  LspCxxHlSkippedRegion = colors.Grey,
  LspCxxHlSkippedRegionBeginEnd = colors.Red,

  DiagnosticError = { fg = c.red },
  DiagnosticHint = { fg = c.purple },
  DiagnosticInfo = { fg = c.cyan },
  DiagnosticWarn = { fg = c.yellow },
  DiagnosticOk = { fg = c.green },
  DiagnosticUnnecessary = { fg = c.grey },
  DiagnosticDeprecated = { fg = c.orange, fmt = "strikethrough" },

  DiagnosticVirtualTextError = {
    bg = cfg.diagnostics.background and util.darken(diagnostics_error_color, 0.1, c.bg0) or c.none,
    fg = diagnostics_error_color,
  },
  DiagnosticVirtualTextWarn = {
    bg = cfg.diagnostics.background and util.darken(diagnostics_warn_color, 0.1, c.bg0) or c.none,
    fg = diagnostics_warn_color,
  },
  DiagnosticVirtualTextInfo = {
    bg = cfg.diagnostics.background and util.darken(diagnostics_info_color, 0.1, c.bg0) or c.none,
    fg = diagnostics_info_color,
  },
  DiagnosticVirtualTextHint = {
    bg = cfg.diagnostics.background and util.darken(diagnostics_hint_color, 0.1, c.bg0) or c.none,
    fg = diagnostics_hint_color,
  },
  DiagnosticVirtualTextOk = {
    bg = cfg.diagnostics.background and util.darken(c.green, 0.1, c.bg0) or c.none,
    fg = c.green,
  },
  DiagnosticVirtualTextUnnecessary = {
    bg = cfg.diagnostics.background and util.darken(c.grey, 0.1, c.bg0) or c.none,
    fg = c.grey,
  },
  DiagnosticVirtualTextDeprecated = {
    bg = cfg.diagnostics.background and util.darken(c.orange, 0.1, c.bg0) or c.none,
    fg = c.orange,
    fmt = "strikethrough",
  },

  DiagnosticUnderlineError = { fmt = cfg.diagnostics.undercurl and "undercurl" or "underline", sp = c.red },
  DiagnosticUnderlineHint = { fmt = cfg.diagnostics.undercurl and "undercurl" or "underline", sp = c.purple },
  DiagnosticUnderlineInfo = { fmt = cfg.diagnostics.undercurl and "undercurl" or "underline", sp = c.blue },
  DiagnosticUnderlineWarn = { fmt = cfg.diagnostics.undercurl and "undercurl" or "underline", sp = c.yellow },
  DiagnosticUnderlineOk = { fmt = cfg.diagnostics.undercurl and "undercurl" or "underline", sp = c.green },
  DiagnosticUnderlineUnnecessary = { fmt = cfg.diagnostics.undercurl and "undercurl" or "underline", sp = c.grey },
  DiagnosticUnderlineDeprecated = { fmt = "strikethrough", sp = c.orange },

  LspReferenceText = { bg = c.bg2 },
  LspReferenceWrite = { bg = c.bg2 },
  LspReferenceRead = { bg = c.bg2 },

  LspCodeLens = { fg = c.grey, fmt = cfg.code_style.comments },
  LspCodeLensSeparator = { fg = c.grey },
}

hl.plugins.lsp.LspDiagnosticsDefaultError = hl.plugins.lsp.DiagnosticError
hl.plugins.lsp.LspDiagnosticsDefaultHint = hl.plugins.lsp.DiagnosticHint
hl.plugins.lsp.LspDiagnosticsDefaultInformation = hl.plugins.lsp.DiagnosticInfo
hl.plugins.lsp.LspDiagnosticsDefaultWarning = hl.plugins.lsp.DiagnosticWarn
hl.plugins.lsp.LspDiagnosticsUnderlineError = hl.plugins.lsp.DiagnosticUnderlineError
hl.plugins.lsp.LspDiagnosticsUnderlineHint = hl.plugins.lsp.DiagnosticUnderlineHint
hl.plugins.lsp.LspDiagnosticsUnderlineInformation = hl.plugins.lsp.DiagnosticUnderlineInfo
hl.plugins.lsp.LspDiagnosticsUnderlineWarning = hl.plugins.lsp.DiagnosticUnderlineWarn
hl.plugins.lsp.LspDiagnosticsVirtualTextError = hl.plugins.lsp.DiagnosticVirtualTextError
hl.plugins.lsp.LspDiagnosticsVirtualTextWarning = hl.plugins.lsp.DiagnosticVirtualTextWarn
hl.plugins.lsp.LspDiagnosticsVirtualTextInformation = hl.plugins.lsp.DiagnosticVirtualTextInfo
hl.plugins.lsp.LspDiagnosticsVirtualTextHint = hl.plugins.lsp.DiagnosticVirtualTextHint

hl.plugins.cmp = {
  CmpItemAbbr = colors.Fg,
  CmpItemAbbrDeprecated = { fg = c.light_grey, fmt = "strikethrough" },
  CmpItemAbbrMatch = colors.Cyan,
  CmpItemAbbrMatchFuzzy = { fg = c.cyan, fmt = "underline" },
  CmpItemMenu = colors.LightGrey,
  CmpItemKind = { fg = c.purple, fmt = cfg.cmp_itemkind_reverse and "reverse" },
}

hl.plugins.blink = {
  BlinkCmpLabel = colors.Fg,
  BlinkCmpLabelDeprecated = { fg = c.light_grey, fmt = "strikethrough" },
  BlinkCmpLabelMatch = colors.Cyan,
  BlinkCmpDetail = colors.LightGrey,
  BlinkCmpKind = { fg = c.purple },
}

hl.plugins.whichkey = {
  WhichKey = colors.Red,
  WhichKeyDesc = colors.Blue,
  WhichKeyGroup = colors.Orange,
  WhichKeySeparator = colors.Green,
}

hl.plugins.gitgutter = {
  GitGutterAdd = { fg = c.green },
  GitGutterChange = { fg = c.blue },
  GitGutterDelete = { fg = c.red },
}

hl.plugins.gitsigns = {
  GitSignsAdd = colors.Green,
  GitSignsAddLn = colors.Green,
  GitSignsAddNr = colors.Green,
  GitSignsChange = colors.Blue,
  GitSignsChangeLn = colors.Blue,
  GitSignsChangeNr = colors.Blue,
  GitSignsDelete = colors.Red,
  GitSignsDeleteLn = colors.Red,
  GitSignsDeleteNr = colors.Red,
}

hl.plugins.nvim_tree = {
  NvimTreeNormal = { fg = c.fg, bg = cfg.transparent and c.none or c.bg_d },
  NvimTreeNormalFloat = { fg = c.fg, bg = cfg.transparent and c.none or c.bg_d },
  NvimTreeVertSplit = { fg = c.bg_d, bg = cfg.transparent and c.none or c.bg_d },
  NvimTreeEndOfBuffer = { fg = cfg.ending_tildes and c.bg2 or c.bg_d, bg = cfg.transparent and c.none or c.bg_d },
  NvimTreeRootFolder = { fg = c.orange, fmt = "bold" },
  NvimTreeGitDirty = colors.Yellow,
  NvimTreeGitNew = colors.Green,
  NvimTreeGitDeleted = colors.Red,
  NvimTreeSpecialFile = { fg = c.yellow, fmt = "underline" },
  NvimTreeIndentMarker = colors.Fg,
  NvimTreeImageFile = { fg = c.dark_purple },
  NvimTreeSymlink = colors.Purple,
  NvimTreeFolderName = colors.Blue,
}

hl.plugins.neo_tree = {
  NeoTreeNormal = { fg = c.fg, bg = cfg.transparent and c.none or c.bg_d },
  NeoTreeNormalNC = { fg = c.fg, bg = cfg.transparent and c.none or c.bg_d },
  NeoTreeVertSplit = { fg = c.bg1, bg = cfg.transparent and c.none or c.bg1 },
  NeoTreeWinSeparator = { fg = c.bg1, bg = cfg.transparent and c.none or c.bg1 },
  NeoTreeEndOfBuffer = { fg = cfg.ending_tildes and c.bg2 or c.bg_d, bg = cfg.transparent and c.none or c.bg_d },
  NeoTreeRootName = { fg = c.orange, fmt = "bold" },
  NeoTreeGitAdded = colors.Green,
  NeoTreeGitDeleted = colors.Red,
  NeoTreeGitModified = colors.Yellow,
  NeoTreeGitConflict = { fg = c.red, fmt = "bold,italic" },
  NeoTreeGitUntracked = { fg = c.red, fmt = "italic" },
  NeoTreeIndentMarker = colors.Grey,
  NeoTreeSymbolicLinkTarget = colors.Purple,
}

hl.plugins.telescope = {
  TelescopeBorder = colors.Red,
  TelescopePromptBorder = colors.Cyan,
  TelescopeResultsBorder = colors.Cyan,
  TelescopePreviewBorder = colors.Cyan,
  TelescopeMatching = { fg = c.orange, fmt = "bold" },
  TelescopePromptPrefix = colors.Green,
  TelescopeSelection = { bg = c.bg2 },
  TelescopeSelectionCaret = colors.Yellow,
}

hl.plugins.dashboard = {
  DashboardShortCut = colors.Blue,
  DashboardHeader = colors.Yellow,
  DashboardCenter = colors.Cyan,
  DashboardFooter = { fg = c.dark_red, fmt = "italic" },
}

hl.plugins.indent_blankline = {
  IndentBlanklineIndent1 = colors.Blue,
  IndentBlanklineIndent2 = colors.Green,
  IndentBlanklineIndent3 = colors.Cyan,
  IndentBlanklineIndent4 = colors.LightGrey,
  IndentBlanklineIndent5 = colors.Purple,
  IndentBlanklineIndent6 = colors.Red,
  IndentBlanklineChar = { fg = c.bg1, fmt = "nocombine" },
  IndentBlanklineContextChar = { fg = c.grey, fmt = "nocombine" },
  IndentBlanklineContextStart = { sp = c.grey, fmt = "underline" },
  IndentBlanklineContextSpaceChar = { fmt = "nocombine" },
  -- Ibl v3
  IblIndent = { fg = c.bg1, fmt = "nocombine" },
  IblWhitespace = { fg = c.bg1, fmt = "nocombine" },
  IblScope = { fg = c.purple, fmt = "nocombine" },
}

hl.plugins.rainbow_delimiters = {
  RainbowDelimiterRed = colors.Red,
  RainbowDelimiterYellow = colors.Yellow,
  RainbowDelimiterBlue = colors.Blue,
  RainbowDelimiterOrange = colors.Orange,
  RainbowDelimiterGreen = colors.Green,
  RainbowDelimiterViolet = colors.Purple,
  RainbowDelimiterCyan = colors.Cyan,
}

hl.plugins.mini = {
  MiniAnimateCursor = { fmt = "reverse,nocombine" },
  MiniAnimateNormalFloat = hl.common.NormalFloat,
  MiniCursorword = { fmt = "underline" },
  MiniCursorwordCurrent = { fmt = "underline" },
  MiniDiffSignAdd = colors.Green,
  MiniDiffSignChange = colors.Blue,
  MiniDiffSignDelete = colors.Red,
  MiniIndentscopeSymbol = { fg = c.grey },
  MiniIndentscopePrefix = { fmt = "nocombine" },
  MiniJump = { fg = c.purple, fmt = "underline", sp = c.purple },
  MiniStarterCurrent = { fmt = "nocombine" },
  MiniStarterFooter = { fg = c.dark_red, fmt = "italic" },
  MiniStarterHeader = colors.Yellow,
  MiniStarterInactive = { fg = c.grey, fmt = cfg.code_style.comments },
  MiniStarterItem = { fg = c.fg, bg = cfg.transparent and c.none or c.bg0 },
  MiniStarterItemBullet = { fg = c.grey },
  MiniStarterItemPrefix = { fg = c.yellow },
  MiniStarterSection = colors.LightGrey,
  MiniStarterQuery = { fg = c.cyan },
  MiniStatuslineDevinfo = { fg = c.fg, bg = c.bg2 },
  MiniStatuslineFileinfo = { fg = c.fg, bg = c.bg2 },
  MiniStatuslineFilename = { fg = c.grey, bg = c.bg1 },
  MiniStatuslineInactive = hl.common.StatusLineNC,
  MiniStatuslineModeCommand = { fg = c.bg0, bg = c.yellow, fmt = "bold" },
  MiniStatuslineModeInsert = { fg = c.bg0, bg = c.blue, fmt = "bold" },
  MiniStatuslineModeNormal = { fg = c.bg0, bg = c.green, fmt = "bold" },
  MiniStatuslineModeOther = { fg = c.bg0, bg = c.cyan, fmt = "bold" },
  MiniStatuslineModeReplace = { fg = c.bg0, bg = c.red, fmt = "bold" },
  MiniStatuslineModeVisual = { fg = c.bg0, bg = c.purple, fmt = "bold" },
  MiniSurround = { fg = c.bg0, bg = c.orange },
  MiniTablineCurrent = { fmt = "bold" },
  MiniTablineFill = { fg = c.grey, bg = c.bg1 },
  MiniTablineHidden = { fg = c.fg, bg = c.bg1 },
  MiniTablineModifiedCurrent = { fg = c.orange, fmt = "bold,italic" },
  MiniTablineModifiedHidden = { fg = c.light_grey, bg = c.bg1, fmt = "italic" },
  MiniTablineModifiedVisible = { fg = c.yellow, bg = c.bg0, fmt = "italic" },
  MiniTablineTabpagesection = { fg = c.bg0, bg = c.bg_yellow },
  MiniTablineVisible = { fg = c.light_grey, bg = c.bg0 },
  MiniTrailspace = { bg = c.red },
}

hl.plugins.illuminate = {
  illuminatedWord = { bg = c.bg2, fmt = "bold" },
  illuminatedCurWord = { bg = c.bg2, fmt = "bold" },
  IlluminatedWordText = { bg = c.bg2, fmt = "bold" },
  IlluminatedWordRead = { bg = c.bg2, fmt = "bold" },
  IlluminatedWordWrite = { bg = c.bg2, fmt = "bold" },
}

hl.langs.markdown = {
  markdownBlockquote = colors.Grey,
  markdownBold = { fg = c.none, fmt = "bold" },
  markdownBoldDelimiter = colors.Grey,
  markdownCode = colors.Green,
  markdownCodeBlock = colors.Green,
  markdownCodeDelimiter = colors.Yellow,
  markdownH1 = { fg = c.red, fmt = "bold" },
  markdownH2 = { fg = c.purple, fmt = "bold" },
  markdownH3 = { fg = c.orange, fmt = "bold" },
  markdownH4 = { fg = c.red, fmt = "bold" },
  markdownH5 = { fg = c.purple, fmt = "bold" },
  markdownH6 = { fg = c.orange, fmt = "bold" },
  markdownHeadingDelimiter = colors.Grey,
  markdownHeadingRule = colors.Grey,
  markdownId = colors.Yellow,
  markdownIdDeclaration = colors.Red,
  markdownItalic = { fg = c.none, fmt = "italic" },
  markdownItalicDelimiter = { fg = c.grey, fmt = "italic" },
  markdownLinkDelimiter = colors.Grey,
  markdownLinkText = colors.Red,
  markdownLinkTextDelimiter = colors.Grey,
  markdownListMarker = colors.Red,
  markdownOrderedListMarker = colors.Red,
  markdownRule = colors.Purple,
  markdownUrl = { fg = c.blue, fmt = "underline" },
  markdownUrlDelimiter = colors.Grey,
  markdownUrlTitleDelimiter = colors.Green,
}

hl.langs.vim = {
  vimOption = colors.Red,
  vimSetEqual = colors.Yellow,
  vimMap = colors.Purple,
  vimMapModKey = colors.Orange,
  vimNotation = colors.Red,
  vimMapLhs = colors.Fg,
  vimMapRhs = colors.Blue,
  vimVar = { fg = c.fg, fmt = cfg.code_style.variables },
  vimCommentTitle = { fg = c.light_grey, fmt = cfg.code_style.comments },
}

local lsp_kind_icons_color = {
  Default = c.purple,
  Array = c.yellow,
  Boolean = c.orange,
  Class = c.yellow,
  Color = c.green,
  Constant = c.orange,
  Constructor = c.blue,
  Enum = c.purple,
  EnumMember = c.yellow,
  Event = c.yellow,
  Field = c.purple,
  File = c.blue,
  Folder = c.orange,
  Function = c.blue,
  Interface = c.green,
  Key = c.cyan,
  Keyword = c.cyan,
  Method = c.blue,
  Module = c.orange,
  Namespace = c.red,
  Null = c.grey,
  Number = c.orange,
  Object = c.red,
  Operator = c.red,
  Package = c.yellow,
  Property = c.cyan,
  Reference = c.orange,
  Snippet = c.red,
  String = c.green,
  Struct = c.purple,
  Text = c.light_grey,
  TypeParameter = c.red,
  Unit = c.green,
  Value = c.orange,
  Variable = c.purple,
}

function M.setup()
  -- define cmp kind highlights with lsp_kind_icons_color
  for kind, color in pairs(lsp_kind_icons_color) do
    hl.plugins.cmp["CmpItemKind" .. kind] = { fg = color, fmt = cfg.cmp_itemkind_reverse and "reverse" }
    hl.plugins.blink["BlinkCmpKind" .. kind] = { fg = color }
  end

  vim_highlights(hl.common)
  vim_highlights(hl.syntax)
  vim_highlights(hl.treesitter)
  if hl.lsp then
    vim_highlights(hl.lsp)
  end
  for _, group in pairs(hl.langs) do
    vim_highlights(group)
  end
  for _, group in pairs(hl.plugins) do
    vim_highlights(group)
  end

  -- User defined highlights
  local function replace_color(prefix, color_name)
    if not color_name then
      return ""
    end
    if color_name:sub(1, 1) == "$" then
      local name = color_name:sub(2, -1)
      color_name = c[name]
      if not color_name then
        vim.schedule(function()
          vim.notify('drift.nvim: unknown color "' .. name .. '"', vim.log.levels.ERROR, { title = "drift.nvim" })
        end)
        return ""
      end
    end
    return prefix .. "=" .. color_name
  end

  for group_name, group_settings in pairs(vim.g.drift_config.highlights) do
    vim.api.nvim_command(
      string.format(
        "highlight %s %s %s %s %s",
        group_name,
        replace_color("guifg", group_settings.fg),
        replace_color("guibg", group_settings.bg),
        replace_color("guisp", group_settings.sp),
        replace_color("gui", group_settings.fmt)
      )
    )
  end
end

return M
