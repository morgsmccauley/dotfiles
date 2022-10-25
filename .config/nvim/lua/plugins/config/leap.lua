local leap = require('leap')

leap.add_default_mappings()

local M = {}

local function get_line_starts(winid)
	local wininfo = vim.fn.getwininfo(winid)[1]
	local cur_line = vim.fn.line('.')

	local targets = {}
	local lnum = wininfo.topline
	while lnum <= wininfo.botline do
		local fold_end = vim.fn.foldclosedend(lnum)
		if fold_end ~= -1 then
			lnum = fold_end + 1
		else
			if lnum ~= cur_line then table.insert(targets, { pos = { lnum, 1 } }) end
			lnum = lnum + 1
		end
	end
	local cur_screen_row = vim.fn.screenpos(winid, cur_line, 1)['row']
	local function screen_rows_from_cur(t)
		local t_screen_row = vim.fn.screenpos(winid, t.pos[1], t.pos[2])['row']
		return math.abs(cur_screen_row - t_screen_row)
	end

	table.sort(targets, function(t1, t2)
		return screen_rows_from_cur(t1) < screen_rows_from_cur(t2)
	end)

	if #targets >= 1 then
		return targets
	end
end

function M.leap_to_line()
	local winid = vim.api.nvim_get_current_win()
	leap.leap {
		target_windows = { winid },
		targets = get_line_starts(winid),
	}
end

function M.leap_to_window()
	local target_windows = require('leap.util').get_enterable_windows()
	local targets = {}
	for _, win in ipairs(target_windows) do
		local wininfo = vim.fn.getwininfo(win)[1]
		local pos = { wininfo.topline, 1 } -- top/left corner
		table.insert(targets, { pos = pos, wininfo = wininfo })
	end

	require('leap').leap {
		target_windows = target_windows,
		targets = targets,
		action = function(target)
			vim.api.nvim_set_current_win(target.wininfo.winid)
		end
	}
end

return M
