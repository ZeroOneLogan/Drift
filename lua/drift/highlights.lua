-- =============================================================================
-- DRIFT COLORSCHEME - HIGHLIGHTS
-- A world-class, semantic highlighting system
-- =============================================================================

local c = require("drift.colors")
local util = require("drift.util")

local M = {}

-- Helper to get configuration
local function get_config()
  return vim.g.drift_config or {}
end

-- Helper to apply highlights
local function set_highlights(groups)
  for group, settings in pairs(groups) do
    if settings.link then
      vim.api.nvim_set_hl(0, group, { link = settings.link })
    else
      local hl = {}
      if settings.fg then hl.fg = settings.fg end
      if settings.bg then hl.bg = settings.bg end
      if settings.sp then hl.sp = settings.sp end
      if settings.bold then hl.bold = true end
      if settings.italic then hl.italic = true end
      if settings.underline then hl.underline = true end
      if settings.undercurl then hl.undercurl = true end
      if settings.underdouble then hl.underdouble = true end
      if settings.underdotted then hl.underdotted = true end
      if settings.underdashed then hl.underdashed = true end
      if settings.strikethrough then hl.strikethrough = true end
      if settings.reverse then hl.reverse = true end
      if settings.nocombine then hl.nocombine = true end
      if settings.blend then hl.blend = settings.blend end
      vim.api.nvim_set_hl(0, group, hl)
    end
  end
end

