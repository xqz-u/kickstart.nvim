-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

vim.pack.add {
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = vim.version.range '*' },
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
}

vim.keymap.set('n', '\\', '<Cmd>Neotree reveal<CR>', { desc = 'NeoTree reveal', silent = true })

require('neo-tree').setup {
  filesystem = {
    window = {
      mappings = {
        ['\\'] = 'close_window',
      },
      width = 35,
      position = 'right',
    },
    filtered_items = {
      visible = true, -- Show hidden files too
    },
    default_component_configs = {
      symlink_target = {
        enabled = true, -- show target of symlinks next to their name
      },
    },
    -- Allows showing the status of multiple git repos even under a non-repo root
    use_libuv_file_watcher = true,
    follow_current_file = { enabled = true, leave_dirs_open = true },
  },
}
