return {
  'folke/which-key.nvim',
  keys = { '<leader>', '"', '\'', '`' },
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
      p = { '<Cmd>Git push<Cr>', 'Push' },
      u = { '<Cmd>Git push --set-upstream origin', 'Push creating upstream' },
      l = { '<Cmd>Git pull<Cr>', 'Pull' },
      f = { '<Cmd>echo "Fetching remote..." | Git fetch<Cr>', 'Fetch' },
      y = { 'V:GBrowse!<Cr>', 'Copy GitHub URL of current line' },
      b = { '<Cmd>GBrowse<Cr>', 'View current file in Github' },
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
      h = {
        function()
          require('dap.ui.widgets').hover()
        end,
        'View value for expression under cursor'
      },
      B = {
        '<Cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<Cr>',
        'Set breakpoint with condition'
      },
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
      ['<Space>'] = { function()
        vim.fn.feedkeys(':Git ')
      end, ':Git' },
      l = { '<Cmd>TelescopeCommits<Cr>', 'Log' },
      p = { '<Cmd>Telescope gh pull_request<Cr>', 'Pull requests' },
      i = { '<Cmd>Telescope gh issues<Cr>', 'Issues' },
      b = { '<Cmd>TelescopeBranches<Cr>', 'Branches' },
      s = { '<Cmd>TelescopeStash<Cr>', 'Stash' },
      c = { '<Cmd>Git commit<Cr>', 'Commit' },
      L = { '<Cmd>Telescope git_bcommits<Cr>', 'Buffer log' },
      B = { '<Cmd>Git blame<Cr>', 'Blame annotations' },
      g = { '<Cmd>Neogit<Cr>', 'Git status' },
      h = git_hunk,
      d = git_diff,
      r = git_remote,
      R = git_rebase,
    }

    local marks = {
      name = '+marks',
      D = { '<Cmd>delmarks!<Cr>', 'Delete all marks for current buffer' },
      m = { '<Cmd>norm\'<Cr>', 'List marks' }
    }

    local buffer = {
      name = '+buffer',
      e = { '<Cmd>edit<Cr>', 'Edit buffer' },
      y = { '<Cmd>let @* = expand("%")<Cr>', 'Yank filename' },
      l = { function() vim.bo[0].buflisted = true end, 'List buffer' },
      s = {
        function()
          vim.cmd.new('[Scratch]')

          vim.bo.buftype = 'nofile'
          vim.bo.bufhidden = 'hide'
          vim.bo.swapfile = false

          vim.api.nvim_command('wincmd J')
        end,
        'Open scratch buffer'
      }
    }

    local code = {
      name = '+code',
      -- c = { ':Telescope commands<Cr>', 'Commands' },
      a = { '<Cmd>lua vim.lsp.buf.code_action()<Cr>', 'Code actions' },
      r = { '<Cmd>lua vim.lsp.buf.rename()<Cr>', 'Rename' },
      d = { '<Cmd>Telescope diagnostics bufnr=0<Cr>', 'File diagnostics' },
      D = { '<Cmd>Telescope diagnostics<Cr>', 'Workspace diagnostics' },
      l = { '<Cmd>lua vim.diagnostic.open_float()<Cr>', 'Show diagnostics for current line' },
      f = { '<Cmd>lua vim.lsp.buf.format()<Cr>', 'Format' }
    }

    local test = {
      name = '+neotest',
      t = { function() require('neotest').run.run() end, 'Run nearest' },
      f = { function() require('neotest').run.run(vim.fn.expand('%')) end, 'Run file' },
      d = { function() require('neotest').run.run({ strategy = 'dap' }) end, 'Run with debugger' },
      l = { function() require('neotest').run.run_last() end, 'Run last' },
      s = { function() require('neotest').summary.toggle() end, 'Toggle summary' },
      o = { function() require('neotest').output_panel.toggle() end, 'Toggle output panel' },
    }

    local session = {
      name = '+session',
      l = { function()
        -- ensure telescope-ui-select is loaded
        require('telescope')
        require('session_manager').load_session(false)
      end, 'List sessions' },
      d = { function()
        -- ensure telescope-ui-select is loaded
        require('telescope')
        require('session_manager').delete_session(false)
      end, 'List sessions' },
      s = { function() require('session_manager').save_current_session(false) end, 'Save sessions' }
    }

    local mappings = {
      w = window,
      g = git,
      m = marks,
      b = buffer,
      c = code,
      d = debug,
      t = test,
      s = session,
      ['*'] = { '<Cmd>Telescope grep_string<Cr>', 'Search for symbol globally' },
      ['/'] = { '<Cmd>Telescope live_grep<Cr>', 'Search globally' },
      [','] = { '<Cmd>TelescopeBuffers<Cr>', 'Switch buffer' },
      ['.'] = { '<Cmd>Telescope git_files use_git_root=false<Cr>', 'Find file' },
      ['\\'] = { '<Cmd>Telescope current_buffer_fuzzy_find<Cr>', 'Fuzzy find current buffer' },
      ['\''] = { '<Cmd>Telescope marks<Cr>', 'List marks' },
      [';'] = { '<Cmd>Telescope command_history<Cr>', 'List command history' },
      ['?'] = { '<Cmd>Telescope help_tags<Cr>', 'List commands' },
    }

    local opts = {
      prefix = '<leader>'
    }

    wk.register(mappings, opts)

    vim.api.nvim_set_hl(0, 'WhichKeyFloat', { bg = 'NONE' })
  end
}