-- Main setup function
function M.setup()
  local cfg = get_config()
  local colors = c.get(cfg.style)
  colors = c.extend(colors)

  -- Transparency handling
  local bg = cfg.transparent and "NONE" or colors.bg0
  local bg_dark = cfg.transparent and "NONE" or colors.bg_dark
  local bg_float = cfg.transparent and "NONE" or colors.bg1

  -- Code style configuration
  local code_style = cfg.code_style or {}
  local comment_style = code_style.comments or { italic = true }
  local keyword_style = code_style.keywords or { italic = true }
  local function_style = code_style.functions or {}
  local string_style = code_style.strings or {}
  local variable_style = code_style.variables or {}
  local type_style = code_style.types or {}

  -- Diagnostic configuration
  local diag_cfg = cfg.diagnostics or {}
  local diag_undercurl = diag_cfg.undercurl ~= false
  local diag_background = diag_cfg.background ~= false

  -- ==========================================================================
  -- EDITOR UI
  -- ==========================================================================
  local editor = {
    -- Basic UI
    Normal = { fg = colors.fg1, bg = bg },
    NormalNC = { fg = colors.fg1, bg = cfg.transparent and "NONE" or colors.bg_dark },
    NormalFloat = { fg = colors.fg1, bg = bg_float },
    FloatBorder = { fg = colors.border, bg = bg_float },
    FloatTitle = { fg = colors.azure, bg = bg_float, bold = true },
    FloatFooter = { fg = colors.fg3, bg = bg_float },

    -- Cursor
    Cursor = { fg = colors.bg0, bg = colors.fg1 },
    lCursor = { link = "Cursor" },
    CursorIM = { link = "Cursor" },
    TermCursor = { fg = colors.bg0, bg = colors.azure },
    TermCursorNC = { fg = colors.bg0, bg = colors.fg3 },

    -- Line highlighting
    CursorLine = { bg = colors.bg1 },
    CursorLineNr = { fg = colors.amber, bold = true },
    CursorColumn = { bg = colors.bg1 },
    ColorColumn = { bg = colors.bg1 },

    -- Line numbers
    LineNr = { fg = colors.fg3 },
    LineNrAbove = { fg = colors.fg3 },
    LineNrBelow = { fg = colors.fg3 },
    SignColumn = { fg = colors.fg3, bg = bg },
    FoldColumn = { fg = colors.fg3, bg = bg },

    -- Folding
    Folded = { fg = colors.fg2, bg = colors.bg2, italic = true },

    -- Search
    Search = { fg = colors.bg0, bg = colors.amber },
    IncSearch = { fg = colors.bg0, bg = colors.coral },
    CurSearch = { fg = colors.bg0, bg = colors.rose },
    Substitute = { fg = colors.bg0, bg = colors.mauve },

    -- Visual mode
    Visual = { bg = colors.bg3 },
    VisualNOS = { bg = colors.bg3 },

    -- Matching
    MatchParen = { fg = colors.amber, bold = true, underline = true },

    -- Messages
    MsgArea = { fg = colors.fg1 },
    ModeMsg = { fg = colors.azure, bold = true },
    MoreMsg = { fg = colors.sage, bold = true },
    Question = { fg = colors.azure },
    ErrorMsg = { fg = colors.error, bold = true },
    WarningMsg = { fg = colors.warn, bold = true },

    -- Popup menu
    Pmenu = { fg = colors.fg1, bg = colors.bg2 },
    PmenuSel = { fg = colors.bg0, bg = colors.azure },
    PmenuSbar = { bg = colors.bg3 },
    PmenuThumb = { bg = colors.fg3 },
    PmenuKind = { fg = colors.iris },
    PmenuKindSel = { fg = colors.bg0, bg = colors.azure },
    PmenuExtra = { fg = colors.fg3 },
    PmenuExtraSel = { fg = colors.bg0, bg = colors.azure },

    -- Statusline
    StatusLine = { fg = colors.fg1, bg = colors.bg2 },
    StatusLineNC = { fg = colors.fg3, bg = colors.bg1 },
    StatusLineTerm = { fg = colors.fg1, bg = colors.bg2 },
    StatusLineTermNC = { fg = colors.fg3, bg = colors.bg1 },

    -- Tabline
    TabLine = { fg = colors.fg2, bg = colors.bg1 },
    TabLineFill = { bg = colors.bg0 },
    TabLineSel = { fg = colors.fg1, bg = colors.bg0, bold = true },

    -- Window
    WinBar = { fg = colors.fg1, bg = bg },
    WinBarNC = { fg = colors.fg3, bg = bg_dark },
    WinSeparator = { fg = colors.border },
    VertSplit = { fg = colors.border },

    -- Special characters
    NonText = { fg = colors.bg3 },
    EndOfBuffer = { fg = cfg.ending_tildes and colors.fg3 or colors.bg0 },
    SpecialKey = { fg = colors.fg3 },
    Whitespace = { fg = colors.bg3 },

    -- Spell
    SpellBad = { sp = colors.error, undercurl = true },
    SpellCap = { sp = colors.warn, undercurl = true },
    SpellLocal = { sp = colors.info, undercurl = true },
    SpellRare = { sp = colors.hint, undercurl = true },

    -- Diff
    DiffAdd = { bg = colors.diff_add },
    DiffChange = { bg = colors.diff_change },
    DiffDelete = { bg = colors.diff_delete },
    DiffText = { bg = colors.diff_text },

    -- Directory
    Directory = { fg = colors.azure, bold = true },

    -- Conceal
    Conceal = { fg = colors.fg3 },

    -- Title
    Title = { fg = colors.azure, bold = true },

    -- Wild menu
    WildMenu = { fg = colors.bg0, bg = colors.azure },

    -- Quick fix
    QuickFixLine = { bg = colors.bg2 },
    qfFileName = { fg = colors.azure },
    qfLineNr = { fg = colors.amber },

    -- Debug
    Debug = { fg = colors.coral },
    debugPC = { bg = colors.bg2 },
    debugBreakpoint = { fg = colors.mauve, bg = colors.bg1 },
  }

  -- ==========================================================================
  -- SYNTAX
  -- ==========================================================================
  local syntax = {
    -- Comments
    Comment = vim.tbl_extend("force", { fg = colors.comment }, comment_style),

    -- Constants
    Constant = { fg = colors.coral },
    String = vim.tbl_extend("force", { fg = colors.sage }, string_style),
    Character = { fg = colors.sage },
    Number = { fg = colors.coral },
    Boolean = { fg = colors.coral },
    Float = { fg = colors.coral },

    -- Identifiers
    Identifier = vim.tbl_extend("force", { fg = colors.rose }, variable_style),
    Function = vim.tbl_extend("force", { fg = colors.azure }, function_style),

    -- Statements
    Statement = vim.tbl_extend("force", { fg = colors.mauve }, keyword_style),
    Conditional = vim.tbl_extend("force", { fg = colors.mauve }, keyword_style),
    Repeat = vim.tbl_extend("force", { fg = colors.mauve }, keyword_style),
    Label = { fg = colors.mauve },
    Operator = { fg = colors.cyan },
    Keyword = vim.tbl_extend("force", { fg = colors.mauve }, keyword_style),
    Exception = vim.tbl_extend("force", { fg = colors.mauve }, keyword_style),

    -- Preprocessor
    PreProc = { fg = colors.iris },
    Include = { fg = colors.iris },
    Define = { fg = colors.iris },
    Macro = { fg = colors.iris },
    PreCondit = { fg = colors.iris },

    -- Types
    Type = vim.tbl_extend("force", { fg = colors.amber }, type_style),
    StorageClass = { fg = colors.amber },
    Structure = { fg = colors.amber },
    Typedef = { fg = colors.amber },

    -- Special
    Special = { fg = colors.mint },
    SpecialChar = { fg = colors.mint },
    Tag = { fg = colors.azure },
    Delimiter = { fg = colors.fg2 },
    SpecialComment = { fg = colors.lavender, italic = true },

    -- Underlined
    Underlined = { fg = colors.azure, underline = true },

    -- Bold and Italic
    Bold = { bold = true },
    Italic = { italic = true },

    -- Ignore and Error
    Ignore = { fg = colors.fg3 },
    Error = { fg = colors.error },
    Todo = { fg = colors.bg0, bg = colors.amber, bold = true },

    -- Added (for diff)
    Added = { fg = colors.git_add },
    Changed = { fg = colors.git_change },
    Removed = { fg = colors.git_delete },
  }

  -- ==========================================================================
  -- DIAGNOSTICS
  -- ==========================================================================
  local diagnostics = {
    -- Virtual text
    DiagnosticError = { fg = colors.error },
    DiagnosticWarn = { fg = colors.warn },
    DiagnosticInfo = { fg = colors.info },
    DiagnosticHint = { fg = colors.hint },
    DiagnosticOk = { fg = colors.ok },

    -- Underline
    DiagnosticUnderlineError = { sp = colors.error, undercurl = diag_undercurl, underline = not diag_undercurl },
    DiagnosticUnderlineWarn = { sp = colors.warn, undercurl = diag_undercurl, underline = not diag_undercurl },
    DiagnosticUnderlineInfo = { sp = colors.info, undercurl = diag_undercurl, underline = not diag_undercurl },
    DiagnosticUnderlineHint = { sp = colors.hint, undercurl = diag_undercurl, underline = not diag_undercurl },
    DiagnosticUnderlineOk = { sp = colors.ok, undercurl = diag_undercurl, underline = not diag_undercurl },

    -- Virtual text (specific)
    DiagnosticVirtualTextError = { fg = colors.error, bg = diag_background and colors.error_bg or "NONE" },
    DiagnosticVirtualTextWarn = { fg = colors.warn, bg = diag_background and colors.warn_bg or "NONE" },
    DiagnosticVirtualTextInfo = { fg = colors.info, bg = diag_background and colors.info_bg or "NONE" },
    DiagnosticVirtualTextHint = { fg = colors.hint, bg = diag_background and colors.hint_bg or "NONE" },
    DiagnosticVirtualTextOk = { fg = colors.ok, bg = diag_background and colors.ok_bg or "NONE" },

    -- Floating window
    DiagnosticFloatingError = { fg = colors.error },
    DiagnosticFloatingWarn = { fg = colors.warn },
    DiagnosticFloatingInfo = { fg = colors.info },
    DiagnosticFloatingHint = { fg = colors.hint },
    DiagnosticFloatingOk = { fg = colors.ok },

    -- Signs
    DiagnosticSignError = { fg = colors.error },
    DiagnosticSignWarn = { fg = colors.warn },
    DiagnosticSignInfo = { fg = colors.info },
    DiagnosticSignHint = { fg = colors.hint },
    DiagnosticSignOk = { fg = colors.ok },

    -- Deprecated and unnecessary
    DiagnosticDeprecated = { fg = colors.fg3, strikethrough = true },
    DiagnosticUnnecessary = { fg = colors.fg3, italic = true },
  }

  -- ==========================================================================
  -- TREESITTER
  -- ==========================================================================
  local treesitter = {
    -- Identifiers
    ["@variable"] = vim.tbl_extend("force", { fg = colors.fg1 }, variable_style),
    ["@variable.builtin"] = { fg = colors.rose, italic = true },
    ["@variable.parameter"] = { fg = colors.rose },
    ["@variable.parameter.builtin"] = { fg = colors.rose, italic = true },
    ["@variable.member"] = { fg = colors.cyan },

    -- Constants
    ["@constant"] = { fg = colors.coral },
    ["@constant.builtin"] = { fg = colors.coral, italic = true },
    ["@constant.macro"] = { fg = colors.coral },

    -- Modules
    ["@module"] = { fg = colors.lavender },
    ["@module.builtin"] = { fg = colors.lavender, italic = true },

    -- Labels
    ["@label"] = { fg = colors.mauve },

    -- Strings
    ["@string"] = vim.tbl_extend("force", { fg = colors.sage }, string_style),
    ["@string.documentation"] = { fg = colors.sage, italic = true },
    ["@string.regexp"] = { fg = colors.mint },
    ["@string.escape"] = { fg = colors.mint, bold = true },
    ["@string.special"] = { fg = colors.mint },
    ["@string.special.symbol"] = { fg = colors.amber },
    ["@string.special.path"] = { fg = colors.azure },
    ["@string.special.url"] = { fg = colors.azure, underline = true },

    -- Characters
    ["@character"] = { fg = colors.sage },
    ["@character.special"] = { fg = colors.mint },

    -- Booleans
    ["@boolean"] = { fg = colors.coral },

    -- Numbers
    ["@number"] = { fg = colors.coral },
    ["@number.float"] = { fg = colors.coral },

    -- Types
    ["@type"] = vim.tbl_extend("force", { fg = colors.amber }, type_style),
    ["@type.builtin"] = { fg = colors.amber, italic = true },
    ["@type.definition"] = { fg = colors.amber },
    ["@type.qualifier"] = { fg = colors.mauve, italic = true },

    -- Attributes
    ["@attribute"] = { fg = colors.iris },
    ["@attribute.builtin"] = { fg = colors.iris, italic = true },

    -- Properties
    ["@property"] = { fg = colors.cyan },

    -- Functions
    ["@function"] = vim.tbl_extend("force", { fg = colors.azure }, function_style),
    ["@function.builtin"] = { fg = colors.azure, italic = true },
    ["@function.call"] = vim.tbl_extend("force", { fg = colors.azure }, function_style),
    ["@function.macro"] = { fg = colors.iris },
    ["@function.method"] = vim.tbl_extend("force", { fg = colors.azure }, function_style),
    ["@function.method.call"] = vim.tbl_extend("force", { fg = colors.azure }, function_style),

    -- Constructors
    ["@constructor"] = { fg = colors.amber },

    -- Operators
    ["@operator"] = { fg = colors.cyan },

    -- Keywords
    ["@keyword"] = vim.tbl_extend("force", { fg = colors.mauve }, keyword_style),
    ["@keyword.coroutine"] = vim.tbl_extend("force", { fg = colors.mauve }, keyword_style),
    ["@keyword.function"] = vim.tbl_extend("force", { fg = colors.mauve }, keyword_style),
    ["@keyword.operator"] = { fg = colors.mauve },
    ["@keyword.import"] = { fg = colors.iris },
    ["@keyword.type"] = { fg = colors.mauve },
    ["@keyword.modifier"] = { fg = colors.mauve, italic = true },
    ["@keyword.repeat"] = vim.tbl_extend("force", { fg = colors.mauve }, keyword_style),
    ["@keyword.return"] = vim.tbl_extend("force", { fg = colors.mauve }, keyword_style),
    ["@keyword.debug"] = { fg = colors.coral },
    ["@keyword.exception"] = vim.tbl_extend("force", { fg = colors.mauve }, keyword_style),
    ["@keyword.conditional"] = vim.tbl_extend("force", { fg = colors.mauve }, keyword_style),
    ["@keyword.conditional.ternary"] = { fg = colors.mauve },
    ["@keyword.directive"] = { fg = colors.iris },
    ["@keyword.directive.define"] = { fg = colors.iris },

    -- Punctuation
    ["@punctuation.delimiter"] = { fg = colors.fg2 },
    ["@punctuation.bracket"] = { fg = colors.fg2 },
    ["@punctuation.special"] = { fg = colors.mint },

    -- Comments
    ["@comment"] = vim.tbl_extend("force", { fg = colors.comment }, comment_style),
    ["@comment.documentation"] = vim.tbl_extend("force", { fg = colors.comment }, comment_style),
    ["@comment.error"] = { fg = colors.bg0, bg = colors.error, bold = true },
    ["@comment.warning"] = { fg = colors.bg0, bg = colors.warn, bold = true },
    ["@comment.todo"] = { fg = colors.bg0, bg = colors.info, bold = true },
    ["@comment.note"] = { fg = colors.bg0, bg = colors.hint, bold = true },

    -- Markup
    ["@markup"] = { fg = colors.fg1 },
    ["@markup.strong"] = { fg = colors.coral, bold = true },
    ["@markup.italic"] = { fg = colors.iris, italic = true },
    ["@markup.strikethrough"] = { fg = colors.fg3, strikethrough = true },
    ["@markup.underline"] = { underline = true },
    ["@markup.heading"] = { fg = colors.azure, bold = true },
    ["@markup.heading.1"] = { fg = colors.rose, bold = true },
    ["@markup.heading.2"] = { fg = colors.azure, bold = true },
    ["@markup.heading.3"] = { fg = colors.iris, bold = true },
    ["@markup.heading.4"] = { fg = colors.sage, bold = true },
    ["@markup.heading.5"] = { fg = colors.amber, bold = true },
    ["@markup.heading.6"] = { fg = colors.coral, bold = true },
    ["@markup.quote"] = { fg = colors.sage, italic = true },
    ["@markup.math"] = { fg = colors.amber },
    ["@markup.environment"] = { fg = colors.iris },
    ["@markup.link"] = { fg = colors.azure },
    ["@markup.link.label"] = { fg = colors.azure },
    ["@markup.link.url"] = { fg = colors.cyan, underline = true },
    ["@markup.raw"] = { fg = colors.sage },
    ["@markup.raw.block"] = { fg = colors.sage },
    ["@markup.list"] = { fg = colors.mauve },
    ["@markup.list.checked"] = { fg = colors.ok },
    ["@markup.list.unchecked"] = { fg = colors.fg3 },

    -- Diff
    ["@diff.plus"] = { fg = colors.git_add },
    ["@diff.minus"] = { fg = colors.git_delete },
    ["@diff.delta"] = { fg = colors.git_change },

    -- Tags (HTML/JSX)
    ["@tag"] = { fg = colors.mauve },
    ["@tag.builtin"] = { fg = colors.mauve },
    ["@tag.attribute"] = { fg = colors.amber, italic = true },
    ["@tag.delimiter"] = { fg = colors.fg3 },

    -- None
    ["@none"] = {},
  }

  -- ==========================================================================
  -- LSP SEMANTIC TOKENS
  -- ==========================================================================
  local lsp_semantic = {
    ["@lsp.type.class"] = { link = "@type" },
    ["@lsp.type.comment"] = { link = "@comment" },
    ["@lsp.type.decorator"] = { link = "@attribute" },
    ["@lsp.type.enum"] = { link = "@type" },
    ["@lsp.type.enumMember"] = { link = "@constant" },
    ["@lsp.type.event"] = { link = "@type" },
    ["@lsp.type.function"] = { link = "@function" },
    ["@lsp.type.interface"] = { fg = colors.mint },
    ["@lsp.type.keyword"] = { link = "@keyword" },
    ["@lsp.type.macro"] = { link = "@function.macro" },
    ["@lsp.type.method"] = { link = "@function.method" },
    ["@lsp.type.modifier"] = { link = "@keyword.modifier" },
    ["@lsp.type.namespace"] = { link = "@module" },
    ["@lsp.type.number"] = { link = "@number" },
    ["@lsp.type.operator"] = { link = "@operator" },
    ["@lsp.type.parameter"] = { link = "@variable.parameter" },
    ["@lsp.type.property"] = { link = "@property" },
    ["@lsp.type.regexp"] = { link = "@string.regexp" },
    ["@lsp.type.string"] = { link = "@string" },
    ["@lsp.type.struct"] = { link = "@type" },
    ["@lsp.type.type"] = { link = "@type" },
    ["@lsp.type.typeParameter"] = { fg = colors.amber, italic = true },
    ["@lsp.type.variable"] = { link = "@variable" },

    -- Modifiers
    ["@lsp.mod.abstract"] = { italic = true },
    ["@lsp.mod.async"] = { italic = true },
    ["@lsp.mod.declaration"] = {},
    ["@lsp.mod.defaultLibrary"] = { italic = true },
    ["@lsp.mod.definition"] = {},
    ["@lsp.mod.deprecated"] = { strikethrough = true },
    ["@lsp.mod.documentation"] = { italic = true },
    ["@lsp.mod.modification"] = {},
    ["@lsp.mod.readonly"] = { italic = true },
    ["@lsp.mod.static"] = { bold = true },

    -- Type + modifier combinations
    ["@lsp.typemod.class.declaration"] = { fg = colors.amber, bold = true },
    ["@lsp.typemod.function.declaration"] = vim.tbl_extend("force", { fg = colors.azure, bold = true }, function_style),
    ["@lsp.typemod.method.declaration"] = vim.tbl_extend("force", { fg = colors.azure, bold = true }, function_style),
    ["@lsp.typemod.variable.declaration"] = vim.tbl_extend("force", { fg = colors.fg1 }, variable_style),
    ["@lsp.typemod.variable.readonly"] = { fg = colors.coral },
    ["@lsp.typemod.parameter.declaration"] = { fg = colors.rose },
    ["@lsp.typemod.property.readonly"] = { fg = colors.cyan, italic = true },
  }

  -- ==========================================================================
  -- BUILT-IN LSP
  -- ==========================================================================
  local lsp = {
    LspReferenceText = { bg = colors.bg2 },
    LspReferenceRead = { bg = colors.bg2 },
    LspReferenceWrite = { bg = colors.bg2, underline = true },
    LspSignatureActiveParameter = { fg = colors.amber, bold = true },
    LspCodeLens = { fg = colors.comment },
    LspCodeLensSeparator = { fg = colors.border },
    LspInlayHint = { fg = colors.fg3, bg = colors.bg1, italic = true },
    LspInfoBorder = { fg = colors.border },
  }

  -- ==========================================================================
  -- PLUGINS
  -- ==========================================================================

  -- nvim-cmp
  local cmp = {
    CmpItemAbbr = { fg = colors.fg1 },
    CmpItemAbbrDeprecated = { fg = colors.fg3, strikethrough = true },
    CmpItemAbbrMatch = { fg = colors.azure, bold = true },
    CmpItemAbbrMatchFuzzy = { fg = colors.azure, bold = true },
    CmpItemMenu = { fg = colors.fg3 },
    CmpItemKind = { fg = colors.iris },
    CmpItemKindText = { fg = colors.fg1 },
    CmpItemKindMethod = { fg = colors.azure },
    CmpItemKindFunction = { fg = colors.azure },
    CmpItemKindConstructor = { fg = colors.amber },
    CmpItemKindField = { fg = colors.cyan },
    CmpItemKindVariable = { fg = colors.rose },
    CmpItemKindClass = { fg = colors.amber },
    CmpItemKindInterface = { fg = colors.mint },
    CmpItemKindModule = { fg = colors.lavender },
    CmpItemKindProperty = { fg = colors.cyan },
    CmpItemKindUnit = { fg = colors.coral },
    CmpItemKindValue = { fg = colors.coral },
    CmpItemKindEnum = { fg = colors.amber },
    CmpItemKindKeyword = { fg = colors.mauve },
    CmpItemKindSnippet = { fg = colors.sage },
    CmpItemKindColor = { fg = colors.blossom },
    CmpItemKindFile = { fg = colors.azure },
    CmpItemKindReference = { fg = colors.iris },
    CmpItemKindFolder = { fg = colors.azure },
    CmpItemKindEnumMember = { fg = colors.coral },
    CmpItemKindConstant = { fg = colors.coral },
    CmpItemKindStruct = { fg = colors.amber },
    CmpItemKindEvent = { fg = colors.iris },
    CmpItemKindOperator = { fg = colors.cyan },
    CmpItemKindTypeParameter = { fg = colors.amber },
    CmpItemKindCopilot = { fg = colors.sage },
  }

  -- blink.cmp
  local blink = {
    BlinkCmpMenu = { fg = colors.fg1, bg = colors.bg2 },
    BlinkCmpMenuBorder = { fg = colors.border, bg = colors.bg2 },
    BlinkCmpMenuSelection = { bg = colors.bg3 },
    BlinkCmpLabel = { fg = colors.fg1 },
    BlinkCmpLabelDeprecated = { fg = colors.fg3, strikethrough = true },
    BlinkCmpLabelMatch = { fg = colors.azure, bold = true },
    BlinkCmpKind = { fg = colors.iris },
    BlinkCmpKindText = { fg = colors.fg1 },
    BlinkCmpKindMethod = { fg = colors.azure },
    BlinkCmpKindFunction = { fg = colors.azure },
    BlinkCmpKindConstructor = { fg = colors.amber },
    BlinkCmpKindField = { fg = colors.cyan },
    BlinkCmpKindVariable = { fg = colors.rose },
    BlinkCmpKindClass = { fg = colors.amber },
    BlinkCmpKindInterface = { fg = colors.mint },
    BlinkCmpKindModule = { fg = colors.lavender },
    BlinkCmpKindProperty = { fg = colors.cyan },
    BlinkCmpKindUnit = { fg = colors.coral },
    BlinkCmpKindValue = { fg = colors.coral },
    BlinkCmpKindEnum = { fg = colors.amber },
    BlinkCmpKindKeyword = { fg = colors.mauve },
    BlinkCmpKindSnippet = { fg = colors.sage },
    BlinkCmpKindColor = { fg = colors.blossom },
    BlinkCmpKindFile = { fg = colors.azure },
    BlinkCmpKindReference = { fg = colors.iris },
    BlinkCmpKindFolder = { fg = colors.azure },
    BlinkCmpKindEnumMember = { fg = colors.coral },
    BlinkCmpKindConstant = { fg = colors.coral },
    BlinkCmpKindStruct = { fg = colors.amber },
    BlinkCmpKindEvent = { fg = colors.iris },
    BlinkCmpKindOperator = { fg = colors.cyan },
    BlinkCmpKindTypeParameter = { fg = colors.amber },
    BlinkCmpDoc = { fg = colors.fg1, bg = colors.bg1 },
    BlinkCmpDocBorder = { fg = colors.border, bg = colors.bg1 },
    BlinkCmpDocCursorLine = { bg = colors.bg2 },
    BlinkCmpSignatureHelp = { fg = colors.fg1, bg = colors.bg1 },
    BlinkCmpSignatureHelpBorder = { fg = colors.border, bg = colors.bg1 },
    BlinkCmpSignatureHelpActiveParameter = { fg = colors.amber, bold = true },
    BlinkCmpGhostText = { fg = colors.fg3, italic = true },
  }

  -- Telescope
  local telescope = {
    TelescopeNormal = { fg = colors.fg1, bg = bg_float },
    TelescopeBorder = { fg = colors.border, bg = bg_float },
    TelescopeTitle = { fg = colors.azure, bold = true },
    TelescopePromptNormal = { fg = colors.fg1, bg = colors.bg2 },
    TelescopePromptBorder = { fg = colors.border, bg = colors.bg2 },
    TelescopePromptTitle = { fg = colors.bg0, bg = colors.azure, bold = true },
    TelescopePromptPrefix = { fg = colors.azure },
    TelescopePromptCounter = { fg = colors.fg3 },
    TelescopeResultsNormal = { fg = colors.fg1, bg = bg_float },
    TelescopeResultsBorder = { fg = colors.border, bg = bg_float },
    TelescopeResultsTitle = { fg = colors.azure },
    TelescopePreviewNormal = { fg = colors.fg1, bg = bg_float },
    TelescopePreviewBorder = { fg = colors.border, bg = bg_float },
    TelescopePreviewTitle = { fg = colors.bg0, bg = colors.sage, bold = true },
    TelescopeSelection = { bg = colors.bg3 },
    TelescopeSelectionCaret = { fg = colors.azure },
    TelescopeMultiSelection = { fg = colors.iris },
    TelescopeMultiIcon = { fg = colors.iris },
    TelescopeMatching = { fg = colors.amber, bold = true },
    TelescopePreviewLine = { bg = colors.bg2 },
    TelescopePreviewMatch = { fg = colors.amber, bold = true },
  }

  -- Neo-tree
  local neo_tree = {
    NeoTreeNormal = { fg = colors.fg1, bg = bg_dark },
    NeoTreeNormalNC = { fg = colors.fg1, bg = bg_dark },
    NeoTreeVertSplit = { fg = colors.border, bg = bg_dark },
    NeoTreeWinSeparator = { fg = colors.border, bg = bg_dark },
    NeoTreeEndOfBuffer = { fg = bg_dark, bg = bg_dark },
    NeoTreeRootName = { fg = colors.azure, bold = true },
    NeoTreeGitAdded = { fg = colors.git_add },
    NeoTreeGitDeleted = { fg = colors.git_delete },
    NeoTreeGitModified = { fg = colors.git_change },
    NeoTreeGitConflict = { fg = colors.error, bold = true },
    NeoTreeGitUntracked = { fg = colors.warn },
    NeoTreeGitIgnored = { fg = colors.fg3 },
    NeoTreeGitStaged = { fg = colors.sage },
    NeoTreeIndentMarker = { fg = colors.border },
    NeoTreeFileIcon = { fg = colors.azure },
    NeoTreeFileName = { fg = colors.fg1 },
    NeoTreeFileNameOpened = { fg = colors.azure },
    NeoTreeSymbolicLinkTarget = { fg = colors.mint },
    NeoTreeDimText = { fg = colors.fg3 },
    NeoTreeFilterTerm = { fg = colors.azure, bold = true },
    NeoTreeTitleBar = { fg = colors.bg0, bg = colors.azure, bold = true },
    NeoTreeFloatBorder = { fg = colors.border },
    NeoTreeFloatTitle = { fg = colors.azure, bold = true },
    NeoTreeTabActive = { fg = colors.fg1, bg = bg, bold = true },
    NeoTreeTabInactive = { fg = colors.fg3, bg = colors.bg1 },
    NeoTreeTabSeparatorActive = { fg = bg, bg = bg },
    NeoTreeTabSeparatorInactive = { fg = colors.bg1, bg = colors.bg1 },
    NeoTreeModified = { fg = colors.amber },
  }

  -- nvim-tree
  local nvim_tree = {
    NvimTreeNormal = { fg = colors.fg1, bg = bg_dark },
    NvimTreeNormalNC = { fg = colors.fg1, bg = bg_dark },
    NvimTreeRootFolder = { fg = colors.azure, bold = true },
    NvimTreeGitDirty = { fg = colors.git_change },
    NvimTreeGitNew = { fg = colors.git_add },
    NvimTreeGitDeleted = { fg = colors.git_delete },
    NvimTreeGitStaged = { fg = colors.sage },
    NvimTreeGitMerge = { fg = colors.warn },
    NvimTreeGitRenamed = { fg = colors.iris },
    NvimTreeGitIgnored = { fg = colors.fg3 },
    NvimTreeSpecialFile = { fg = colors.amber },
    NvimTreeImageFile = { fg = colors.blossom },
    NvimTreeIndentMarker = { fg = colors.border },
    NvimTreeSymlink = { fg = colors.mint },
    NvimTreeFolderIcon = { fg = colors.azure },
    NvimTreeFolderName = { fg = colors.azure },
    NvimTreeOpenedFolderName = { fg = colors.azure },
    NvimTreeEmptyFolderName = { fg = colors.fg3 },
    NvimTreeExecFile = { fg = colors.sage, bold = true },
    NvimTreeWinSeparator = { fg = colors.border, bg = bg_dark },
    NvimTreeEndOfBuffer = { fg = bg_dark },
    NvimTreeWindowPicker = { fg = colors.bg0, bg = colors.azure, bold = true },
    NvimTreeModifiedFile = { fg = colors.amber },
  }

  -- Gitsigns
  local gitsigns = {
    GitSignsAdd = { fg = colors.git_add },
    GitSignsAddNr = { fg = colors.git_add },
    GitSignsAddLn = { bg = colors.diff_add },
    GitSignsChange = { fg = colors.git_change },
    GitSignsChangeNr = { fg = colors.git_change },
    GitSignsChangeLn = { bg = colors.diff_change },
    GitSignsDelete = { fg = colors.git_delete },
    GitSignsDeleteNr = { fg = colors.git_delete },
    GitSignsDeleteLn = { bg = colors.diff_delete },
    GitSignsCurrentLineBlame = { fg = colors.fg3, italic = true },
    GitSignsAddInline = { bg = colors.diff_add },
    GitSignsChangeInline = { bg = colors.diff_change },
    GitSignsDeleteInline = { bg = colors.diff_delete },
    GitSignsAddPreview = { fg = colors.git_add },
    GitSignsDeletePreview = { fg = colors.git_delete },
    GitSignsStagedAdd = { fg = util.blend(colors.git_add, colors.bg0, 0.5) },
    GitSignsStagedChange = { fg = util.blend(colors.git_change, colors.bg0, 0.5) },
    GitSignsStagedDelete = { fg = util.blend(colors.git_delete, colors.bg0, 0.5) },
  }

  -- Git gutter (vim-gitgutter)
  local gitgutter = {
    GitGutterAdd = { fg = colors.git_add },
    GitGutterChange = { fg = colors.git_change },
    GitGutterDelete = { fg = colors.git_delete },
    GitGutterChangeDelete = { fg = colors.warn },
  }

  -- Which-key
  local which_key = {
    WhichKey = { fg = colors.azure },
    WhichKeyGroup = { fg = colors.iris },
    WhichKeySeparator = { fg = colors.fg3 },
    WhichKeyDesc = { fg = colors.fg1 },
    WhichKeyValue = { fg = colors.fg3 },
    WhichKeyFloat = { bg = colors.bg1 },
    WhichKeyBorder = { fg = colors.border },
    WhichKeyNormal = { fg = colors.fg1, bg = colors.bg1 },
  }

  -- Dashboard
  local dashboard = {
    DashboardHeader = { fg = colors.azure },
    DashboardCenter = { fg = colors.fg1 },
    DashboardShortCut = { fg = colors.amber },
    DashboardFooter = { fg = colors.fg3, italic = true },
    -- alpha-nvim
    AlphaHeader = { fg = colors.azure },
    AlphaButtons = { fg = colors.fg1 },
    AlphaShortcut = { fg = colors.amber },
    AlphaFooter = { fg = colors.fg3, italic = true },
  }

  -- Indent-blankline
  local indent_blankline = {
    IndentBlanklineChar = { fg = colors.bg2, nocombine = true },
    IndentBlanklineContextChar = { fg = colors.iris, nocombine = true },
    IndentBlanklineContextStart = { sp = colors.iris, underline = true },
    IndentBlanklineSpaceChar = { fg = colors.bg2, nocombine = true },
    IndentBlanklineSpaceCharBlankline = { fg = colors.bg2, nocombine = true },
    -- ibl (v3)
    IblIndent = { fg = colors.bg2, nocombine = true },
    IblScope = { fg = colors.iris, nocombine = true },
    IblWhitespace = { fg = colors.bg2, nocombine = true },
  }

  -- Rainbow delimiters
  local rainbow = {
    RainbowDelimiterRed = { fg = colors.mauve },
    RainbowDelimiterYellow = { fg = colors.amber },
    RainbowDelimiterBlue = { fg = colors.azure },
    RainbowDelimiterOrange = { fg = colors.coral },
    RainbowDelimiterGreen = { fg = colors.sage },
    RainbowDelimiterViolet = { fg = colors.iris },
    RainbowDelimiterCyan = { fg = colors.cyan },
  }

  -- mini.nvim
  local mini = {
    -- mini.statusline
    MiniStatuslineModeNormal = { fg = colors.bg0, bg = colors.azure, bold = true },
    MiniStatuslineModeInsert = { fg = colors.bg0, bg = colors.sage, bold = true },
    MiniStatuslineModeVisual = { fg = colors.bg0, bg = colors.iris, bold = true },
    MiniStatuslineModeReplace = { fg = colors.bg0, bg = colors.mauve, bold = true },
    MiniStatuslineModeCommand = { fg = colors.bg0, bg = colors.amber, bold = true },
    MiniStatuslineModeOther = { fg = colors.bg0, bg = colors.mint, bold = true },
    MiniStatuslineDevinfo = { fg = colors.fg1, bg = colors.bg2 },
    MiniStatuslineFilename = { fg = colors.fg2, bg = colors.bg1 },
    MiniStatuslineFileinfo = { fg = colors.fg1, bg = colors.bg2 },
    MiniStatuslineInactive = { fg = colors.fg3, bg = colors.bg1 },

    -- mini.tabline
    MiniTablineCurrent = { fg = colors.fg1, bg = bg, bold = true },
    MiniTablineVisible = { fg = colors.fg1, bg = colors.bg1 },
    MiniTablineHidden = { fg = colors.fg3, bg = colors.bg1 },
    MiniTablineModifiedCurrent = { fg = colors.amber, bg = bg, bold = true },
    MiniTablineModifiedVisible = { fg = colors.amber, bg = colors.bg1 },
    MiniTablineModifiedHidden = { fg = util.blend(colors.amber, colors.bg0, 0.5), bg = colors.bg1 },
    MiniTablineFill = { bg = colors.bg_dark },
    MiniTablineTabpagesection = { fg = colors.bg0, bg = colors.azure, bold = true },

    -- mini.starter
    MiniStarterCurrent = { nocombine = true },
    MiniStarterFooter = { fg = colors.fg3, italic = true },
    MiniStarterHeader = { fg = colors.azure },
    MiniStarterInactive = { fg = colors.fg3 },
    MiniStarterItem = { fg = colors.fg1 },
    MiniStarterItemBullet = { fg = colors.border },
    MiniStarterItemPrefix = { fg = colors.amber },
    MiniStarterSection = { fg = colors.iris },
    MiniStarterQuery = { fg = colors.azure, bold = true },

    -- mini.cursorword
    MiniCursorword = { bg = colors.bg2 },
    MiniCursorwordCurrent = { bg = colors.bg2 },

    -- mini.indentscope
    MiniIndentscopeSymbol = { fg = colors.iris },
    MiniIndentscopePrefix = { nocombine = true },

    -- mini.jump
    MiniJump = { fg = colors.bg0, bg = colors.amber },
    MiniJump2dSpot = { fg = colors.amber, bold = true },
    MiniJump2dSpotAhead = { fg = colors.mint },
    MiniJump2dSpotUnique = { fg = colors.coral, bold = true },

    -- mini.surround
    MiniSurround = { fg = colors.bg0, bg = colors.amber },

    -- mini.trailspace
    MiniTrailspace = { bg = colors.mauve },

    -- mini.hipatterns
    MiniHipatternsFixme = { fg = colors.bg0, bg = colors.error, bold = true },
    MiniHipatternsHack = { fg = colors.bg0, bg = colors.warn, bold = true },
    MiniHipatternsTodo = { fg = colors.bg0, bg = colors.info, bold = true },
    MiniHipatternsNote = { fg = colors.bg0, bg = colors.hint, bold = true },

    -- mini.files
    MiniFilesNormal = { fg = colors.fg1, bg = bg_float },
    MiniFilesBorder = { fg = colors.border, bg = bg_float },
    MiniFilesTitle = { fg = colors.azure, bold = true },
    MiniFilesTitleFocused = { fg = colors.bg0, bg = colors.azure, bold = true },
    MiniFilesDirectory = { fg = colors.azure },
    MiniFilesFile = { fg = colors.fg1 },
    MiniFilesCursorLine = { bg = colors.bg2 },

    -- mini.pick
    MiniPickNormal = { fg = colors.fg1, bg = bg_float },
    MiniPickBorder = { fg = colors.border, bg = bg_float },
    MiniPickBorderBusy = { fg = colors.amber, bg = bg_float },
    MiniPickBorderText = { fg = colors.azure, bg = bg_float },
    MiniPickHeader = { fg = colors.iris },
    MiniPickMatchCurrent = { bg = colors.bg2 },
    MiniPickMatchMarked = { fg = colors.amber, bg = colors.bg2 },
    MiniPickMatchRanges = { fg = colors.azure, bold = true },
    MiniPickPrompt = { fg = colors.azure },
    MiniPickPreviewLine = { bg = colors.bg2 },
    MiniPickPreviewRegion = { bg = colors.bg3 },

    -- mini.notify
    MiniNotifyNormal = { fg = colors.fg1, bg = bg_float },
    MiniNotifyBorder = { fg = colors.border, bg = bg_float },
    MiniNotifyTitle = { fg = colors.azure, bold = true },

    -- mini.diff
    MiniDiffSignAdd = { fg = colors.git_add },
    MiniDiffSignChange = { fg = colors.git_change },
    MiniDiffSignDelete = { fg = colors.git_delete },
    MiniDiffOverAdd = { bg = colors.diff_add },
    MiniDiffOverChange = { bg = colors.diff_change },
    MiniDiffOverContext = { bg = colors.bg2 },
    MiniDiffOverDelete = { bg = colors.diff_delete },

    -- mini.clue
    MiniClueTitle = { fg = colors.azure, bold = true },
    MiniClueDescGroup = { fg = colors.iris },
    MiniClueDescSingle = { fg = colors.fg1 },
    MiniClueNextKey = { fg = colors.amber },
    MiniClueNextKeyWithPostkeys = { fg = colors.coral },
    MiniClueSeparator = { fg = colors.border },
  }

  -- illuminate
  local illuminate = {
    IlluminatedWordText = { bg = colors.bg2 },
    IlluminatedWordRead = { bg = colors.bg2 },
    IlluminatedWordWrite = { bg = colors.bg2, underline = true },
  }

  -- Lazy.nvim
  local lazy = {
    LazyH1 = { fg = colors.bg0, bg = colors.azure, bold = true },
    LazyH2 = { fg = colors.azure, bold = true },
    LazyButton = { fg = colors.fg1, bg = colors.bg2 },
    LazyButtonActive = { fg = colors.bg0, bg = colors.azure },
    LazyComment = { fg = colors.fg3 },
    LazyCommit = { fg = colors.coral },
    LazyCommitIssue = { fg = colors.amber },
    LazyCommitScope = { fg = colors.iris, italic = true },
    LazyCommitType = { fg = colors.azure },
    LazyDimmed = { fg = colors.fg3 },
    LazyDir = { fg = colors.azure },
    LazyLocal = { fg = colors.warn },
    LazyNoCond = { fg = colors.error },
    LazyNormal = { fg = colors.fg1, bg = bg_float },
    LazyProgressDone = { fg = colors.sage },
    LazyProgressTodo = { fg = colors.bg3 },
    LazyProp = { fg = colors.fg3 },
    LazyReasonCmd = { fg = colors.amber },
    LazyReasonEvent = { fg = colors.amber },
    LazyReasonFt = { fg = colors.sage },
    LazyReasonImport = { fg = colors.iris },
    LazyReasonKeys = { fg = colors.rose },
    LazyReasonPlugin = { fg = colors.azure },
    LazyReasonRequire = { fg = colors.iris },
    LazyReasonRuntime = { fg = colors.lavender },
    LazyReasonSource = { fg = colors.coral },
    LazyReasonStart = { fg = colors.sage },
    LazySpecial = { fg = colors.iris },
    LazyTaskError = { fg = colors.error },
    LazyTaskOutput = { fg = colors.fg1 },
    LazyUrl = { fg = colors.azure, underline = true },
    LazyValue = { fg = colors.sage },
  }

  -- Mason
  local mason = {
    MasonNormal = { fg = colors.fg1, bg = bg_float },
    MasonHeader = { fg = colors.bg0, bg = colors.azure, bold = true },
    MasonHeaderSecondary = { fg = colors.bg0, bg = colors.iris, bold = true },
    MasonHighlight = { fg = colors.azure },
    MasonHighlightBlock = { fg = colors.bg0, bg = colors.azure },
    MasonHighlightBlockBold = { fg = colors.bg0, bg = colors.azure, bold = true },
    MasonHighlightBlockBoldSecondary = { fg = colors.bg0, bg = colors.iris, bold = true },
    MasonHighlightBlockSecondary = { fg = colors.bg0, bg = colors.iris },
    MasonHighlightSecondary = { fg = colors.iris },
    MasonMuted = { fg = colors.fg3 },
    MasonMutedBlock = { fg = colors.fg3, bg = colors.bg2 },
    MasonMutedBlockBold = { fg = colors.fg3, bg = colors.bg2, bold = true },
  }

  -- Noice
  local noice = {
    NoiceCmdline = { fg = colors.fg1 },
    NoiceCmdlineIcon = { fg = colors.azure },
    NoiceCmdlineIconSearch = { fg = colors.amber },
    NoiceCmdlinePopup = { fg = colors.fg1, bg = colors.bg2 },
    NoiceCmdlinePopupBorder = { fg = colors.border },
    NoiceCmdlinePopupBorderSearch = { fg = colors.amber },
    NoiceCmdlinePrompt = { fg = colors.azure },
    NoiceConfirm = { fg = colors.fg1, bg = colors.bg2 },
    NoiceConfirmBorder = { fg = colors.border },
    NoiceFormatConfirm = { fg = colors.azure },
    NoiceFormatConfirmDefault = { fg = colors.bg0, bg = colors.azure },
    NoiceFormatDate = { fg = colors.fg3 },
    NoiceFormatEvent = { fg = colors.fg3 },
    NoiceFormatKind = { fg = colors.iris },
    NoiceFormatLevelDebug = { fg = colors.fg3 },
    NoiceFormatLevelError = { fg = colors.error },
    NoiceFormatLevelInfo = { fg = colors.info },
    NoiceFormatLevelOff = { fg = colors.fg3 },
    NoiceFormatLevelTrace = { fg = colors.fg3 },
    NoiceFormatLevelWarn = { fg = colors.warn },
    NoiceFormatProgressDone = { fg = colors.bg0, bg = colors.sage },
    NoiceFormatProgressTodo = { fg = colors.fg1, bg = colors.bg2 },
    NoiceFormatTitle = { fg = colors.azure },
    NoiceLspProgressClient = { fg = colors.azure },
    NoiceLspProgressSpinner = { fg = colors.sage },
    NoiceLspProgressTitle = { fg = colors.fg1 },
    NoiceMini = { fg = colors.fg1, bg = colors.bg2 },
    NoicePopup = { fg = colors.fg1, bg = bg_float },
    NoicePopupBorder = { fg = colors.border },
    NoicePopupmenu = { fg = colors.fg1, bg = colors.bg2 },
    NoicePopupmenuBorder = { fg = colors.border },
    NoicePopupmenuMatch = { fg = colors.azure, bold = true },
    NoicePopupmenuSelected = { bg = colors.bg3 },
    NoiceScrollbar = { bg = colors.bg3 },
    NoiceScrollbarThumb = { bg = colors.fg3 },
    NoiceSplit = { fg = colors.fg1, bg = bg },
    NoiceSplitBorder = { fg = colors.border },
    NoiceVirtualText = { fg = colors.iris },
  }

  -- Notify
  local notify = {
    NotifyBackground = { bg = colors.bg0 },
    NotifyERRORBorder = { fg = colors.error },
    NotifyERRORIcon = { fg = colors.error },
    NotifyERRORTitle = { fg = colors.error },
    NotifyERRORBody = { fg = colors.fg1 },
    NotifyWARNBorder = { fg = colors.warn },
    NotifyWARNIcon = { fg = colors.warn },
    NotifyWARNTitle = { fg = colors.warn },
    NotifyWARNBody = { fg = colors.fg1 },
    NotifyINFOBorder = { fg = colors.info },
    NotifyINFOIcon = { fg = colors.info },
    NotifyINFOTitle = { fg = colors.info },
    NotifyINFOBody = { fg = colors.fg1 },
    NotifyDEBUGBorder = { fg = colors.fg3 },
    NotifyDEBUGIcon = { fg = colors.fg3 },
    NotifyDEBUGTitle = { fg = colors.fg3 },
    NotifyDEBUGBody = { fg = colors.fg1 },
    NotifyTRACEBorder = { fg = colors.iris },
    NotifyTRACEIcon = { fg = colors.iris },
    NotifyTRACETitle = { fg = colors.iris },
    NotifyTRACEBody = { fg = colors.fg1 },
  }

  -- flash.nvim
  local flash = {
    FlashBackdrop = { fg = colors.fg3 },
    FlashCurrent = { fg = colors.bg0, bg = colors.amber, bold = true },
    FlashLabel = { fg = colors.bg0, bg = colors.rose, bold = true },
    FlashMatch = { fg = colors.bg0, bg = colors.azure },
    FlashCursor = { reverse = true },
    FlashPrompt = { fg = colors.azure },
    FlashPromptIcon = { fg = colors.amber },
  }

  -- Trouble
  local trouble = {
    TroubleNormal = { fg = colors.fg1, bg = bg_float },
    TroubleNormalNC = { fg = colors.fg1, bg = bg_float },
    TroubleCount = { fg = colors.iris },
    TroubleDirectory = { fg = colors.azure },
    TroubleFileName = { fg = colors.azure },
    TroubleIconArray = { fg = colors.amber },
    TroubleIconBoolean = { fg = colors.coral },
    TroubleIconClass = { fg = colors.amber },
    TroubleIconConstant = { fg = colors.coral },
    TroubleIconConstructor = { fg = colors.amber },
    TroubleIconDirectory = { fg = colors.azure },
    TroubleIconEnum = { fg = colors.amber },
    TroubleIconEnumMember = { fg = colors.coral },
    TroubleIconEvent = { fg = colors.iris },
    TroubleIconField = { fg = colors.cyan },
    TroubleIconFile = { fg = colors.azure },
    TroubleIconFunction = { fg = colors.azure },
    TroubleIconInterface = { fg = colors.mint },
    TroubleIconKey = { fg = colors.mauve },
    TroubleIconMethod = { fg = colors.azure },
    TroubleIconModule = { fg = colors.lavender },
    TroubleIconNamespace = { fg = colors.lavender },
    TroubleIconNull = { fg = colors.coral },
    TroubleIconNumber = { fg = colors.coral },
    TroubleIconObject = { fg = colors.amber },
    TroubleIconOperator = { fg = colors.cyan },
    TroubleIconPackage = { fg = colors.lavender },
    TroubleIconProperty = { fg = colors.cyan },
    TroubleIconString = { fg = colors.sage },
    TroubleIconStruct = { fg = colors.amber },
    TroubleIconTypeParameter = { fg = colors.amber },
    TroubleIconVariable = { fg = colors.rose },
    TroubleIndent = { fg = colors.border },
    TroubleIndentFoldClosed = { fg = colors.iris },
    TroubleIndentFoldOpen = { fg = colors.iris },
    TroubleIndentLast = { fg = colors.border },
    TroubleIndentMiddle = { fg = colors.border },
    TroubleIndentTop = { fg = colors.border },
    TroubleIndentWs = { fg = colors.border },
    TroublePos = { fg = colors.fg3 },
    TroublePreview = { bg = colors.bg2 },
    TroubleSource = { fg = colors.fg3 },
    TroubleText = { fg = colors.fg1 },
  }

  -- nvim-navic (breadcrumbs)
  local navic = {
    NavicText = { fg = colors.fg1 },
    NavicSeparator = { fg = colors.fg3 },
    NavicIconsArray = { fg = colors.amber },
    NavicIconsBoolean = { fg = colors.coral },
    NavicIconsClass = { fg = colors.amber },
    NavicIconsConstant = { fg = colors.coral },
    NavicIconsConstructor = { fg = colors.amber },
    NavicIconsEnum = { fg = colors.amber },
    NavicIconsEnumMember = { fg = colors.coral },
    NavicIconsEvent = { fg = colors.iris },
    NavicIconsField = { fg = colors.cyan },
    NavicIconsFile = { fg = colors.azure },
    NavicIconsFunction = { fg = colors.azure },
    NavicIconsInterface = { fg = colors.mint },
    NavicIconsKey = { fg = colors.mauve },
    NavicIconsMethod = { fg = colors.azure },
    NavicIconsModule = { fg = colors.lavender },
    NavicIconsNamespace = { fg = colors.lavender },
    NavicIconsNull = { fg = colors.coral },
    NavicIconsNumber = { fg = colors.coral },
    NavicIconsObject = { fg = colors.amber },
    NavicIconsOperator = { fg = colors.cyan },
    NavicIconsPackage = { fg = colors.lavender },
    NavicIconsProperty = { fg = colors.cyan },
    NavicIconsString = { fg = colors.sage },
    NavicIconsStruct = { fg = colors.amber },
    NavicIconsTypeParameter = { fg = colors.amber },
    NavicIconsVariable = { fg = colors.rose },
  }

  -- Aerial
  local aerial = {
    AerialNormal = { fg = colors.fg1, bg = bg_float },
    AerialLine = { bg = colors.bg2 },
    AerialLineNC = { bg = colors.bg1 },
    AerialArrayIcon = { fg = colors.amber },
    AerialBooleanIcon = { fg = colors.coral },
    AerialClassIcon = { fg = colors.amber },
    AerialConstantIcon = { fg = colors.coral },
    AerialConstructorIcon = { fg = colors.amber },
    AerialEnumIcon = { fg = colors.amber },
    AerialEnumMemberIcon = { fg = colors.coral },
    AerialEventIcon = { fg = colors.iris },
    AerialFieldIcon = { fg = colors.cyan },
    AerialFileIcon = { fg = colors.azure },
    AerialFunctionIcon = { fg = colors.azure },
    AerialInterfaceIcon = { fg = colors.mint },
    AerialKeyIcon = { fg = colors.mauve },
    AerialMethodIcon = { fg = colors.azure },
    AerialModuleIcon = { fg = colors.lavender },
    AerialNamespaceIcon = { fg = colors.lavender },
    AerialNullIcon = { fg = colors.coral },
    AerialNumberIcon = { fg = colors.coral },
    AerialObjectIcon = { fg = colors.amber },
    AerialOperatorIcon = { fg = colors.cyan },
    AerialPackageIcon = { fg = colors.lavender },
    AerialPropertyIcon = { fg = colors.cyan },
    AerialStringIcon = { fg = colors.sage },
    AerialStructIcon = { fg = colors.amber },
    AerialTypeParameterIcon = { fg = colors.amber },
    AerialVariableIcon = { fg = colors.rose },
  }

  -- Bufferline
  local bufferline = {
    BufferLineFill = { bg = colors.bg_dark },
    BufferLineBackground = { fg = colors.fg3, bg = colors.bg1 },
    BufferLineBuffer = { fg = colors.fg3, bg = colors.bg1 },
    BufferLineBufferSelected = { fg = colors.fg1, bg = bg, bold = true },
    BufferLineBufferVisible = { fg = colors.fg2, bg = colors.bg1 },
    BufferLineCloseButton = { fg = colors.fg3, bg = colors.bg1 },
    BufferLineCloseButtonSelected = { fg = colors.mauve, bg = bg },
    BufferLineCloseButtonVisible = { fg = colors.fg3, bg = colors.bg1 },
    BufferLineDiagnostic = { fg = colors.fg3, bg = colors.bg1 },
    BufferLineDiagnosticSelected = { fg = colors.fg3, bg = bg },
    BufferLineDiagnosticVisible = { fg = colors.fg3, bg = colors.bg1 },
    BufferLineError = { fg = colors.error, bg = colors.bg1 },
    BufferLineErrorDiagnostic = { fg = colors.error, bg = colors.bg1 },
    BufferLineErrorDiagnosticSelected = { fg = colors.error, bg = bg },
    BufferLineErrorDiagnosticVisible = { fg = colors.error, bg = colors.bg1 },
    BufferLineErrorSelected = { fg = colors.error, bg = bg },
    BufferLineErrorVisible = { fg = colors.error, bg = colors.bg1 },
    BufferLineHint = { fg = colors.hint, bg = colors.bg1 },
    BufferLineHintDiagnostic = { fg = colors.hint, bg = colors.bg1 },
    BufferLineHintDiagnosticSelected = { fg = colors.hint, bg = bg },
    BufferLineHintDiagnosticVisible = { fg = colors.hint, bg = colors.bg1 },
    BufferLineHintSelected = { fg = colors.hint, bg = bg },
    BufferLineHintVisible = { fg = colors.hint, bg = colors.bg1 },
    BufferLineIndicatorSelected = { fg = colors.azure, bg = bg },
    BufferLineIndicatorVisible = { fg = colors.bg1, bg = colors.bg1 },
    BufferLineInfo = { fg = colors.info, bg = colors.bg1 },
    BufferLineInfoDiagnostic = { fg = colors.info, bg = colors.bg1 },
    BufferLineInfoDiagnosticSelected = { fg = colors.info, bg = bg },
    BufferLineInfoDiagnosticVisible = { fg = colors.info, bg = colors.bg1 },
    BufferLineInfoSelected = { fg = colors.info, bg = bg },
    BufferLineInfoVisible = { fg = colors.info, bg = colors.bg1 },
    BufferLineModified = { fg = colors.amber, bg = colors.bg1 },
    BufferLineModifiedSelected = { fg = colors.amber, bg = bg },
    BufferLineModifiedVisible = { fg = colors.amber, bg = colors.bg1 },
    BufferLineNumbers = { fg = colors.fg3, bg = colors.bg1 },
    BufferLineNumbersSelected = { fg = colors.azure, bg = bg },
    BufferLineNumbersVisible = { fg = colors.fg3, bg = colors.bg1 },
    BufferLineSeparator = { fg = colors.bg_dark, bg = colors.bg1 },
    BufferLineSeparatorSelected = { fg = colors.bg_dark, bg = bg },
    BufferLineSeparatorVisible = { fg = colors.bg_dark, bg = colors.bg1 },
    BufferLineTab = { fg = colors.fg3, bg = colors.bg1 },
    BufferLineTabClose = { fg = colors.mauve, bg = colors.bg1 },
    BufferLineTabSelected = { fg = colors.azure, bg = bg },
    BufferLineTabSeparator = { fg = colors.bg_dark, bg = colors.bg1 },
    BufferLineTabSeparatorSelected = { fg = colors.bg_dark, bg = bg },
    BufferLineWarning = { fg = colors.warn, bg = colors.bg1 },
    BufferLineWarningDiagnostic = { fg = colors.warn, bg = colors.bg1 },
    BufferLineWarningDiagnosticSelected = { fg = colors.warn, bg = bg },
    BufferLineWarningDiagnosticVisible = { fg = colors.warn, bg = colors.bg1 },
    BufferLineWarningSelected = { fg = colors.warn, bg = bg },
    BufferLineWarningVisible = { fg = colors.warn, bg = colors.bg1 },
  }

  -- Snacks
  local snacks = {
    SnacksNormal = { fg = colors.fg1, bg = bg_float },
    SnacksPicker = { fg = colors.fg1, bg = bg_float },
    SnacksPickerBorder = { fg = colors.border, bg = bg_float },
    SnacksPickerTitle = { fg = colors.azure, bold = true },
    SnacksPickerPrompt = { fg = colors.azure },
    SnacksPickerMatch = { fg = colors.amber, bold = true },
    SnacksPickerSelected = { bg = colors.bg3 },
    SnacksPickerDir = { fg = colors.fg3 },
    SnacksPickerFile = { fg = colors.fg1 },
    SnacksPickerGitAdded = { fg = colors.git_add },
    SnacksPickerGitDeleted = { fg = colors.git_delete },
    SnacksPickerGitModified = { fg = colors.git_change },
    SnacksNotifierNormal = { fg = colors.fg1, bg = bg_float },
    SnacksNotifierBorder = { fg = colors.border, bg = bg_float },
    SnacksNotifierTitle = { fg = colors.azure, bold = true },
    SnacksNotifierError = { fg = colors.error },
    SnacksNotifierWarn = { fg = colors.warn },
    SnacksNotifierInfo = { fg = colors.info },
    SnacksNotifierDebug = { fg = colors.fg3 },
    SnacksNotifierTrace = { fg = colors.iris },
    SnacksDashboardNormal = { fg = colors.fg1, bg = bg },
    SnacksDashboardHeader = { fg = colors.azure },
    SnacksDashboardFooter = { fg = colors.fg3, italic = true },
    SnacksDashboardKey = { fg = colors.amber },
    SnacksDashboardIcon = { fg = colors.azure },
    SnacksDashboardDesc = { fg = colors.fg1 },
    SnacksDashboardDir = { fg = colors.fg3 },
    SnacksDashboardFile = { fg = colors.azure },
    SnacksDashboardSpecial = { fg = colors.iris },
    SnacksIndent = { fg = colors.bg2 },
    SnacksIndentScope = { fg = colors.iris },
    SnacksZenNormal = { fg = colors.fg1, bg = bg },
    SnacksInputNormal = { fg = colors.fg1, bg = bg_float },
    SnacksInputBorder = { fg = colors.border, bg = bg_float },
    SnacksInputTitle = { fg = colors.azure, bold = true },
    SnacksInputPrompt = { fg = colors.azure },
  }

  -- Fidget
  local fidget = {
    FidgetTask = { fg = colors.fg3 },
    FidgetTitle = { fg = colors.azure, bold = true },
  }

  -- Neogit
  local neogit = {
    NeogitBranch = { fg = colors.iris },
    NeogitRemote = { fg = colors.azure },
    NeogitHunkHeader = { fg = colors.fg1, bg = colors.bg2 },
    NeogitHunkHeaderHighlight = { fg = colors.azure, bg = colors.bg2 },
    NeogitDiffContext = { fg = colors.fg2, bg = colors.bg1 },
    NeogitDiffContextHighlight = { fg = colors.fg1, bg = colors.bg1 },
    NeogitDiffAdd = { fg = colors.git_add, bg = colors.diff_add },
    NeogitDiffAddHighlight = { fg = colors.git_add, bg = colors.diff_add },
    NeogitDiffDelete = { fg = colors.git_delete, bg = colors.diff_delete },
    NeogitDiffDeleteHighlight = { fg = colors.git_delete, bg = colors.diff_delete },
    NeogitNotificationInfo = { fg = colors.info },
    NeogitNotificationWarning = { fg = colors.warn },
    NeogitNotificationError = { fg = colors.error },
    NeogitGraphAuthor = { fg = colors.coral },
    NeogitGraphRed = { fg = colors.mauve },
    NeogitGraphWhite = { fg = colors.fg1 },
    NeogitGraphYellow = { fg = colors.amber },
    NeogitGraphGreen = { fg = colors.sage },
    NeogitGraphCyan = { fg = colors.cyan },
    NeogitGraphBlue = { fg = colors.azure },
    NeogitGraphPurple = { fg = colors.iris },
    NeogitGraphGray = { fg = colors.fg3 },
    NeogitGraphOrange = { fg = colors.coral },
    NeogitGraphBoldWhite = { fg = colors.fg1, bold = true },
    NeogitGraphBoldRed = { fg = colors.mauve, bold = true },
    NeogitGraphBoldYellow = { fg = colors.amber, bold = true },
    NeogitGraphBoldGreen = { fg = colors.sage, bold = true },
    NeogitGraphBoldCyan = { fg = colors.cyan, bold = true },
    NeogitGraphBoldBlue = { fg = colors.azure, bold = true },
    NeogitGraphBoldPurple = { fg = colors.iris, bold = true },
    NeogitGraphBoldGray = { fg = colors.fg3, bold = true },
  }

  -- Diffview
  local diffview = {
    DiffviewNormal = { fg = colors.fg1, bg = bg_dark },
    DiffviewPrimary = { fg = colors.azure },
    DiffviewSecondary = { fg = colors.iris },
    DiffviewDim1 = { fg = colors.fg3 },
    DiffviewFilePanelTitle = { fg = colors.azure, bold = true },
    DiffviewFilePanelCounter = { fg = colors.iris },
    DiffviewFilePanelFileName = { fg = colors.fg1 },
    DiffviewFilePanelPath = { fg = colors.fg3 },
    DiffviewFilePanelInsertions = { fg = colors.git_add },
    DiffviewFilePanelDeletions = { fg = colors.git_delete },
    DiffviewFilePanelConflicts = { fg = colors.error },
    DiffviewFilePanelRootPath = { fg = colors.fg3 },
    DiffviewFilePanelSelected = { bg = colors.bg2 },
    DiffviewStatusAdded = { fg = colors.git_add },
    DiffviewStatusUntracked = { fg = colors.git_add },
    DiffviewStatusModified = { fg = colors.git_change },
    DiffviewStatusRenamed = { fg = colors.iris },
    DiffviewStatusCopied = { fg = colors.azure },
    DiffviewStatusTypeChange = { fg = colors.amber },
    DiffviewStatusUnmerged = { fg = colors.warn },
    DiffviewStatusUnknown = { fg = colors.fg3 },
    DiffviewStatusDeleted = { fg = colors.git_delete },
    DiffviewStatusBroken = { fg = colors.error },
    DiffviewHash = { fg = colors.coral },
    DiffviewReference = { fg = colors.iris },
  }

  -- Lspsaga
  local lspsaga = {
    SagaNormal = { fg = colors.fg1, bg = bg_float },
    SagaBorder = { fg = colors.border, bg = bg_float },
    SagaExpand = { fg = colors.coral },
    SagaCollapse = { fg = colors.coral },
    SagaBeacon = { bg = colors.amber },
    SagaCodeAction = { fg = colors.amber },
    SagaFinderFname = { fg = colors.azure },
    SagaTitle = { fg = colors.azure, bold = true },
    SagaToggle = { fg = colors.iris },
    SagaCount = { fg = colors.bg0, bg = colors.iris },
    SagaVirtLine = { fg = colors.border },
    SagaSpinnerTitle = { fg = colors.iris },
    SagaSpinner = { fg = colors.iris },
    SagaText = { fg = colors.fg1 },
    SagaSelect = { fg = colors.iris },
    SagaSearch = { fg = colors.amber, bold = true },
    SagaFilename = { fg = colors.azure },
    SagaDetail = { fg = colors.fg3, italic = true },
    SagaInCurrent = { fg = colors.amber },
    SagaImpIcon = { fg = colors.iris },
    SagaSep = { fg = colors.border },
    ActionFix = { fg = colors.sage },
    ActionPreviewTitle = { fg = colors.azure, bold = true },
    ActionPreviewNormal = { fg = colors.fg1, bg = bg_float },
    ActionPreviewBorder = { fg = colors.border },
    FinderCount = { fg = colors.iris },
    FinderIcon = { fg = colors.azure },
    FinderSelection = { bg = colors.bg2, bold = true },
    FinderSpinner = { fg = colors.iris },
    FinderSpinnerTitle = { fg = colors.iris, bold = true },
    FinderType = { fg = colors.amber },
    FinderVirtText = { fg = colors.fg3 },
    CallHierarchyIcon = { fg = colors.iris },
    CallHierarchyTitle = { fg = colors.azure, bold = true },
    HoverNormal = { fg = colors.fg1, bg = bg_float },
    HoverBorder = { fg = colors.border, bg = bg_float },
    RenameBorder = { fg = colors.border, bg = bg_float },
    RenameNormal = { fg = colors.fg1, bg = bg_float },
    RenameMatch = { fg = colors.amber, bold = true },
    DefinitionBorder = { fg = colors.border },
    DefinitionNormal = { fg = colors.fg1, bg = bg_float },
    DefinitionArrow = { fg = colors.iris },
    DefinitionFile = { fg = colors.azure },
    DefinitionIcon = { fg = colors.azure },
    DefinitionCount = { fg = colors.iris },
    TypeDefinitionBorder = { fg = colors.border },
    TypeDefinitionNormal = { fg = colors.fg1, bg = bg_float },
    TerminalBorder = { fg = colors.border },
    TerminalNormal = { fg = colors.fg1, bg = bg_float },
    DiagnosticBorder = { fg = colors.border },
    DiagnosticNormal = { fg = colors.fg1, bg = bg_float },
    DiagnosticText = { fg = colors.fg1 },
    DiagnosticSource = { fg = colors.fg3, italic = true },
    DiagnosticMap = { fg = colors.iris },
    DiagnosticLineCol = { fg = colors.fg3 },
    LspSagaLightBulb = { fg = colors.amber },
    CodeActionNumber = { fg = colors.iris },
    OutlineIndent = { fg = colors.border },
    OutlineFoldPrefix = { fg = colors.coral },
    OutlineDetail = { fg = colors.fg3 },
  }

  -- Copilot
  local copilot = {
    CopilotSuggestion = { fg = colors.fg3, italic = true },
    CopilotAnnotation = { fg = colors.fg3, italic = true },
  }

  -- nvim-dap
  local dap = {
    DapBreakpoint = { fg = colors.mauve },
    DapBreakpointCondition = { fg = colors.amber },
    DapBreakpointRejected = { fg = colors.fg3 },
    DapLogPoint = { fg = colors.azure },
    DapStopped = { fg = colors.sage },
    DapStoppedLine = { bg = colors.bg2 },
    DapUIScope = { fg = colors.azure },
    DapUIType = { fg = colors.amber },
    DapUIModifiedValue = { fg = colors.amber, bold = true },
    DapUIDecoration = { fg = colors.azure },
    DapUIThread = { fg = colors.sage },
    DapUIStoppedThread = { fg = colors.azure },
    DapUISource = { fg = colors.iris },
    DapUILineNumber = { fg = colors.azure },
    DapUIFloatBorder = { fg = colors.border },
    DapUIWatchesEmpty = { fg = colors.fg3 },
    DapUIWatchesValue = { fg = colors.sage },
    DapUIWatchesError = { fg = colors.error },
    DapUIBreakpointsPath = { fg = colors.azure },
    DapUIBreakpointsInfo = { fg = colors.sage },
    DapUIBreakpointsCurrentLine = { fg = colors.sage, bold = true },
    DapUIBreakpointsDisabledLine = { fg = colors.fg3 },
    DapUICurrentFrameName = { fg = colors.sage, bold = true },
    DapUIStepOver = { fg = colors.azure },
    DapUIStepInto = { fg = colors.azure },
    DapUIStepBack = { fg = colors.azure },
    DapUIStepOut = { fg = colors.azure },
    DapUIStop = { fg = colors.mauve },
    DapUIPlayPause = { fg = colors.sage },
    DapUIRestart = { fg = colors.sage },
    DapUIUnavailable = { fg = colors.fg3 },
    DapUIWinSelect = { fg = colors.azure, bold = true },
  }

  -- nvim-neotest
  local neotest = {
    NeotestAdapterName = { fg = colors.iris, bold = true },
    NeotestBorder = { fg = colors.border },
    NeotestDir = { fg = colors.azure },
    NeotestExpandMarker = { fg = colors.fg3 },
    NeotestFailed = { fg = colors.error },
    NeotestFile = { fg = colors.azure },
    NeotestFocused = { bold = true },
    NeotestIndent = { fg = colors.border },
    NeotestMarked = { fg = colors.amber, bold = true },
    NeotestNamespace = { fg = colors.lavender },
    NeotestPassed = { fg = colors.ok },
    NeotestRunning = { fg = colors.amber },
    NeotestSkipped = { fg = colors.hint },
    NeotestTarget = { fg = colors.iris },
    NeotestTest = { fg = colors.fg1 },
    NeotestUnknown = { fg = colors.fg3 },
    NeotestWatching = { fg = colors.amber },
    NeotestWinSelect = { fg = colors.azure, bold = true },
  }

  -- Oil.nvim
  local oil = {
    OilDir = { fg = colors.azure },
    OilDirIcon = { fg = colors.azure },
    OilFile = { fg = colors.fg1 },
    OilLink = { fg = colors.mint },
    OilLinkTarget = { fg = colors.fg3 },
    OilSocket = { fg = colors.iris },
    OilCopy = { fg = colors.sage },
    OilMove = { fg = colors.amber },
    OilChange = { fg = colors.warn },
    OilCreate = { fg = colors.git_add },
    OilDelete = { fg = colors.git_delete },
    OilPermissionNone = { fg = colors.fg3 },
    OilPermissionRead = { fg = colors.sage },
    OilPermissionWrite = { fg = colors.amber },
    OilPermissionExecute = { fg = colors.mauve },
    OilTypeDir = { fg = colors.azure },
    OilTypeFile = { fg = colors.fg1 },
    OilTypeLink = { fg = colors.mint },
    OilTypeFifo = { fg = colors.iris },
    OilTypeSocket = { fg = colors.iris },
    OilSize = { fg = colors.fg3 },
    OilMtime = { fg = colors.fg3 },
  }

  -- Harpoon
  local harpoon = {
    HarpoonWindow = { fg = colors.fg1, bg = bg_float },
    HarpoonBorder = { fg = colors.border, bg = bg_float },
    HarpoonTitle = { fg = colors.azure, bold = true },
    HarpoonCurrentFile = { fg = colors.sage },
  }

  -- Octo.nvim
  local octo = {
    OctoEditable = { bg = colors.bg1 },
    OctoViewer = { link = "Comment" },
    OctoBubble = { fg = colors.fg1, bg = colors.bg2 },
    OctoUser = { fg = colors.azure },
    OctoUserViewer = { fg = colors.sage },
    OctoReaction = { fg = colors.amber },
    OctoReactionViewer = { fg = colors.sage },
    OctoPassingTest = { fg = colors.ok },
    OctoFailingTest = { fg = colors.error },
    OctoPullAdditions = { fg = colors.git_add },
    OctoPullDeletions = { fg = colors.git_delete },
    OctoPullModifications = { fg = colors.git_change },
    OctoIssueTitle = { fg = colors.azure, bold = true },
    OctoPullTitle = { fg = colors.azure, bold = true },
    OctoIssueId = { fg = colors.iris },
    OctoPullId = { fg = colors.iris },
    OctoStateOpen = { fg = colors.sage },
    OctoStateClosed = { fg = colors.mauve },
    OctoStateMerged = { fg = colors.iris },
    OctoStatePending = { fg = colors.amber },
    OctoStatusColumn = { fg = colors.fg3 },
    OctoTimelineMarker = { fg = colors.border },
    OctoTimelineItemHeading = { fg = colors.azure },
    OctoSymbol = { fg = colors.iris },
    OctoDate = { fg = colors.fg3 },
  }

  -- Apply all highlight groups
  set_highlights(editor)
  set_highlights(syntax)
  set_highlights(diagnostics)
  set_highlights(treesitter)
  set_highlights(lsp_semantic)
  set_highlights(lsp)
  set_highlights(cmp)
  set_highlights(blink)
  set_highlights(telescope)
  set_highlights(neo_tree)
  set_highlights(nvim_tree)
  set_highlights(gitsigns)
  set_highlights(gitgutter)
  set_highlights(which_key)
  set_highlights(dashboard)
  set_highlights(indent_blankline)
  set_highlights(rainbow)
  set_highlights(mini)
  set_highlights(illuminate)
  set_highlights(lazy)
  set_highlights(mason)
  set_highlights(noice)
  set_highlights(notify)
  set_highlights(flash)
  set_highlights(trouble)
  set_highlights(navic)
  set_highlights(aerial)
  set_highlights(bufferline)
  set_highlights(snacks)
  set_highlights(fidget)
  set_highlights(neogit)
  set_highlights(diffview)
  set_highlights(lspsaga)
  set_highlights(copilot)
  set_highlights(dap)
  set_highlights(neotest)
  set_highlights(oil)
  set_highlights(harpoon)
  set_highlights(octo)

  -- Apply user overrides
  if cfg.highlights and type(cfg.highlights) == "table" then
    set_highlights(cfg.highlights)
  end
end

return M
