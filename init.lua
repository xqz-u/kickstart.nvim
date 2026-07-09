do
  -- Enable faster startup by caching compiled Lua modules
  vim.loader.enable()

  require 'core.keymaps'
  require 'core.options'
end

-- ============================================================
-- SECTION 3: PLUGIN MANAGER INTRO
-- ============================================================
do
  require 'core.plugin-manager'
end

-- ============================================================
-- SECTION 4: UI / CORE UX PLUGINS
-- ============================================================
do
  -- [[ Installing and Configuring Plugins ]]
  --
  -- To install a plugin simply call `vim.pack.add` with its git url.
  -- This will download the default branch of the plugin, which will usually be `main` or `master`
  -- You can also have more advanced specs, which we will talk about later.
  --
  -- For most plugins its not enough to install them, you also need to call their `.setup()` to start them.
  --
  require 'plugins.ui-ux.guess-indent'
  require 'plugins.ui-ux.gitsigns'
  require 'plugins.ui-ux.which-key'
  require 'plugins.ui-ux.colorscheme'
  require 'plugins.ui-ux.todo-comments'
  require 'plugins.ui-ux.mini'
  require 'plugins.ui-ux.lualine'
  require 'plugins.ui-ux.bufferline'
  require 'plugins.ui-ux.snacks'
  require 'plugins.ui-ux.markdown'
end

-- ============================================================
-- SECTION 5: SEARCH & NAVIGATION
-- ============================================================
-- do
--   -- Telescope disabled in favor of the Snacks picker ('plugins.ui-ux.snacks').
--   -- require 'plugins.telescope'
-- end

-- ============================================================
-- SECTION 6 to 9: Coding setup.
-- LSP, formatting, autocomplete, snippets, treesitter
-- ============================================================
do
  require 'plugins.coding.lsp-mason'
  require 'plugins.coding.formatting'
  require 'plugins.coding.snippets'
  require 'plugins.coding.autocomplete'
  require 'plugins.coding.treesitter'
  require 'plugins.coding.claude-code'
end

-- ============================================================
-- SECTION 10: OPTIONAL EXAMPLES / NEXT STEPS
-- kickstart.plugins.* examples
-- ============================================================
do
  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug'
  require 'kickstart.plugins.indent_line'
  require 'kickstart.plugins.lint'
  require 'kickstart.plugins.autopairs'
  -- Using Snacks.explorer()
  -- require 'kickstart.plugins.neo-tree'

  -- NOTE: You can add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  -- require 'custom.plugins'
end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
