local function get_variable_name()
  local parser = vim.treesitter.get_parser(0, "javascript")
  local query = vim.treesitter.query.parse("javascript", [[
    ((identifier) @id)
    ((shorthand_property_identifier_pattern) @id)
  ]])

  local cursor = vim.api.nvim_win_get_cursor(0)
  local row = cursor[1]

  local matches = {}

  for _, tree in pairs(parser:parse()) do
    for _, match in query:iter_captures(tree:root(), 0, row - 2, row - 1) do
      table.insert(matches, vim.treesitter.get_node_text(match, 0))
    end
  end

  return table.concat(matches, ', ')
end

return {
  s({
      trig = 'clj',
      dscr = 'console.log JSON',
    },
    fmt(
      [[console.log(JSON.stringify({{ {} }}, null, 2));]],
      {
        i(1)
      }
    )
  ),
  s({
      trig = 'clv',
      dscr = 'console.log variable'
    },
    fmt(
      [[console.log({{ {} }});]],
      {
        f(get_variable_name)
      }
    )
  ),
}
