---@diagnostic disable: undefined-global
--# selene: allow(undefined_variable)

local lush = require "lush"
local hsl = lush.hsl

local file_path = vim.fn.stdpath "config" .. "/lua/david/dynamic_colors/matugen.json"

local file, errmsg = io.open(file_path)
if errmsg or not file then
  error(errmsg)
end

local json_str = file:read "*a"
local colors = vim.json.decode(json_str)
file:close()

local bg
if vim.fn.has "gui_running" == 1 then
  bg = colors.surface
else
  bg = "none"
end

local theme = lush(function(injected_functions)
  local sym = injected_functions.sym
  return {
    Italic { gui = "italic" }, -- Italic
    Bold { gui = "bold" }, -- Bold
    BoldItalic { gui = "bold,italic" }, -- Bold
    Underlined { gui = "underline" }, -- Underlined
    Undercurl { gui = "undercurl" }, -- Underlined
    BoldUndercurl { gui = "bold,undercurl" }, -- Underlined
    BoldUnderlined { gui = "bold,underline" }, -- Underlined

    ColorColumn { bg = colors.surface_container_highest },
    Conceal { bg = colors.surface_container_lowest, fg = colors.on_surface_variant }, -- fg = colors.color4
    CurSearch { bg = colors.primary, fg = colors.on_primary, Bold },
    Cursor { fg = colors.primary },
    CursorColumn { bg = hsl(colors.surface_container_highest) },
    CursorIM { Cursor },
    CursorLine { CursorColumn },
    CursorLineNr { Bold },
    DiffAdd { bg = colors.green, fg = colors.black },
    DiffChange { bg = colors.cyan, fg = colors.black },
    DiffDelete { bg = colors.red, fg = colors.white },
    DiffText { fg = colors.on_surface },
    diffAdded { DiffAdd },
    diffChanged { DiffChange },
    diffFile { fg = colors.secondary },
    diffIndexLine { fg = colors.secondary },
    diffRemoved { DiffDelete },
    diffLine { fg = colors.secondary },
    diffNewFile { diffFile },
    diffOldFile { diffFile },
    Directory { fg = colors.primary },
    EndOfBuffer { fg = colors.tertiary },
    ErrorMsg { fg = colors.error, Bold },
    FloatBorder { bg = bg, fg = colors.tertiary, gui = "bold" },
    FloatTitle { bg = bg, fg = colors.tertiary },
    FoldColumn { bg = colors.surface_container_highest, fg = colors.on_surface_variant },
    Folded { FoldColumn },
    IncSearch { CurSearch },
    lCursor { Cursor },
    LineNr { bg = bg, fg = colors.tertiary },
    MatchParen { bg = CursorLine.bg.lighten(10), Bold },
    MsgArea { bg = bg, fg = colors.primary },
    MsgSeparator { fg = colors.secondary, Bold },
    ModeMsg { fg = colors.primary, Bold },
    MoreMsg { fg = colors.tertiary, Bold },
    NonText { fg = colors.outline_variant },
    Normal { bg = bg, fg = colors.on_surface },
    NormalFloat { bg = bg, fg = colors.on_surface_variant },
    NormalNC { Normal },
    NvimInternalError { ErrorMsg },
    Pmenu { NormalFloat },
    PmenuSbar { bg = colors.tertiary },
    PmenuSel { fg = colors.on_primary, bg = colors.primary },
    PmenuThumb { bg = colors.surface_container },
    Question { fg = colors.secondary },
    --    QuickFixLine                           {},
    Search { CurSearch },
    SpecialKey { fg = colors.outline },
    SpellBad {  BoldUndercurl },
    SpellCap { Undercurl },
    SpellLocal { Undercurl },
    SpellRare { Undercurl },
    SignColumn { bg = bg, fg = colors.tertiary },
    StatusLine { bg = colors.surface, fg = colors.primary },
    StatusLineNC { bg = colors.surface, fg = colors.surface },
    StatusLineTerm { StatusLine },
    StatusLineTermNC { StatusLineNC },
    Substitute { Search },
    TabLine { bg = colors.surface_container_high, fg = colors.on_surface },
    TabLineFill { bg = colors.primary, fg = colors.on_primary },
    TabLineSel { fg = colors.primary, Bold },
    TermCursor { Cursor },
    TermCursorNC { Cursor },
    Title { fg = colors.primary, Bold },
    VertSplit { bg = bg, fg = colors.on_surface },
    Visual { bg = colors.tertiary, fg = colors.on_tertiary },
    --    VisualNOS                              {},
    WarningMsg { fg = colors.yellow },
    WildMenu { CurSearch },
    Whitespace { NonText },

    -- These groups are not listed as default vim groups,
    -- but they are defacto standard group names for syntax highlighting.
    -- commented out groups should chain up to their "preferred" group by
    -- default,
    -- Uncomment and edit if you want more specific syntax highlighting.
    Red { fg = hsl(colors.red), Normal },
    Green { fg = hsl(colors.green), Normal },
    Yellow { fg = hsl(colors.yellow).saturate(50), Normal },
    Blue { fg = hsl(colors.blue), Normal },
    Purple { fg = hsl(colors.magenta), Normal },
    Cyan { fg = hsl(colors.cyan), Normal },
    White { fg = hsl(colors.white), Normal },
    Orange { fg = hsl(colors.red).saturate(50).lighten(25), Normal },
    --
    --
    Number { Purple }, --   a number constant: 234, 0xff
    Boolean { Number }, --  a boolean constant: TRUE, false
    Float { Number }, --    a floating point constant: 2.3e10
    sym "@boolean" { Boolean },
    sym "@number" { Number },

    String { fg = hsl(colors.green).saturate(50), Normal }, --   a string constant: "this is a string"
    Character { String }, --  a character constant: "c", "\n"
    sym "@string" { String },
    sym "@string.escape" { Orange },

    Comment { fg = hsl(colors.outline) }, -- (preferred) any special symbol
    sym "@comment" { Comment },
    Ignore { Comment },
    SpecialComment { fg = colors.secondary }, -- special things inside a comment

    Keyword { Red }, --  any other keyword
    sym "@keyword" { Keyword },
    Exception { Keyword }, --  try, catch, throw
    Conditional { Keyword }, --  if, then, else, endif, switch, etc.
    Repeat { Keyword }, --   for, do, while, etc.
    Label { Keyword }, --    case, default, etc.
    sym "@label" { Label },
    sym "@tag" { Label },
    sym "@tag.delimiter" { Label },
    sym "@tag.attribute" { Label },

    Constant { Purple }, -- (preferred) any constant
    sym "@constant" { Constant },
    sym "@constant.builtin" { Orange },

    Operator { Orange }, -- "sizeof", "+", "*", etc.
    sym "@operator" { Operator },
    sym "@keyword.operator" { Red },
    cssTagName { Operator },

    Variable { White },
    Identifier { Variable }, -- (preferred) any variable name
    Statement { Identifier }, -- (preferred) any statement
    sym "@variable" { Variable },
    sym "@lsp.type.variable" { Variable },
    sym "@variable.member" { Blue },
    sym "@variable.parameter" { Blue },
    sym "@lsp.type.property" { Blue },
    sym "@variable.builtin" { Orange },
    cssPseudoClass { Blue }, -- style = "italic"
    cssPseudoClassId { Blue }, -- style = "italic"

    Function { Green, gui = "bold" }, -- function name (also: methods for classes)
    sym "@function.builtin" { Orange, gui = "bold" },
    sym "@lsp.mod.defaultLibrary" { Orange, gui = "bold" },
    sym "@function" { Function },
    sym "@function.method" { Function },
    sym "@lsp.type.function" { Function },
    vimFunction { Function },
    StorageClass { Keyword }, -- static
    sym "@keyword.function" { Red },
    vimCommand { Red },

    Type { Yellow }, -- (preferred) int, long, char, etc.
    Typedef { Type },
    Structure { Keyword },
    sym "@type" { Typedef },
    sym "@lsp.type.class" { Typedef },
    sym "@type.builtin" { Type },

    Include { Cyan }, --  preprocessor #include
    sym "@keyword.import" { Include },
    sym "@annotation" { Cyan },

    Delimiter { Orange }, --  character that needs attention
    sym "@punctuation.delimiter" { Orange },
    sym "@punctuation.special" { Orange },
    sym "@punctuation.bracket" { Orange },

    Define { Comment },
    PreProc { Comment }, -- (preferred) generic Preprocessor
    PreCondit { PreProc },
    sym "@keyword.directive" { Comment },
    Macro { Keyword },
    sym "@function.macro" { Macro },
    sym "@lsp.type.macro" { Macro },

    Special { Blue }, -- (preferred) any special symbol
    SpecialChar { Special },
    Tag { Label }, --    you can use CTRL-] on this
    Todo { fg = colors.on_secondary, bg = colors.secondary }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX
    sym "@comment.todo" { Todo },
    Error { bg = colors.error, fg = colors.on_error }, -- (preferred) any erroneous construct

    --    qfLineNr                               {},
    qfFileName { Directory },

    htmlH1 { Bold }, -- style = "bold"
    htmlH2 { Bold }, -- style = "bold"

    markdownH1 { fg = colors.primary, Bold },
    sym "@markup.heading.1" { markdownH1 },
    markdownH2 { fg = colors.secondary, Bold },
    sym "@markup.heading.2" { markdownH2 },
    markdownH3 { fg = colors.tertiary, Bold },
    sym "@markup.heading.3" { markdownH3 },
    markdownH4 { fg = colors.primary },
    sym "@markup.heading.4" { markdownH4 },
    markdownH5 { fg = colors.secondary },
    sym "@markup.heading.5" { markdownH5 },
    markdownH6 { fg = colors.tertiary },
    sym "@markup.heading.6" { markdownH6 },

    mkdDelimiter { fg = colors.outline_variant },
    sym "@markup.raw.block" { mkdDelimiter },
    sym "@markup.raw.delimiter" { mkdDelimiter },
    sym "@label.markdown" { mkdDelimiter },
    sym "@conceal.markdown_inline" { mkdDelimiter },
    sym "@markup.strong" { Bold },
    sym "@markup.italic" { Italic },
    sym "@markup.quote" { fg = colors.tertiary, BoldItalic },
    sym "@markup.raw" { Blue },
    sym "@markup.list.checked" { fg = colors.on_primary, bg = colors.primary },
    sym "@markup.list" { fg = colors.outline },

    mkdLink { Bold }, -- style = "underline"
    sym "@markup.link.label" { mkdLink },
    markdownLinkText { fg = colors.primary, Underlined },
    sym "@markup.link.url" { markdownLinkText },

    Debug { Special },
    debugPC { bg = colors.tertiary, fg = colors.on_tertiary }, -- used for highlighting the current line in terminal-debug
    debugBreakpoint { fg = colors.red }, -- used for breakpoint colors in terminal-debug
    DiagnosticError { fg = colors.red },
    DiagnosticHint { fg = colors.blue },
    DiagnosticInfo { fg = colors.cyan },
    DiagnosticWarn { fg = colors.yellow },
    DiagnosticDefaultError { DiagnosticError },
    DiagnosticDefaultHint { DiagnosticHint },
    DiagnosticDefaultInfo { DiagnosticInfo },
    DiagnosticDefaultWarn { DiagnosticWarn },
    DiagnosticFloatingError { DiagnosticError },
    DiagnosticFloatingHint { DiagnosticHint },
    DiagnosticFloatingInfo { DiagnosticInfo },
    DiagnosticFloatingWarn { DiagnosticWarn },
    DiagnosticSignError { DiagnosticError },
    DiagnosticSignHint { DiagnosticHint },
    DiagnosticSignInfo { DiagnosticInfo },
    DiagnosticSignWarn { DiagnosticWarn },
    DiagnosticStatusLineError { DiagnosticError },
    DiagnosticStatusLineHint { DiagnosticHint },
    DiagnosticStatusLineInfo { DiagnosticInfo },
    DiagnosticStatusLineWarn { DiagnosticWarn },
    DiagnosticUnderlineError { gui = "undercurl" },
    DiagnosticUnderlineHint { gui = "undercurl" },
    DiagnosticUnderlineInfo { gui = "undercurl" },
    DiagnosticUnderlineWarn { gui = "undercurl" },
    DiagnosticVirtualTextError { DiagnosticError },
    DiagnosticVirtualTextHint { DiagnosticHint },
    DiagnosticVirtualTextInfo { DiagnosticInfo },
    DiagnosticVirtualTextWarn { DiagnosticWarn },

    -- typescript
    --    sym("@import.identifier.typescript")   {},
    --    typescriptBlock                        {},
    --    typescriptIdentifierName               {},
    --    typescriptTSInclude                    {},
    --    typescriptEnum                         {},
    --    typescriptTypeCast                     {},
    --    typescriptParenExp                     {},
    --    typescriptObjectType                   {},
    --

    --    LspReferenceText                       {},
    --    LspReferenceRead                       {},
    --    LspReferenceWrite                      {},
    --    LspCodeLens                            {}, -- virtual text of code lens
    --    LspCodeLensSeparator                   {}, -- separator between two or more code lens
    --    LspSignatureActiveParameter            {},
    --
    -- nvim-ts-rainbow
    rainbowcol1 { fg = colors.primary },
    rainbowcol2 { fg = colors.secondary },
    rainbowcol3 { fg = colors.tertiary },
    rainbowcol4 { rainbowcol1 },
    rainbowcol5 { rainbowcol2 },
    rainbowcol6 { rainbowcol3 },
    rainbowcol7 { rainbowcol1 },

    -- Gitsigns
    GitSignsAdd { fg = colors.green },
    GitSignsChange { fg = colors.cyan },
    GitSignsDelete { fg = colors.red },
    SignAdd { GitSignsAdd },
    SignChange { GitSignsChange },
    SignDelete { GitSignsDelete },

    -- GitGutter
    GitGutterAdd { DiffAdd }, -- diff mode: Added line |diff.txt|
    GitGutterChange { DiffChange }, -- diff mode: Changed line |diff.txt|
    GitGutterDelete { DiffDelete }, -- diff mode: Deleted line |diff.txt|

    -- indent-blankline.nvim
    IndentBlanklineChar { Comment },
    IndentBlanklineContextChar { fg = colors.primary }, -- gui = "nocombine"
    IndentBlanklineContextStart { IndentBlanklineContextChar, gui = "underline" }, -- gui = "underline"
    IndentBlanklineSpaceChar { IndentBlanklineChar },
    IndentBlanklineSpaceCharBlankline { IndentBlanklineChar },

    -- nvim-cmp
    CmpDocumentationBorder { fg = colors.primary, bg = colors.surface_variant },
    CmpItemAbbr { fg = colors.on_surface },
    CmpItemAbbrDeprecated { fg = colors.outline, ui = "strikethrough" },
    CmpItemAbbrMatch { BoldUnderlined },
    CmpItemAbbrMatchFuzzy { CmpItemAbbrMatch },
    CmpItemKind { fg = colors.secondary },
    CmpItemKindClass { CmpItemKind },
    CmpItemKindFunction { CmpItemKind },
    CmpItemKindInterface { CmpItemKind },
    CmpItemKindMethod { CmpItemKind },
    CmpItemKindSnippet { CmpItemKind },
    CmpItemKindVariable { CmpItemKind },
    CmpItemMenu { CmpItemKind, bg = color.on_surface_variant },

    -- telescope.nvim
    TelescopeMatching { BoldUnderlined },
    --    TelescopeNormal                        {},
    TelescopeSelection { PmenuSel },
    TelescopeTitle { fg = colors.primary, Bold },
    TelescopeBorder { bg = bg, fg = colors.primary },
    TelescopePromptBorder { TelescopeBorder },
    TelescopePromptNormal { fg = colors.on_surface },
    TelescopePromptPrefix { fg = colors.primary, Bold },
    TelescopePreviewTitle { fg = colors.secondary, Bold },
    TelescopePromptTitle { TelescopePreviewTitle },
    TelescopeResultsDiffAdd { DiffAdd },
    TelescopeResultsDiffChange { DiffChange },
    TelescopeResultsDiffDelete { DiffDelete },

    -- LspTrouble
    LspTroubleText { fg = colors.on_surface_variant },
    LspTroubleCount { fg = colors.tertiary },
    LspTroubleNormal { fg = colors.secondary },

    -- Neogit
    --    NeogitBranch                           {},
    --    NeogitRemote                           {},
    --    NeogitHunkHeader                       {},
    --    NeogitDiffContextHighlight             {},

    -- NeoVim
    healthError { Error },
    healthSuccess { bg = colors.primary_container, fg = colors.on_primary_container },
    healthWarning { bg = colors.secondary_container, fg = colors.on_secondary },

    -- here I put things to fix stuff
    luaParenError { Normal },
    markdownError { Normal },
  }
end)

return theme
