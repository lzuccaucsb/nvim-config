-- ================================================================================================
-- TITLE : pyright (Python Language Server) LSP Setup
-- ABOUT : Microsoft's static type checker + language server for Python.
-- LINKS :
--   > github: https://github.com/microsoft/pyright
-- ================================================================================================

--- @param capabilities table LSP client capabilities (from nvim-cmp via cmp_nvim_lsp)
--- @return nil
return function(capabilities)
    vim.lsp.config("pyright", {
        capabilities = capabilities,
        settings = {
            pyright = {
                -- allow pyright to sort/organise imports
                disableOrganizeImports = false,
                analysis = {
                    -- infer types from library source when stubs are missing
                    useLibraryCodeForTypes = true,
                    -- auto-discover source roots (e.g. src/ layouts)
                    autoSearchPaths = true,
                    -- analyse the whole workspace, not just the open file
                    diagnosticMode = "workspace",
                    -- suggest auto-imports in completion
                    autoImportCompletions = true,
                },
            },
        },
    })
end
