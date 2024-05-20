return {
  "rktjmp/lush.nvim",
  lazy = false,
  init = function()
    local m = require "david.dynamic_colors.lush"
    require "lush"(m)
  end,
}
