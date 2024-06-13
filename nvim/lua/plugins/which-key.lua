local utils = require('utils')

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
      o = { '<Cmd>only<Cr>', 'Close all other windows' },
      l = { '<Cmd>luafile %<Cr>', 'Source selected lua file' },
      v = { '<Cmd>vsp<Cr>', 'Split window vertically' },
      ['='] = { '<C-w>=', 'Balance windows' },
      m = { '<C-w>|', 'Maximise window' }
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
      i = { '<Cmd>DiffviewOpen<Cr>', 'Index' },
      b = { '<Cmd>DiffviewOpen main...HEAD<Cr>', 'Branch' },
      c = { '<Cmd>DiffviewClose<Cr>', 'Close' },
      f = { '<Cmd>DiffviewToggleFiles<Cr>', 'Toggle files pane' },
      h = { '<Cmd>DiffviewFileHistory %<Cr>', 'File history' },
    }

    local git = {
      name = '+git',
      ['<Space>'] = { function()
        vim.fn.feedkeys(':Git ')
      end, ':Git' },
      l = {
        function()
          require('neogit').open({ 'log' })
        end,
        'Log'
      },
      p = { '<Cmd>Telescope gh pull_request<Cr>', 'Pull requests' },
      i = { '<Cmd>Telescope gh issues assignee=@me search=-label:Epic<Cr>', 'Issues' },
      b = { '<Cmd>Neogit branch<Cr>', 'Branches' },
      s = { '<Cmd>TelescopeStash<Cr>', 'Stash' },
      c = { '<Cmd>Neogit commit<Cr>', 'Commit' },
      L = { '<Cmd>DiffviewFileHistory %<Cr>', 'Buffer commit history' },
      -- TODO Use DiffviewFileHistory for current line
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
      x = { ':source %<Cr>', 'Source buffer' },
      s = {
        function()
          vim.cmd.new('[Scratch]')

          vim.bo.buftype = 'nofile'
          vim.bo.bufhidden = 'hide'
          vim.bo.swapfile = false
          vim.bo.buflisted = false

          vim.api.nvim_command('wincmd J')
        end,
        'Open scratch buffer'
      }
    }

    local code = {
      name = '+code',
      -- c = { ':Telescope commands<Cr>', 'Commands' },
      a = { vim.lsp.buf.code_action, 'Code actions' },
      r = { vim.lsp.buf.rename, 'Rename' },
      d = { '<Cmd>Trouble diagnostics toggle filter.buf=0<Cr>', 'File diagnostics' },
      D = { '<Cmd>Trouble diagnostics toggle<Cr>', 'Workspace diagnostics' },
      s = { '<Cmd>Trouble symbols toggle<Cr>', 'Code symbols' },
      l = { vim.diagnostic.open_float, 'Show diagnostics for current line' },
      f = { vim.lsp.buf.format, 'Format' },
      h = { vim.lsp.buf.hover, 'Hover' },
      g = { vim.lsp.buf.signature_help, 'Signature help' },
      t = {
        function()
          require('telescope.builtin').grep_string({ search = 'TODO|FIX|NOTE' })
        end,
        'Search TODO comments'
      }
    }

    local neotest = {
      name = '+neotest',
      t = { function()
        vim.bo.buflisted = true
        require('neotest').run.run()
      end, 'Run nearest' },
      f = { function()
        vim.bo.buflisted = true
        require('neotest').run.run(vim.fn.expand('%'))
      end, 'Run file' },
      d = { function()
        vim.bo.buflisted = true
        require('neotest').run.run({ strategy = 'dap' })
      end, 'Run with debugger' },
      l = { function()
        vim.bo.buflisted = true
        require('neotest').run.run_last()
      end, 'Run last' },
      s = { function()
        vim.bo.buflisted = true
        require('neotest').summary.toggle()
      end, 'Toggle summary' },
      o = { function()
        vim.bo.buflisted = true
        require('neotest').output_panel.toggle()
      end, 'Toggle output panel' },
    }

    local terminal = {
      name = '+terminal',
      o = {
        function()
          require('termbuf.api').open_terminal()
        end,
        'Open terminal in current window'
      },
      t = {
        function()
          vim.cmd.tabnew()
          require('termbuf.api').open_terminal()
        end,
        'Open terminal in new tab'
      },
      v = {
        function()
          vim.cmd.vsplit()
          require('termbuf.api').open_terminal()
        end,
        'Open terminal in vertical split'
      },
      s = {
        function()
          vim.cmd('belowright split')
          require('termbuf.api').open_terminal()
        end,
        'Open terminal in horizontal split'
      },
      r = {
        function()
          vim.cmd.vsplit()
          require('termbuf.api').open_terminal({ dir = utils.find_project_root() or vim.uv.cwd() })
        end,
        'Open terminal at project root'
      }
    }

    local file = {
      name = '+file',
      o = {
        function()
          local oil = require('oil')

          vim.cmd.tabnew()
          oil.open()
        end,
        'Open file explorer'
      },
      r = {
        function()
          local oil = require('oil')

          vim.cmd.tabnew()
          oil.open(utils.find_project_root())
        end,
        'Open file explorer from project root'
      },
      p = {
        function()
          local oil = require('oil')

          local current_dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
          vim.cmd.tabnew()
          oil.open(current_dir)
        end,
        'Open file explorer from parent'
      }
    }

    local mappings = {
      w = window,
      g = git,
      m = marks,
      b = buffer,
      c = code,
      d = debug,
      n = neotest,
      t = terminal,
      f = file,
      ['/'] = { '<Cmd>Telescope current_buffer_fuzzy_find<Cr>', 'Search buffer' },
      ['*'] = { '<Cmd>Telescope grep_string<Cr>', 'Search for symbol globally' },
      ['?'] = { '<Cmd>Telescope live_grep<Cr>', 'Search globally' },
      [','] = { '<Cmd>TelescopeBuffers<Cr>', 'Switch buffer' },
      ['.'] = {
        function()
          require('telescope.builtin').git_files({ use_git_root = false, show_untracked = true })
        end,
        'Find file'
      },
      ['\''] = { '<Cmd>Telescope marks<Cr>', 'List marks' },
      [';'] = { '<Cmd>Telescope command_history<Cr>', 'List command history' },
      -- ['?'] = { '<Cmd>Telescope help_tags<Cr>', 'List commands' },
    }

    local opts = {
      prefix = '<leader>'
    }

    wk.register(mappings, opts)

    vim.api.nvim_set_hl(0, 'WhichKeyFloat', { bg = 'NONE' })
  end
}
