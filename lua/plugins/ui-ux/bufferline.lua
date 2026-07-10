-- [[ bufferline.nvim ]]
--  VSCode-like buffer tabs across the top of the editor.
local gh = require('core.functions').gh

vim.pack.add {
  gh 'nvim-tree/nvim-web-devicons',
  gh 'akinsho/bufferline.nvim',
}

require('bufferline').setup {
  options = {
    -- One tab per listed buffer (VSCode style), not per Vim tab page.
    mode = 'buffers',
    diagnostics = 'nvim_lsp',
    -- Small badge with the count of diagnostics on each buffer's tab.
    diagnostics_indicator = function(count, level)
      local icon = level:match 'error' and ' ' or ' '
      return icon .. count
    end,
    -- Keep the sidebar clear: reserve space for neo-tree instead of overlapping it.
    offsets = {
      {
        filetype = 'snacks_picker_list',
        text = 'File Explorer',
        highlight = 'Directory',
        separator = true,
      },
    },
    show_buffer_close_icons = true,
    show_close_icon = false,
  },
}

-- Cycle through buffers. Bracket pairs (no modifiers) so AeroSpace can't grab them.
vim.keymap.set('n', '[b', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Previous buffer' })
vim.keymap.set('n', ']b', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next buffer' })

-- Jump to any buffer tab by letter.
vim.keymap.set('n', '<leader>bp', '<cmd>BufferLinePick<cr>', { desc = '[B]uffer [P]ick' })
