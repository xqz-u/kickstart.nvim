local gh = require('core.functions').gh

vim.pack.add {
  gh 'nvim-tree/nvim-web-devicons',
  gh 'nvim-lualine/lualine.nvim',
}

require('lualine').setup {
  sections = {
    lualine_a = {
      -- Only show the first letter of the Vim mode instead of the full string
      { 'mode', fmt = function(str) return str:sub(1, 1) end },
    },
    lualine_c = {
      {
        'filename',
        -- 1 = path relative to cwd
        path = 1,
        file_status = true,
      },
    },
  },
}
