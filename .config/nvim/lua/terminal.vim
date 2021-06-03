let s:monkey_terminal_window = -1
let s:monkey_terminal_buffer = -1
let s:monkey_terminal_job_id = -1

function! MonkeyTerminalOpen()
  " Check if buffer exists, if not create a window and a buffer
  if !bufexists(s:monkey_terminal_buffer)
    " Creates a window called monkey_terminal
    new monkey_terminal
    " Moves to the window the right the current one
    wincmd L
    let s:monkey_terminal_job_id = termopen($SHELL, { 'detach': 1 })

    silent file Terminal
    " Gets the id of the terminal window
    let s:monkey_terminal_window = win_getid()
    let s:monkey_terminal_buffer = bufnr('%')

    execute "setlocal nonu"
    execute "setlocal filetype=term"
    execute "setlocal nornu"
    execute "setlocal noshowmode"
    execute "setlocal noruler"
    execute "setlocal noshowcmd"

    " The buffer of the terminal won't appear in the list of the buffers
    " when calling :buffers command
    " set nobuflisted

    silent au BufLeave <buffer> stopinsert!
    silent au BufWinEnter,WinEnter <buffer> startinsert!

    execute "tnoremap <buffer> <C-\\> <C-\\><C-n>"
    execute "tnoremap <buffer> <C-h> <C-\\><C-n><C-w><C-h>"
    execute "tnoremap <buffer> <C-t> <C-\\><C-n> :call MonkeyTerminalToggle()<CR>"

    startinsert!
  else
    if !win_gotoid(s:monkey_terminal_window)
    sp
    " Moves to the window below the current one
    wincmd L
    buffer Terminal
     " Gets the id of the terminal window
     let s:monkey_terminal_window = win_getid()
    endif
  endif
endfunction

function! MonkeyTerminalToggle()
  if win_gotoid(s:monkey_terminal_window)
    call MonkeyTerminalClose()
  else
    call MonkeyTerminalOpen()
  endif
endfunction

function! MonkeyTerminalQuit()
  echom 'exec'
  if s:monkey_terminal_buffer != -1
    echom 'delete'
    execute "bd! ".s:monkey_terminal_buffer
    let s:monkey_terminal_buffer = -1
  endif
endfunction

function! MonkeyTerminalClose()
  echom s:monkey_terminal_window
  if win_gotoid(s:monkey_terminal_window)
    hide
  endif
endfunction

function! MonkeyTerminalExec(cmd)
  if !win_gotoid(s:monkey_terminal_window)
    call MonkeyTerminalOpen()
  endif

  " clear current input
  call jobsend(s:monkey_terminal_job_id, "clear\n")

  " run cmd
  call jobsend(s:monkey_terminal_job_id, a:cmd . "\n")
  normal! G
  " wincmd p
endfunction

function! MonkeyTerminalExecLastCommand()
  if !win_gotoid(s:monkey_terminal_window)
    call MonkeyTerminalOpen()
  endif

  call jobsend(s:monkey_terminal_job_id, "fc -e -\n")

  normal! G
  wincmd p
endfunction
