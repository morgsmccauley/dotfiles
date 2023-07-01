local function get_variable_name()
  local parser = vim.treesitter.get_parser(0, "javascript")
  local query = vim.treesitter.query.parse("javascript", "(variable_declarator (identifier) @id)")

  local cursor = vim.api.nvim_win_get_cursor(0)
  local row = cursor[1]

  for _, tree in pairs(parser:parse()) do
    for _, match in query:iter_captures(tree:root(), 0, row - 2, row - 1) do
      return vim.treesitter.get_node_text(match, 0)
    end
  end

  return ''
end

return {
  s({
      trig = 'clj',
      dscr = 'console.log JSON',
    },
    fmt(
      [[console.log(JSON.stringify({{ {} }}, null, 2))]],
      {
        i(1)
      }
    )
  ),
  s({
      trig = 'clv',
      decr = 'console.log variable'
    },
    fmt(
      [[console.log({{ {} }})]],
      {
        f(get_variable_name)
      }
    )
  ),
}
