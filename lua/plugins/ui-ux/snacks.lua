local functions = require 'core.functions'

vim.pack.add {
  functions.gh 'folke/todo-comments.nvim', -- optional
  functions.gh 'folke/snacks.nvim',
}

-- Shared between the chafa render size and the dashboard section height so the
-- terminal pane is exactly as tall as the image it renders.
local image_width, image_height = 60, 20

require('snacks').setup {
  lazygit = {},
  -- Enabled to clear the "notifier is not ready" checkhealth error; snacks and
  -- lazygit route their messages through it.
  notifier = { enabled = true },
  bigfile = { enabled = true },
  quickfile = { enabled = true },
  dashboard = {
    formats = {
      key = function(item)
        return { { '[', hl = 'special' }, { item.key, hl = 'key' }, { ']', hl = 'special' } }
      end,
    },
    pane_gap = 4,
    sections = {
      {
        section = 'terminal',
        cmd = functions.random_image_cmd(
          '~/Pictures/nvim-avatars/',
          { width = image_width, height = image_height, stretch = false }
        ),
        width = image_width,
        height = image_height,
      },
      { pane = 2, section = 'header' },
      { pane = 2, section = 'keys', icon = ' ', title = 'Keymaps', indent = 2, padding = 1 },
      {
        pane = 2,
        section = 'recent_files',
        icon = ' ',
        title = 'Recent Files',
        indent = 2,
        padding = 1,
      },
      -- { pane = 2, section = 'projects', icon = ' ', title = 'Projects', indent = 2, padding = 1 },
    },
  },
  terminal = {},
  image = {},
  picker = {
    sources = {
      explorer = {
        hidden = true, -- show hidden files by default
        layout = {
          -- https://github.com/folke/snacks.nvim/blob/882c996cf28183f4d63640de0b4c02ec886d01f2/docs/picker.md?plain=1#L1026
          layout = { position = 'right' },
          -- preview = true,
        },
      },
      -- Search-in-buffer (Snacks.picker.lines) defaults to the bottom 'ivy'
      -- split, use the default layout.
      -- lines = {
      --   layout = {
      --     preset = function() return vim.o.columns >= 120 and 'default' or 'vertical' end,
      --   },
      -- },
    },
  },
  explorer = {},
}

