-- [[ Formatting ]]
local gh = require('core.functions').gh

vim.pack.add { gh 'stevearc/conform.nvim' }

require('conform').setup {
  notify_on_error = true,
  format_on_save = function(bufnr)
    -- You can specify filetypes to autoformat on save here:
    local enabled_filetypes = {
      lua = true,
      markdown = true,
      python = true,
    }
    if enabled_filetypes[vim.bo[bufnr].filetype] then
      return { timeout_ms = 500 }
    else
      return nil
    end
  end,
  default_format_opts = {
    lsp_format = 'fallback', -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
  },
  -- You can also specify external formatters in here.
  formatters_by_ft = {
    -- rust = { 'rustfmt' },
    -- Conform can also run multiple formatters sequentially
    -- python = { "isort", "black" },
    --
    -- You can use 'stop_after_first' to run the first available formatter from the list
    -- javascript = { "prettierd", "prettier", stop_after_first = true },
    --- style from .stylua.toml; lua_ls formatting is disabled in lsp-mason.lua
    lua = { 'stylua' },
    markdown = { 'markdownlint-cli2' },
    --   ruff_fix             -> source.fixAll   (apply safe lint autofixes)
    --   ruff_organize_imports-> source.organizeImports
    --   ruff_format          -> ruff format
    python = { 'ruff_fix', 'ruff_organize_imports', 'ruff_format' },
  },
}

vim.keymap.set(
  { 'n', 'v' },
  '<leader>f',
  function() require('conform').format { async = true } end,
  { desc = '[F]ormat buffer' }
)
