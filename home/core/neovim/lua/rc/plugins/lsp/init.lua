---Register callback function on LspAttach
---@param name string|nil If nil, global
---@param callback fun(client: lsp.Client, bufnr: integer)
local function on_attach(name, callback)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client and (name == nil or client.name == name) then
        callback(client, bufnr)
      end
    end,
  })
end

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      on_attach(nil, function(client, bufnr)
        local lspconfig = require("lspconfig")

        local function map(mode, lhs, rhs)
          vim.keymap.set(mode, lhs, rhs, { noremap = true, buffer = bufnr })
        end

        map('n', '<M-k>', vim.diagnostic.open_float)
        map('n', '<M-n>', vim.diagnostic.goto_next)
        map('n', '<M-p>', vim.diagnostic.goto_prev)

        if client.supports_method("hover") then
          map('n', 'K', vim.lsp.buf.hover)
        end

        if client.supports_method("rename") then
          map('n', '<M-r>', vim.lsp.buf.rename)
        end

        if client.supports_method("format") then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            group = vim.api.nvim_create_augroup("LspFormat", {}),
            callback = function()
              vim.cmd('silent! lua vim.lsp.buf.format({ async = false })')
            end,
          })
        end

        if client.supports_method("inlay_hint") then
          vim.cmd('highlight link LspInlayHint Comment')
          vim.lsp.inlay_hint.enable(bufnr)
        end

        local servers = { "lua_ls", "denols", "nil_ls" }
        for _, server_name in ipairs(servers) do
          local ok, opt = pcall(require, "rc.plugins.lsp." .. server_name)
          lspconfig[server_name].setup(ok and opt or {})
        end
      end)
    end,
  },
}
