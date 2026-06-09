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
    -- Map our nvim colorscheme name -> the value Ghostty expects in `theme = ...`.
    -- Ghostty's theme lookup is case-insensitive on filename but space-sensitive,
    -- and the real theme file is "Everforest Dark Hard" (single spaces).
    local translations = require 'ghostty-theme-sync.translations'
    translations.nvim_to_ghostty['everforest'] = 'everforest dark hard'

    -- The plugin's picker only shows colorschemes whose translated name is
    -- present in its bundled ghostty_themes.txt. That file is missing/mismatched
    -- for some themes (e.g. everforest uses double-spaces there), so patch the
    -- picker to also include our manually-mapped schemes.
    local sync = require 'ghostty-theme-sync.sync'
    local extra_schemes = { 'everforest' }
    local original_pick = sync.pick_theme
    sync.pick_theme = function()
      local themes = sync.get_overlap()
      local seen = {}
      for _, t in ipairs(themes) do
        seen[t] = true
      end
      for _, t in ipairs(extra_schemes) do
        if not seen[t] then
          table.insert(themes, t)
        end
      end
      table.sort(themes)
      vim.ui.select(themes, { prompt = 'Select a theme to sync:' }, function(selected)
        if selected then
          sync.set_colorscheme(selected)
        end
      end)
    end
    _ = original_pick -- silence unused

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
