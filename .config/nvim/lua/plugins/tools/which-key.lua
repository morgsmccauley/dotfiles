return {
  'folke/which-key.nvim',
  -- keys = { '<leader>', '"', '\'', '`' },
  config = function()
    vim.g.mapleader = ' '

    local wk = require('which-key')

    wk.setup {
      window = {
        border = 'single',
        margin = { 1, 0, 0, 0 },
        padding = { 2, 2, 2, 2 },
      },
    }

    local window = {
      name = '+window',
      q = { '<Cmd>q<Cr>', 'Quit' },
      Q = { '<Cmd>wq<Cr>', 'Save and quit' },
      w = { '<Cmd>silent w<Cr>', 'Save' },
      r = { '<C-w>r', 'Rotate' },
      c = { '<Cmd>LeapWindow<Cr>', 'Choose window' },
      C = { '<Cmd>LeapCloseWindow<Cr>', 'Close target window' },
      o = { '<Cmd>only<Cr>', 'Close all other windows' },
      l = { '<Cmd>luafile %<Cr>', 'Source selected lua file' },
      v = { '<Cmd>vsp<Cr>', 'Split window vertically' },
      ['='] = { '<C-w>=', 'Balance windows' },
      ['-'] = { '<C-w>|', 'Maximise window' }
    }

    local git_remote = {
      name = '+remote',
      p = { '<Cmd>Neogit push<Cr>', 'Push' },
      u = { '!gpsup<Cr>', 'Push creating upstream' },
      l = { '<Cmd>Neogit pull<Cr>', 'Pull' },
      f = { '<Cmd>echo "Fetching remote..." | Git fetch<Cr>', 'Fetch' },
      y = { '<Plug>(gh-line)', 'Copy GitHub URL of current line' },
    }

    local git_rebase = {
      name = '+rebase',
      s = { 'Git rebase --skip', 'skip' },
      c = { 'Git rebase --continue', 'continue' },
      a = { 'Git rebase --abort', 'abort' },
    }

    local git_hunk = {
      name = '+hunk',
      s = { '<Cmd>lua require\'gitsigns\'.stage_hunk()<Cr>', 'Stage' },
      u = { '<Cmd>lua require\'gitsigns\'.undo_stage_hunk()<Cr>', 'Undo stage' },
      i = { '<Cmd>lua require\'gitsigns\'.preview_hunk()<Cr>', 'Preview' },
      r = { '<Cmd>lua require\'gitsigns\'.reset_hunk()<Cr>', 'Reset' },
      n = { '<Cmd>lua require\'gitsigns\'.next_hunk()<Cr>', 'Next' },
      p = { '<Cmd>lua require\'gitsigns\'.prev_hunk()<Cr>', 'Prev' },
    }

    local debug = {
      name = '+debug',
      n = { '<Cmd>lua require"dap".step_over()<Cr>', 'Step over' },
      i = { '<Cmd>lua require"dap".step_into()<Cr>', 'Step into' },
      o = { '<Cmd>lua require"dap".step_out()<Cr>', 'Step out' },
      c = { '<Cmd>lua require"dap".continue()<Cr>', 'Continue' },
      C = { '<Cmd>lua require"dap".clear_breakpoints()<Cr>', 'Clear breakpoints' },
      s = { '<Cmd>lua require"dap".terminate()<Cr>', 'Stop' },
      b = { '<Cmd>lua require"dap".toggle_breakpoint()<Cr>', 'Toggle breakpoint' },
      B = { '<Cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<Cr>',
        'Set breakpoint with condition' },
      r = {
        function()
          require('dap').repl.toggle()
          -- wasn't able to make this work in lua - win_findbuf[0] returned nil
          vim.api.nvim_command "call win_gotoid(win_findbuf(bufnr('dap-repl'))[0])"
        end,
        'Toggle repl'
      },
      u = { '<Cmd>lua require"dapui".toggle()<Cr>', 'Toggle ui' }
    }

    local git_diff = {
      name = '+diff',
      o = { '<Cmd>DiffviewOpen<Cr>', 'Open' },
      b = { '<Cmd>DiffviewOpen master...HEAD<Cr>', 'Open (branch)' },
      c = { '<Cmd>DiffviewClose<Cr>', 'Close' },
      f = { '<Cmd>DiffviewToggleFiles<Cr>', 'Toggle files pane' }
    }

    local git = {
      name = '+git',
      l = { '<Cmd>TelescopeCommits<Cr>', 'Log' },
      p = { '<Cmd>Telescope gh pull_request<Cr>', 'Pull requests' },
      i = { '<Cmd>Telescope gh issues<Cr>', 'Issues' },
      b = { '<Cmd>TelescopeBranches<Cr>', 'Branches' },
      s = { '<Cmd>TelescopeStash<Cr>', 'Stash' },
      c = { '<Cmd>Git commit<Cr>', 'Commit' },
      L = { '<Cmd>Telescope git_bcommits<Cr>', 'Buffer log' },
      B = { '<Cmd>Git blame<Cr>', 'Blame annotations' },
      g = { '<Cmd>Git<Cr>', 'Git' },
      h = git_hunk,
      d = git_diff,
      r = git_remote,
      R = git_rebase,
    }

    local session = {
      name = '+session',
      -- require telescope since it's lazy loaded
      l = { '<Cmd>lua require("telescope") require("session_manager").load_session()<Cr>', 'List sessions' },
      w = { '<Cmd>SaveSession<Cr>', 'Write session' },
      d = { '<Cmd>lua requrie("telescope") require("session_manager").delete_session()<Cr>', 'Delete session(s)' },
    }

    local marks = {
      name = '+marks',
      D = { '<Cmd>delmarks!<Cr>', 'Delete all marks for current buffer' },
      m = { '<Cmd>norm\'<Cr>', 'List marks' }
    }

    local buffer = {
      name = '+buffer',
      e = { '<Cmd>edit<Cr>', 'Edit buffer' },
      y = { '<Cmd>let @* = expand("%")<Cr>', 'Yank filename' }
    }

    local code = {
      name = '+code',
      -- c = { ':Telescope commands<Cr>', 'Commands' },
      a = { '<Cmd>lua vim.lsp.buf.code_action()<Cr>', 'Code actions' },
      d = { '<Cmd>Telescope diagnostics bufnr=0<Cr>', 'File diagnostics' },
      D = { '<Cmd>Telescope diagnostics<Cr>', 'Workspace diagnostics' },
      l = { '<Cmd>lua vim.diagnostic.open_float()<Cr>', 'Show diagnostics for current line' },
      f = { '<Cmd>lua vim.lsp.buf.format()<Cr>', 'Format' }
    }

    local test = {
      name = '+test',
      f = { '<Cmd>TestFile<Cr>', 'Test file' },
      l = { '<Cmd>TestLast<Cr>', 'Test last' },
      t = { '<Cmd>TestNearest<Cr>', 'Test under cursor' },
      s = { '<Cmd>TestSuite<Cr>', 'Test suite' }
    }

    local mappings = {
      w = window,
      g = git,
      s = session,
      m = marks,
      b = buffer,
      c = code,
      d = debug,
      t = test,
      ['*'] = { '<Cmd>Telescope grep_string<Cr>', 'Search for symbol globally' },
      ['/'] = { '<Cmd>Telescope live_grep<Cr>', 'Search globally' },
      [','] = { '<Cmd>TelescopeBuffers<Cr>', 'Switch buffer' },
      ['.'] = { '<Cmd>Telescope git_files<Cr>', 'Find file' },
      ['\\'] = { '<Cmd>Telescope current_buffer_fuzzy_find<Cr>', 'Fuzzy find current buffer' },
      ['\''] = { '<Cmd>Telescope marks<Cr>', 'List marks' },
      [':'] = { '<Cmd>Telescope commands<Cr>', 'List commands' }
    }

    local opts = {
      prefix = '<leader>'
    }

    wk.register(mappings, opts)
  end
}
