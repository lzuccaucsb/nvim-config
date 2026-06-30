-- ================================================================================================
-- TITLE : gopls (Golang Language Server) LSP Setup
-- ABOUT : Official Go language server. Provides completion, diagnostics, and formatting for Go.
-- LINKS :
--   > github: https://github.com/golang/tools/tree/master/gopls
-- ================================================================================================

--- @param capabilities table LSP client capabilities (from nvim-cmp via cmp_nvim_lsp)
--- @return nil
return function(capabilities)
    vim.lsp.config("gopls", {
        capabilities = capabilities,
        -- only attach for Go files
        filetypes = { "go" },
    })
end
