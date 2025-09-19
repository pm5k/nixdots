-- onedarkpro
-- https://github.com/olimorris/onedarkpro.nvim

return {
  'olimorris/onedarkpro.nvim',
  priority = 1000, -- Ensure it loads first
  config = function()
    -- Set the colorscheme after the plugin is loaded
    vim.cmd 'colorscheme onedark'
  end,
}
