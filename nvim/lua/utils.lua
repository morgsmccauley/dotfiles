local M = {}

function M.find_project_root()
  local root_files = {
    "Cargo.lock",
    "package-lock.json",
    ".terraform",
    ".root"
  }

  local current_file = vim.api.nvim_buf_get_name(0)
  local starting_path = vim.fn.fnamemodify(current_file, ":p:h")
  local path = vim.uv.fs_realpath(starting_path)
  if not path then return nil end

  while path do
    for _, file in ipairs(root_files) do
      if vim.uv.fs_stat(path .. "/" .. file) then
        return path
      end
    end
    local parent = vim.uv.fs_realpath(path .. "/..")
    if parent == path then break end
    path = parent
  end

  return nil
end

function M.find_aider_terminal()
  -- Get all terminal buffers
  local terms = require('termbuf.api').list_terminals()

  -- Look for a terminal running aider
  for _, term in ipairs(terms) do
    local process = term.process
    if process and process:match("aider") then
      return term.terminal
    end
  end
  return nil
end

function M.find_claude_terminal()
  -- Get current tab
  local current_tab = vim.api.nvim_get_current_tabpage()

  -- Get all windows in current tab
  local windows = vim.api.nvim_tabpage_list_wins(current_tab)

  -- Look for terminal buffers in current tab
  for _, win in ipairs(windows) do
    local buf = vim.api.nvim_win_get_buf(win)
    local buf_name = vim.api.nvim_buf_get_name(buf)

    -- Check if it's a terminal buffer
    if vim.bo[buf].buftype == 'terminal' then
      -- Get all terminal instances from termbuf
      local terms = require('termbuf.api').list_terminals()

      -- Find matching terminal and check if it's running claude
      for _, term in ipairs(terms) do
        if term.bufnr == buf then
          local process = term.process
          if process and process:match("claude") then
            return term.terminal
          end
        end
      end
    end
  end
  return nil
end

function M.get_visual_selection()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local start_line = start_pos[2]
  local end_line = end_pos[2]

  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  return table.concat(lines, '\n')
end

local function get_node_at_cursor()
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor[1] - 1, cursor[2]

  local parser = vim.treesitter.get_parser(bufnr)
  local tree = parser:parse()[1]
  local root = tree:root()

  return root:named_descendant_for_range(row, col, row, col)
end

local function get_node_path(node)
  local path = {}
  local current = node

  while current do
    table.insert(path, 1, {
      type = current:type(),
      text = vim.treesitter.get_node_text(current, 0)
    })
    current = current:parent()
  end

  return path
end

local function format_node_path(node_path)
  local parts = {}
  for _, node_info in ipairs(node_path) do
    vim.print(node_info)
    -- Extract identifier name from node text
    local name = node_info.text:match("^%s*(%w+)")
    if name then
      table.insert(parts, name)
    end
  end

  return table.concat(parts, " > ")
end

function M.get_node_path_at_cursor()
  local node = get_node_at_cursor()
  if not node then return nil end
  return format_node_path(get_node_path(get_node_at_cursor()))
end

function M.get_git_worktree()
  local handle = io.popen('git rev-parse --show-toplevel 2>/dev/null')
  if not handle then return nil end

  local git_root = handle:read("*a"):gsub("%s+", "")
  handle:close()

  if git_root == "" then return nil end

  return vim.fn.fnamemodify(git_root, ':t')
end

return M
