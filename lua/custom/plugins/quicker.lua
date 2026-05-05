-- quicker.nvim: modernized quickfix list
-- - editable qf (refactor across files, save to apply)
-- - expandable context lines around matches
-- - severity-aware highlighting for diagnostics
-- https://github.com/stevearc/quicker.nvim
return {
  'stevearc/quicker.nvim',
  ft = 'qf',
  dependencies = { 'folke/which-key.nvim' },
  keys = {
    {
      '<leader>q',
      function()
        require('quicker').toggle()
      end,
      desc = 'toggle quickfix',
    },
    {
      '<leader>Q',
      function()
        require('quicker').toggle { loclist = true }
      end,
      desc = 'toggle loclist',
    },
  },
  opts = {
    -- Auto-fit filename column.
    max_filename_width = function()
      return math.floor(math.min(80, vim.o.columns / 4))
    end,
    -- Resize the quickfix window taller than vim's default 10 rows.
    -- Caps at ~1/3 of screen so it never dominates.
    on_qf = function(bufnr)
      local target = math.min(20, math.floor(vim.o.lines / 3))
      vim.cmd(('resize %d'):format(target))
    end,
    -- Quickfix-window-local options.
    opts = {
      buflisted = false,
      number = false,
      relativenumber = false,
      signcolumn = 'auto',
      winfixheight = true,
      wrap = false,
    },
    -- Editable quickfix: edit text in the qf buffer, :w applies to all files.
    edit = {
      enabled = true,
      autosave = 'unmodified',
    },
    -- Treesitter / LSP highlighting for results.
    highlight = {
      treesitter = true,
      lsp = true,
      load_buffers = false,
    },
    -- Severity icons (matches your diagnostic.config signs).
    type_icons = {
      E = '\u{f015a} ',
      W = '\u{f002a} ',
      I = '\u{f02fd} ',
      N = '\u{f0335} ',
      H = '\u{f0336} ',
    },
    -- Buffer-local keymaps inside the quickfix window.
    keys = {
      {
        '>',
        function()
          require('quicker').expand { before = 2, after = 2, add_to_existing = true }
        end,
        desc = 'expand context',
      },
      {
        '<',
        function()
          require('quicker').collapse()
        end,
        desc = 'collapse context',
      },
    },
  },
  config = function(_, opts)
    require('quicker').setup(opts)

    -- Register the leader keymaps with which-key so they show icons in the
    -- popup. The actual mappings are created by lazy's `keys` block above.
    local wk = require 'which-key'
    wk.add {
      { '<leader>q',  icon = '\u{f0279}', desc = 'toggle quickfix' },
      { '<leader>Q',  icon = '\u{f0279}', desc = 'toggle loclist' },
    }
  end,
}
