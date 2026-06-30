-- ================================================================================================
-- TITLE : lua_ls (Lua Language Server) LSP Setup
-- ABOUT : Language server for Lua. Powers completion/diagnostics while editing this nvim config.
-- LINKS :
--   > github: https://github.com/LuaLS/lua-language-server
-- ================================================================================================

--- @param capabilities table LSP client capabilities (from nvim-cmp via cmp_nvim_lsp)
--- @return nil
return function(capabilities)
    vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
            Lua = {
                -- recognise `vim` as a global so editing nvim config doesn't flag it as undefined
                diagnostics = { globals = { "vim" } },
                workspace = {
                    -- make the server aware of the neovim runtime + your own config lua,
                    -- so it can resolve `require` paths and offer accurate completion
                    library = {
                        vim.fn.expand("$VIMRUNTIME/lua"),
                        vim.fn.stdpath("config") .. "/lua",
                    },
                },
            },
        },
    })
end
