-- ================================================================================================
-- TITLE : ts_ls (TypeScript Language Server) LSP Setup
-- ABOUT : Language server for TypeScript and JavaScript (incl. React .tsx/.jsx).
-- LINKS :
--   > github: https://github.com/typescript-language-server/typescript-language-server
-- ================================================================================================

--- @param capabilities table LSP client capabilities (from nvim-cmp via cmp_nvim_lsp)
--- @return nil
return function(capabilities)
    vim.lsp.config("ts_ls", {
        capabilities = capabilities,
        -- attach for TS/JS and their React variants
        filetypes = {
            "typescript",
            "javascript",
            "typescriptreact",
            "javascriptreact",
        },
        settings = {
            typescript = {
                -- editor hints the server uses for its own formatting suggestions
                indentStyle = "space",
                indentSize = 2,
            },
        },
    })
end
