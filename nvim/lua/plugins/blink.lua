return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = 'rafamadriz/friendly-snippets',
  version = '*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- See the full "keymap" documentation for information on defining your own keymap.
    keymap = { preset = 'default' },

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- Will be removed in a future release
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },

    completion = {
      list = {
        selection = {
          auto_insert = true,
          preselect = false,
        }
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
      },
      -- NOTE: use ghost_text by default, and open menu manually? less busy??
      -- fuzzy type to get what I am looking for, and then accept. When I don't know what I am looking for then I can open up
      -- this could work well with copilot too so its not too busy having both
      menu = {
        auto_show = true,
        draw = {
          columns = { { "label", "label_description", gap = 1 }, { "kind" } }
        }
      },
      ghost_text = {
        enabled = false
      },
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
