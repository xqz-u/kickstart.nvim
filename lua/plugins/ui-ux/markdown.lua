local gh = require('core.functions').gh

vim.pack.add {
  gh 'nvim-treesitter/nvim-treesitter',
  gh 'nvim-mini/mini.nvim', -- if you use the mini.nvim suite
  -- 'https://github.com/nvim-mini/mini.icons',        -- if you use standalone mini plugins
  gh 'nvim-tree/nvim-web-devicons', -- if you prefer nvim-web-devicons
  gh 'MeanderingProgrammer/render-markdown.nvim',
}

require('render-markdown').setup {}

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('markdown_keys', { clear = true }),
  pattern = 'markdown',
  callback = function(args)
    vim.keymap.set('n', '<leader>tm', '<cmd>RenderMarkdown toggle<cr>', {
      buffer = args.buf,
      desc = '[T]oggle [M]arkdown render',
    })
  end,
})
