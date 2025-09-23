-- autopairs with mini.pairs
-- Part of mini.nvim ecosystem

return {
  'echasnovski/mini.nvim',
  config = function()
    -- Mini.pairs for automatic bracket pairing
    require('mini.pairs').setup()
  end,
}
