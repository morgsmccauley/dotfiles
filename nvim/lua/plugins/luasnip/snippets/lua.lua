return {
  s(
    "r",
    fmt(
      [[local {} = require('{}')]],
      {
        f(function(args)
          local parts = vim.split(args[1][1], '.', true)
          return parts[#parts] or ''
        end, { 1 }),
        i(1)
      }
    )
  ),
}
