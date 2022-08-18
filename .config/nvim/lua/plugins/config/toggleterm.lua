local fn = vim.fn

-- TODO change to something which doesn't rely on neogit internals
local function get_nvim_remote_editor()
  local runtimepath_cmd = fn.shellescape(string.format("set runtimepath^=%s", fn.fnameescape("/Users/morganmccauley/.local/share/nvim/site/pack/packer/start/neogit")))
  local lua_cmd = fn.shellescape("lua require('neogit.client').client()")

  local shell_cmd = {
    "nvim",
    "--headless",
    "--clean",
    "--noplugin",
    "-n",
    "-R",
    "-c",
    runtimepath_cmd,
    "-c",
    lua_cmd,
  }

  return table.concat(shell_cmd, " ")
end

local nvim_cmd = get_nvim_remote_editor()

require'toggleterm'.setup {
  shade_terminals = false,
  direction = 'vertical',
  open_mapping = [[<C-t>]],
  start_in_insert = true,
  persist_size = false,
  env = {
    GIT_EDITOR = nvim_cmd,
    GIT_SEQUENCE_EDITOR = nvim_cmd
  },
  size = function()
    return vim.o.columns * 0.5
  end,
  on_open = function(t)
    vim.wo.winfixwidth = false

    vim.api.nvim_buf_set_keymap(t.bufnr, 't', '<C-h>', [[<C-\><C-n><C-W><C-h>]], { noremap = true })
    vim.api.nvim_buf_set_keymap(t.bufnr, 't', '<C-\\>', [[<C-\><C-n>]], { noremap = true })
    vim.api.nvim_buf_set_keymap(t.bufnr, 't', '<C-j>', [[<C-\><C-n><C-W><C-j>]], { noremap = true })
    vim.api.nvim_buf_set_keymap(t.bufnr, 't', '<C-k>', [[<C-\><C-n><C-W><C-k>]], { noremap = true })
    vim.api.nvim_buf_set_keymap(t.bufnr, 't', '<C-x>', [[<C-\><C-n>:q!<Cr>]], { noremap = true })

    vim.api.nvim_buf_set_keymap(t.bufnr, 't', '<C-n>', [[<C-\><C-n>:NvimTreeToggle<Cr>]], { noremap = true })
  end,
}
