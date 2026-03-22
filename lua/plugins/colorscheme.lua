return {
  'EdenEast/nightfox.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    require('nightfox').setup {
      options = {
        transparent = 'false',
        styles = {
          comments = 'italic',
          constants = 'bold',
          functions = 'italic',
          keywords = 'italic,bold',
          types = 'italic,bold',
        },
      },
    }

    -- Load the colorscheme
    vim.cmd.colorscheme 'carbonfox'
  end,
}
