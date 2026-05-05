-- noice.nvim: replaces cmdline / messages / popupmenu with floating UI
-- https://github.com/folke/noice.nvim
return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
    {
      'rcarriga/nvim-notify',
      opts = {
        timeout = 2500,
        max_width = 80,
        stages = 'fade',          -- 'fade' / 'slide' / 'fade_in_slide_out' / 'static'
        render = 'compact',       -- 'default' / 'minimal' / 'simple' / 'compact' / 'wrapped-compact'
        top_down = false,         -- show notifications from the bottom
        background_colour = 'NotifyBackground',
      },
    },
  },
  opts = {
    cmdline = {
      enabled = true,
      view = 'cmdline_popup',     -- centered floating cmdline
    },
    messages = {
      enabled = true,
      view = 'notify',            -- route :echo etc. through nvim-notify
      view_error = 'notify',
      view_warn = 'notify',
      view_history = 'messages',
      view_search = 'virtualtext',
    },
    popupmenu = {
      enabled = true,
      backend = 'nui',
    },
    lsp = {
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
      hover = { enabled = true },
      signature = { enabled = true },
      progress = { enabled = true, view = 'mini' },
    },
    presets = {
      bottom_search = false,        -- search popup floats, not pinned to bottom
      command_palette = true,       -- cmdline + popupmenu together, centered
      long_message_to_split = true, -- long messages open in a split
      inc_rename = false,
      lsp_doc_border = true,        -- rounded borders for LSP hover/signature
    },
    routes = {
      -- Send "written" / "lines yanked" / etc. to a mini view in the corner
      -- instead of a notify popup (less noisy).
      {
        filter = {
          event = 'msg_show',
          any = {
            { find = '%d+L, %d+B' },           -- "X lines, Y bytes" on save
            { find = '; after #%d+' },         -- undo/redo info
            { find = '; before #%d+' },
            { find = '%d fewer lines' },
            { find = '%d more lines' },
            { find = '^E486' },                -- pattern not found (let search handle)
          },
        },
        view = 'mini',
      },
    },
  },
}
