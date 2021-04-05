require'compe'.setup {
  enabled = true;
  autocomplete = true;
  min_length = 0;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
  };
}
