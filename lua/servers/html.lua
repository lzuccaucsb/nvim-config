-- ================================================================================================
-- TITLE : html (HTML Language Server) LSP Setup
-- ABOUT : Tag/attribute completion, hover docs, and validation for HTML files.
--         Binary `vscode-html-language-server` ships in npm `vscode-langservers-extracted`.
-- LINKS :
--   > github: https://github.com/hrsh7th/vscode-langservers-extracted
-- ================================================================================================

--- @param capabilities table LSP client capabilities (from nvim-cmp via cmp_nvim_lsp)
--- @return nil
return function(capabilities)
    vim.lsp.config("html", {
        capabilities = capabilities,
        filetypes = { "html", "htmldjango" },
    })
end
