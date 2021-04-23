local telescope = require'telescope'
local actions = require'telescope.actions'

function print_r(arr, indentLevel)
    local str = ""
    local indentStr = "#"

    if(indentLevel == nil) then
        print(print_r(arr, 0))
        return
    end

    for i = 0, indentLevel do
        indentStr = indentStr.."\t"
    end

    for index,value in pairs(arr) do
        if type(value) == "table" then
            str = str..indentStr..index..": \n"..print_r(value, (indentLevel + 1))
        else 
            str = str..indentStr..index..": "..value.."\n"
        end
    end
    return str

end

function CloseHiddenBuffers()
  local visible_buffers = {}
  for _, value in ipairs(vim.fn.getbufinfo({ bufloaded = 1 })) do
    print_r(value.bufnr)
  end
  print('---')
  for _, value in pairs(vim.fn.tabpagebuflist()) do
    print(value)
  end
end

telescope.setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-x>"] = function (prompt_bufnr)
          local picker = actions.get_current_picker(prompt_bufnr)
          local multi_selection = picker:get_multi_selection()
          if (next(multi_selection) ~= nil) then
            for _, selected in ipairs(multi_selection) do
              pcall(vim.cmd, string.format([[silent bdelete! %s]], selected.bufnr))
            end
            actions.close(prompt_bufnr)
          end

          local selected = vim.tbl_keys(actions.get_selected_entry())
          pcall(vim.cmd, string.format([[silent bdelete! %s]], selected.bufnr))
          actions.close(prompt_bufnr)
        end,
      },
    },
    prompt_position = 'bottom',
    prompt_prefix = '> ',
    selection_caret = '> ',
    entry_prefix = '  ',
    initial_mode = 'insert',
    hidden = 'true',
    selection_strategy = 'reset',
    sorting_strategy = 'descending',
    layout_strategy = 'horizontal',
    layout_defaults = {
      horizontal = {
        mirror = false,
        preview_width = 0.5
      },
      vertical = {
        mirror = false
      }
    },
    file_sorter = require 'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter = require 'telescope.sorters'.get_generic_fuzzy_sorter,
    shorten_path = true,
    winblend = 0,
    width = 0.75,
    preview_cutoff = 120,
    results_height = 1,
    results_width = 0.8,
    border = {},
    borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
    color_devicons = true,
    use_less = true,
    set_env = {['COLORTERM'] = 'truecolor'}, -- default = nil,
    file_previewer = require 'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require 'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require 'telescope.previewers'.vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require 'telescope.previewers'.buffer_previewer_maker
  },
  extensions = {
    media_files = {
      filetypes = {'png', 'webp', 'jpg', 'jpeg'},
      find_cmd = 'rg' -- find command (defaults to `fd`)
    }
  }
}

telescope.load_extension('media_files')
telescope.load_extension('gh')
