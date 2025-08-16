local wk = require 'which-key'

return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  lazy = false,

  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    wk.add {
      {
        '<leader>a',
        icon = '',
        desc = 'list():add()',
        function()
          harpoon:list():add()
        end,
      },

      {
        '<leader>l',
        icon = '',
        group = 'Harpoon',
      },

      {
        '<leader>ls',
        icon = '',
        desc = 'toggle_quick_menu',
        function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
      },
      {
        '<leader>la',
        icon = '',
        desc = 'toggle_quick_menu',
        function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
      },

      {
        '<leader>ll',
        icon = '',
        desc = 'harpoon.ui:toggle_quick_menu(harpoon:list())',
        function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
      },

      {
        '<leader>1',
        desc = 'Harpoon file 1',
        icon = '',
        function()
          harpoon:list():select(1)
        end,
      },

      {
        '<leader>2',
        hidden = true,
        function()
          harpoon:list():select(2)
        end,
      },

      {
        '<leader>3',
        hidden = true,
        function()
          harpoon:list():select(3)
        end,
      },

      {
        '<leader>4',
        hidden = true,
        function()
          harpoon:list():select(4)
        end,
      },

      {
        '<leader>5',
        hidden = true,
        function()
          harpoon:list():select(4)
        end,
      },

      {
        '<leader>5',
        hidden = true,
        function()
          harpoon:list():select(5)
        end,
      },

      {
        '<leader>6',
        hidden = true,
        function()
          harpoon:list():select(5)
        end,
      },
    }
  end,
}
