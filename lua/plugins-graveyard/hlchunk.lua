-- This plugin draws lines to show the current scope

return {
  "shellRaining/hlchunk.nvim",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  opts = {
      chunk = {
          enable = true,
      }
  },
}
