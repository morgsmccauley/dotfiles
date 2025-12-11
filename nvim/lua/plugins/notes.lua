return {
  "morgsmccauley/notes.nvim",
  config = function()
    require("notes").setup({
      dir = "~/Documents/notes.nvim",
      filetype = "markdown"
    })
  end,
}
