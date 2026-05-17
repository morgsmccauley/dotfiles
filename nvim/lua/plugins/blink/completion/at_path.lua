local source = {}

local function mention_at_cursor(context)
  local line_before_cursor = context.line:sub(1, context.cursor[2])
  local token_start = line_before_cursor:find('%S+$')
  if not token_start then
    return nil
  end

  local token = line_before_cursor:sub(token_start)
  if token:sub(1, 1) ~= '@' then
    return nil
  end

  return {
    start_col = token_start - 1,
    query = token:sub(2),
  }
end

local function cwd(context)
  local buffer_cwd = vim.b[context.bufnr].edit_command_line_cwd
  if type(buffer_cwd) == 'string' and buffer_cwd ~= '' then
    return buffer_cwd
  end

  return vim.fn.getcwd()
end

local function split_path(query)
  local dir, prefix = query:match('^(.*[/\\])([^/\\]*)$')
  if dir then
    return dir, prefix
  end

  return '', query
end

local function scan_dir(path)
  local handle = vim.uv.fs_scandir(path)
  if not handle then
    return {}
  end

  local entries = {}
  while true do
    local name, type = vim.uv.fs_scandir_next(handle)
    if not name then
      break
    end

    entries[#entries + 1] = { name = name, type = type }
  end

  table.sort(entries, function(a, b)
    local a_rank = a.type == 'directory' and 1 or 2
    local b_rank = b.type == 'directory' and 1 or 2

    if a_rank == b_rank then
      return a.name:lower() < b.name:lower()
    end

    return a_rank < b_rank
  end)

  return entries
end

function source.new()
  return setmetatable({}, { __index = source })
end

function source:enabled()
  return vim.bo.filetype == 'zsh-edit-command-line'
end

function source:get_trigger_characters()
  return { '@', '/' }
end

function source:get_completions(context, callback)
  local mention = mention_at_cursor(context)
  if not mention then
    return callback({ is_incomplete_forward = false, is_incomplete_backward = false, items = {} })
  end

  local dir, prefix = split_path(mention.query)
  local scan_path = dir:sub(1, 1) == '/' and dir or vim.fs.joinpath(cwd(context), dir)
  local include_hidden = prefix:sub(1, 1) == '.'
  local items = {}
  local CompletionItemKind = require('blink.cmp.types').CompletionItemKind

  for _, entry in ipairs(scan_dir(scan_path)) do
    if include_hidden or entry.name:sub(1, 1) ~= '.' then
      local is_dir = entry.type == 'directory'
      local label = entry.name .. (is_dir and '/' or '')
      local path = dir .. label

      items[#items + 1] = {
        label = label,
        filterText = entry.name,
        sortText = (is_dir and '1' or '2') .. entry.name:lower(),
        kind = is_dir and CompletionItemKind.Folder or CompletionItemKind.File,
        insertTextFormat = vim.lsp.protocol.InsertTextFormat.PlainText,
        textEdit = {
          newText = '@' .. path,
          range = {
            start = { line = context.cursor[1] - 1, character = mention.start_col },
            ['end'] = { line = context.cursor[1] - 1, character = context.cursor[2] },
          },
        },
      }
    end
  end

  callback({
    is_incomplete_forward = true,
    is_incomplete_backward = true,
    items = items,
  })
end

return source
