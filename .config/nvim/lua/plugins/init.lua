local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(
  function(use)
    for _, plugin in pairs(require('plugins/simple')) do
      use(plugin)
    end

    for _, child in pairs(vim.fn.readdir(vim.fn.stdpath('config') .. '/lua/plugins/')) do
      if child:find('init.lua') ~= nil or child:find('simple.lua') then
        goto continue
      end

      local full_path = vim.fn.stdpath('config') .. '/lua/plugins/' .. child
      if vim.fn.isdirectory(full_path) then
        for _, sub_child in pairs(vim.fn.readdir(full_path)) do
          local module_path = full_path:gsub(vim.fn.stdpath('config') .. '/lua', '') ..
              '/' .. sub_child:gsub('.lua', '')
          use(require(module_path))
        end
      end

      ::continue::
    end

    if packer_bootstrap then
      require('packer').sync()
    end
  end
)
