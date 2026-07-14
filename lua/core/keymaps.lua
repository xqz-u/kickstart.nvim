do
  -- Set <space> as the leader key
  -- See `:help mapleader`
  --  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  -- [[ Basic Keymaps ]]
  --  See `:help vim.keymap.set()`

  -- Clear highlights on search when pressing <Esc> in normal mode
  --  See `:help hlsearch`
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

  -- Diagnostic Config & Keymaps
  --  See `:help vim.diagnostic.Opts`
  vim.diagnostic.config {
    update_in_insert = false,
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = { min = vim.diagnostic.severity.WARN } },

    -- Can switch between these as you prefer
    virtual_text = true, -- Text shows up at the end of the line
    virtual_lines = false, -- Text shows up underneath the line, with virtual lines

    -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
    jump = {
      on_jump = function(_, bufnr)
        vim.diagnostic.open_float {
          bufnr = bufnr,
          scope = 'cursor',
          focus = false,
        }
      end,
    },
  }

  vim.keymap.set(
    'n',
    '<leader>q',
    vim.diagnostic.setloclist,
    { desc = 'Open diagnostic [Q]uickfix list' }
  )

  -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
  -- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
  -- is not what someone will guess without a bit more experience.
  --
  -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
  -- or just use <C-\><C-n> to exit terminal mode
  vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

  -- TIP: Disable arrow keys in normal mode
  vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
  vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
  vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
  vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

  -- Keybinds to make split navigation easier.
  -- Use CTRL+<hjkl> to switch between windows, from both normal and terminal mode
  -- (the terminal variant first leaves terminal mode so you can jump straight out
  -- of a terminal split). See `:help wincmd` for a list of all window commands.
  for key, dir in pairs { h = 'left', l = 'right', j = 'lower', k = 'upper' } do
    vim.keymap.set(
      'n',
      '<C-' .. key .. '>',
      '<C-w><C-' .. key .. '>',
      { desc = 'Move focus to the ' .. dir .. ' window' }
    )
    vim.keymap.set(
      't',
      '<C-' .. key .. '>',
      '<C-\\><C-n><C-w>' .. key,
      { desc = 'Move focus to the ' .. dir .. ' window' }
    )
  end

  -- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
  -- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
  -- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
  -- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
  -- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

  -- [[ Basic Autocommands ]]
  --  See `:help lua-guide-autocommands`

  -- Highlight when yanking (copying) text
  --  Try it with `yap` in normal mode
  --  See `:help vim.hl.on_yank()`
  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function() vim.hl.on_yank() end,
  })

  -- quit & close buffer
  vim.keymap.set('n', '<C-q>', '<cmd> bdelete <CR>', { desc = 'Close and [q]uit buffer' })

  -- delete single character without copying into register
  vim.keymap.set('n', 'x', '"_x')

  -- Resize with arrows
  vim.keymap.set('n', '<Up>', '<cmd> resize -2 <CR>')
  vim.keymap.set('n', '<Down>', '<cmd> resize +2 <CR>')
  vim.keymap.set('n', '<Left>', '<cmd> vertical resize -2 <CR>')
  vim.keymap.set('n', '<Right>', '<cmd> vertical resize +2 <CR>')

  vim.keymap.set(
    'n',
    '<leader><Tab>',
    '<cmd> bprevious <CR>',
    { desc = 'Switch to previous buffer' }
  )

  vim.keymap.set(
    'n',
    '<leader>w',
    '<cmd> noautocmd w <CR>',
    { desc = 'Save file [w]ithout auto-formatting' }
  )

  vim.keymap.set('n', '<leader>by', function()
    local path = vim.fn.expand '%:p'
    vim.fn.setreg('+', path)
    vim.notify('Yanked: ' .. path)
  end, { desc = '[B]uffer [Y]ank path' })
end
