return {
  'landerson02/ghostty-theme-sync.nvim',
  lazy = false,
  --- @type GhosttySyncConfig
  opts = {
    -- Add your configuration here
  },
  config = function()
    require('ghostty-theme-sync').setup()

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
