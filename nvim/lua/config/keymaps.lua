-- Neovim Keymaps Configuration
-- All custom keybindings and shortcuts

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier
-- Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Oil (Dir Tree) opens on space+tab
vim.keymap.set('n', '<leader><Tab>', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

-- Q in normal mode should do nothing
vim.keymap.set('n', 'Q', '<nop>')

-- Disable space in normal and visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Paste copied text from the unnamed register without clearing the register
-- allowing you to paste it repeatedly if needed
vim.keymap.set('x', '<leader>p', [["_dP]])

-- Remap for dealing with word wrap
-- Essentially allowing you to skip wrapped lines
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })

-- Keep search terms in the middle of screen when using
-- / or ? to search and then "n" or "N" to go to next/previous match
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Move half a screen up/down and keep cursor in the middle
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')

-- Convenience bind for escaping insert mode
vim.keymap.set('i', '<C-c>', '<Esc>')

-- Only active if not inside VSCode's nvim plugin to avoid conflicts with VSC binds
if not vim.g.vscode then
  -- Move line/selection up
  vim.keymap.set('n', '<M-k>', ':m .-2<CR>')
  vim.keymap.set('v', '<M-k>', ':m -2<CR>gv=gv')

  -- Move line/selection down
  vim.keymap.set('n', '<M-j>', ':m .+1<CR>')
  vim.keymap.set('v', '<M-j>', ":m '>+<CR>gv=gv")

  -- Convenience bind to enable syntax highlight on buffers
  -- Uses the `langlist.lua` import and populates the language selection accordingly
  vim.keymap.set('n', '<leader>ll', function()
    local langlist = require 'langlist'
    vim.ui.select(langlist, {
      prompt = 'Select language for syntax highlighting:',
      format_item = function(item)
        return item
      end,
    }, function(choice)
      if choice then
        vim.opt.filetype = choice
      end
    end)
  end, { desc = 'Select language for syntax highlighting' })
end

-- Search project TODOs using todo-comments plugin
vim.keymap.set('n', '<leader>t', '<CMD>TodoTelescope<CR>', { desc = 'Search project TODO using Telescope' })

-- Custom user commands
vim.api.nvim_create_user_command('DBUIEditConnectionsJSON', function()
  vim.cmd 'edit ~/.local/share/db_ui/connections.json'
end, { nargs = 0, desc = 'Edit database UI connections JSON file' })