---@param name string
---@return string[]
local function plugin_lib(name)
  local plugins = require("lazy.core.config").plugins
  if plugins[name] then
    return plugins[name].dir .. "/lua"
  else
    error("Plugin " .. name .. " not found")
  end
end

return {
  settings = {
    Lua = {
      hint = {
        enable = false,
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME .. "/lua",
          "${3rd}/luv/library",
          "${3rd}/busted/library",
          "${3rd}/luassert/library",
          plugin_lib("lazy.nvim"),
          vim.fn.stdpath("config") .. "/lua",
          "./lua",
        },
      },
    },
  },
}
