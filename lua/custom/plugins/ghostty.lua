return {
  'landerson02/ghostty-theme-sync.nvim',
  lazy = false,
  keys = {
    { '<leader>th', '<cmd>GhosttyTheme<cr>', desc = '[Th]eme Switcher' },
  },
  --- @type GhosttySyncConfig
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    -- Persist the chosen colorscheme so it survives nvim restarts.
    -- The plugin rewrites the `vim.cmd.colorscheme(...)` line in this file.
    persist_nvim_theme = true,
    nvim_config_path = '~/.config/nvim/lua/current-theme.lua',
  },
  config = function(_, opts)
    require('ghostty-theme-sync').setup(opts)

    -- Auto-reload Ghostty when colorscheme changes
    vim.api.nvim_create_autocmd('ColorScheme', {
      pattern = '*',
      callback = function()
        -- Small delay to ensure theme is written to config
        vim.defer_fn(function()
          vim.fn.system 'osascript ~/.config/ghostty/reload.scpt 2>/dev/null &'
        end, 100)
      end,
    })
  end,
}
