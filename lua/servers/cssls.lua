-- ================================================================================================
-- TITLE : cssls (CSS Language Server) LSP Setup
-- ABOUT : Property/value completion, color preview, and validation for CSS / SCSS / LESS.
--         Binary `vscode-css-language-server` ships in npm `vscode-langservers-extracted`.
-- LINKS :
--   > github: https://github.com/hrsh7th/vscode-langservers-extracted
-- ================================================================================================

--- @param capabilities table LSP client capabilities (from nvim-cmp via cmp_nvim_lsp)
--- @return nil
return function(capabilities)
    vim.lsp.config("cssls", {
        capabilities = capabilities,
        filetypes = { "css", "scss", "less" },
    })
end
