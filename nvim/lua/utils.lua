local M = {}

function M.find_project_root()
    local root_files = {
        "Cargo.toml",
        "package.json",
        ".terraform"
    }

    local current_file = vim.api.nvim_buf_get_name(0)
    local starting_path = vim.fn.fnamemodify(current_file, ":p:h")
    local path = vim.uv.fs_realpath(starting_path)
    if not path then return nil end

    while path do
        for _, file in ipairs(root_files) do
            if vim.uv.fs_stat(path .. "/" .. file) then
                return path
            end
        end
        local parent = vim.uv.fs_realpath(path .. "/..")
        if parent == path then break end
        path = parent
    end

    return nil
end

function M.find_aider_terminal()
    -- Get all terminal buffers
    local terms = require('termbuf.api').list_terminals()

    -- Look for a terminal running aider
    for _, term in ipairs(terms) do
        local process = term.process
        if process and process:match("aider") then
            return term.terminal
        end
    end
    return nil
end

return M
