return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = 'rafamadriz/friendly-snippets',
  version = '*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'default',
      ['<C-n>'] = {
        'show',
        'select_next'
      },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
    },

    completion = {
      list = {
        selection = {
          auto_insert = false,
          preselect = true,
        }
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
      },
      menu = {
        -- is it possible to have auto_show false, but still show on trigger character etc
        -- want false so that we can rely mainly on ghost text, but have it show for triggers
        auto_show = false,
        draw = {
          columns = { { "label", "label_description", gap = 1 }, { "kind" } }
        }
      },
      -- only shows when menu "should" show
      ghost_text = {
        enabled = true
      },
      -- these require auto_show to be true
      trigger = {
        -- false will prevent ghost text from showing in most cases
        show_on_keyword = true
      }
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
      providers = {
        copilot = {
          name = 'copilot',
          module = 'blink-cmp-copilot',
          score_offset = 100,
          async = true,
          transform_items = function(_, items)
            local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
            local kind_idx = #CompletionItemKind + 1
            CompletionItemKind[kind_idx] = "Copilot"
            for _, item in ipairs(items) do
              item.kind = kind_idx
            end
            return items
          end,
        }
      }
    },
    signature = { enabled = true }
  },
  opts_extend = { "sources.default" },
}
