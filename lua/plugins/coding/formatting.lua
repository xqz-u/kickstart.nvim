-- [[ Formatting ]]
local gh = require('core.functions').gh

vim.pack.add { gh 'stevearc/conform.nvim' }

local formatters_by_ft = {
  --- style from .stylua.toml; lua_ls formatting is disabled in lsp-mason.lua
  lua = { 'stylua' },
  markdown = { 'markdownlint-cli2' },
  --   ruff_fix             -> source.fixAll   (apply safe lint autofixes)
  --   ruff_organize_imports-> source.organizeImports
  --   ruff_format          -> ruff format
  python = { 'ruff_fix', 'ruff_organize_imports', 'ruff_format' },
}

-- Filetypes formatted by prettier
local prettier_ft = {
  'javascript',
  'javascriptreact',
  'typescript',
  'typescriptreact',
  'svelte',
  'css',
  'scss',
  'less',
  'html',
  'json',
  'jsonc',
  'yaml',
  'graphql',
}

for _, ft in ipairs(prettier_ft) do
  formatters_by_ft[ft] = { 'prettier' }
end

require('conform').setup {
  notify_on_error = true,
  -- Format on save for every filetype that has a formatter configured
  format_on_save = function(bufnr)
    if formatters_by_ft[vim.bo[bufnr].filetype] then return { timeout_ms = 500 } end
  end,
  default_format_opts = {
    lsp_format = 'fallback', -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
  },
  formatters_by_ft = formatters_by_ft,
}

vim.keymap.set(
  { 'n', 'v' },
  '<leader>f',
  function() require('conform').format { async = true } end,
  { desc = '[F]ormat buffer' }
)
