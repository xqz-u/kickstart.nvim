local gh = require('core.functions').gh

vim.pack.add {
  gh 'nvim-lua/plenary.nvim', -- Required for git operations
  gh 'greggh/claude-code.nvim',
}

require('claude-code').setup {
  window = {
    position = 'float',
  },
  command = 'claudeboxed --yolo',
}