local TERM_OPTS = { win = { position = 'bottom', height = 0.4 } }
local snacks_keybindings = {
  -- Reopen the dashboard on demand (not just at startup).
  { 'n', '<leader>d', function() Snacks.dashboard.open() end, { desc = '[D]ashboard' } },
  -- Notifier history (snacks and lazygit route their messages through it).
  {
    'n',
    '<leader>n',
    function() Snacks.picker.notifications() end,
    { desc = '[N]otification History' },
  },
  -- File explorer
  -- { 'n', '<leader>e', function() Snacks.explorer() end, { desc = 'File [E]xplorer' } },
  { 'n', '\\', function() Snacks.explorer() end, { desc = 'File [E]xplorer' } },

  -- Terminal. Options applied only to shells, keeping lazygit floating.
  -- Window navigation in and out of terminal lives in 'core/keymaps.lua'.
  -- <leader>tt toggles a single persistent shell (same terminal comes back);
  -- <leader>tT always spawns a brand new, independent one.
  {
    { 'n', 't' },
    '<leader>tt',
    function() Snacks.terminal.toggle(nil, TERM_OPTS) end,
    { desc = '[T]erminal' },
  },
  {
    { 'n', 't' },
    '<leader>tT',
    function() Snacks.terminal.open(nil, TERM_OPTS) end,
    { desc = 'New [T]erminal' },
  },
  {
    'n',
    '<leader>tc',
    function() Snacks.picker.colorschemes() end,
    { desc = '[C]olorscheme' },
  },

  -- Delete the current buffer via Snacks so the window/split layout survives.
  { 'n', '<leader>bd', function() Snacks.bufdelete() end, { desc = '[B]uffer [D]elete' } },

  -- Git. '<leader>gs' signifies 'git status', similar to magit in emacs.
  { 'n', '<leader>gs', function() Snacks.lazygit() end, { desc = '[G]it [S]tatus (LazyGit)' } },

  -- Snacks smart/files picker previews images inline, unlike Telescope's previewer.
  { 'n', '<leader>sf', Snacks.picker.smart, { desc = '[F]iles' } },
  {
    'n',
    '<leader>sn',
    function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end,
    { desc = '[N]eovim files' },
  },
  { 'n', '<leader>sp', function() Snacks.picker.projects() end, { desc = '[P]rojects' } },
  { 'n', '<leader>s.', function() Snacks.picker.recent() end, { desc = 'Recent Files' } },
  {
    'n',
    '<leader><space>',
    function() Snacks.picker.buffers() end,
    { desc = '[ ] Find existing buffers' },
  },
  -- grep
  { 'n', '<leader>sg', function() Snacks.picker.grep() end, { desc = 'By [G]rep' } },
  {
    { 'n', 'x' },
    '<leader>sw',
    function() Snacks.picker.grep_word() end,
    { desc = '[W]ord under cursor' },
  },
  {
    'n',
    '<leader>sB',
    function() Snacks.picker.grep_buffers() end,
    { desc = 'Open [B]uffers' },
  },
  -- misc pickers
  -- Registers as a lightweight clipboard viewer: numbered registers 0-9 are
  -- Vim's yank/delete ring, plus the '+'/'*' system clipboard and named ones.
  {
    'n',
    '<leader>sr',
    function() Snacks.picker.registers() end,
    { desc = '[R]egisters' },
  },
  {
    'n',
    '<leader>s/',
    function() Snacks.picker.search_history() end,
    { desc = 'History' },
  },
  { 'n', '<leader>sa', function() Snacks.picker.autocmds() end, { desc = '[A]utocmds' } },
  -- Telescope's '<leader>/' fuzzy-search-in-current-buffer (duplicate to <C-s> to emulate Swiper)
  {
    'n',
    { '<leader>/', '<C-s>' },
    function() Snacks.picker.lines() end,
    { desc = '[/] Fuzzily search in current buffer' },
  },
  {
    'n',
    '<leader>sc',
    function() Snacks.picker.command_history() end,
    { desc = '[C]ommand History' },
  },
  { 'n', '<leader>sC', function() Snacks.picker.commands() end, { desc = '[C]ommands' } },
  {
    'n',
    '<leader>sd',
    function() Snacks.picker.diagnostics() end,
    { desc = '[D]iagnostics' },
  },
  {
    'n',
    '<leader>sD',
    function() Snacks.picker.diagnostics_buffer() end,
    { desc = 'Buffer [D]iagnostics' },
  },
  { 'n', '<leader>sh', function() Snacks.picker.help() end, { desc = '[H]elp' } },
  {
    'n',
    '<leader>sH',
    function() Snacks.picker.highlights() end,
    { desc = '[H]ighlights' },
  },
  { 'n', '<leader>si', function() Snacks.picker.icons() end, { desc = '[I]cons' } },
  { 'n', '<leader>sj', function() Snacks.picker.jumps() end, { desc = '[J]umps' } },
  { 'n', '<leader>sk', function() Snacks.picker.keymaps() end, { desc = '[K]eymaps' } },
  {
    'n',
    '<leader>sL',
    function() Snacks.picker.lsp_config() end,
    { desc = '[L]SP Config' },
  },
  {
    'n',
    '<leader>sl',
    function() Snacks.picker.loclist() end,
    { desc = '[L]ocation List' },
  },
  { 'n', '<leader>sm', function() Snacks.picker.marks() end, { desc = '[M]arks' } },
  { 'n', '<leader>sM', function() Snacks.picker.man() end, { desc = '[M]an Pages' } },
  {
    'n',
    '<leader>sq',
    function() Snacks.picker.qflist() end,
    { desc = '[Q]uickfix List' },
  },
  { 'n', '<leader>sR', function() Snacks.picker.resume() end, { desc = '[R]esume' } },
  {
    'n',
    '<leader>st',
    function() Snacks.picker.pick 'todo_comments' end, -- This syntax silences the Lua linter
    { desc = '[T]odo Comments' },
  },
  { 'n', '<leader>su', function() Snacks.picker.undo() end, { desc = '[U]ndo History' } },
}

functions.set_keymaps(snacks_keybindings)

-- ── Snacks LSP pickers ──────────────────────────────────────────────────────
-- Buffer-local, created on LspAttach so
-- they only exist where a language server is actually attached. References and
-- implementation use the `gr*` family (grr/gri) instead of a bare `gr`, which
-- would shadow Neovim's built-in gr-prefixed LSP maps (grn/gra/...).
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('snacks-lsp-attach', { clear = true }),
  callback = function(event)
    local lsp_keybindings = {
      {
        'n',
        'gd',
        function() Snacks.picker.lsp_definitions() end,
        { desc = '[G]oto [D]efinition' },
      },
      {
        'n',
        'gD',
        function() Snacks.picker.lsp_declarations() end,
        { desc = '[G]oto [D]eclaration' },
      },
      {
        'n',
        'grr',
        function() Snacks.picker.lsp_references() end,
        { desc = '[G]oto [R]eferences', nowait = true },
      },
      {
        'n',
        'gri',
        function() Snacks.picker.lsp_implementations() end,
        { desc = '[G]oto [I]mplementation' },
      },
      {
        'n',
        'gy',
        function() Snacks.picker.lsp_type_definitions() end,
        { desc = '[G]oto T[y]pe Definition' },
      },
      {
        'n',
        'gai',
        function() Snacks.picker.lsp_incoming_calls() end,
        { desc = 'C[a]lls [I]ncoming' },
      },
      {
        'n',
        'gao',
        function() Snacks.picker.lsp_outgoing_calls() end,
        { desc = 'C[a]lls [O]utgoing' },
      },
      {
        'n',
        '<leader>ss',
        function() Snacks.picker.lsp_symbols() end,
        { desc = 'LSP [S]ymbols' },
      },
      {
        'n',
        '<leader>sS',
        function() Snacks.picker.lsp_workspace_symbols() end,
        { desc = 'Workspace [S]ymbols' },
      },
    }

    functions.set_keymaps(lsp_keybindings, { buffer = event.buf })
  end,
})
