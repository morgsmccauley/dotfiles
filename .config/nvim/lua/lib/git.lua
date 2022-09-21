local fn = vim.fn

local M = {}

-- TODO change to something which doesn't rely on neogit internals
function M.get_editor()
  local runtimepath_cmd = fn.shellescape(string.format("set runtimepath^=%s",
    fn.fnameescape("/Users/morganmccauley/.local/share/nvim/site/pack/packer/start/neogit")))
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

return M
