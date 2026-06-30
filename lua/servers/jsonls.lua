-- ================================================================================================
-- TITLE : jsonls (JSON Language Server) LSP Setup
-- ABOUT : Completion, validation, and schema support for JSON / JSONC files.
-- LINKS :
--   > github: https://github.com/microsoft/vscode-json-languageservice
-- ================================================================================================

--- @param capabilities table LSP client capabilities (from nvim-cmp via cmp_nvim_lsp)
--- @return nil
return function(capabilities)
    vim.lsp.config("jsonls", {
        capabilities = capabilities,
        -- attach for plain JSON and JSON-with-comments
        filetypes = { "json", "jsonc" },
    })
end
