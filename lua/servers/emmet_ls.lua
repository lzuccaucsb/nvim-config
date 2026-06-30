-- ================================================================================================
-- TITLE : emmet_ls (Emmet Language Server) LSP Setup
-- ABOUT : Emmet abbreviation expansion (e.g. `div>ul>li` -> markup) for web filetypes.
-- LINKS :
--   > github: https://github.com/aca/emmet-ls
-- ================================================================================================

--- @param capabilities table LSP client capabilities (from nvim-cmp via cmp_nvim_lsp)
--- @return nil
return function(capabilities)
    vim.lsp.config("emmet_ls", {
        capabilities = capabilities,
        -- attach for markup/style-bearing web filetypes
        filetypes = {
            "typescript",
            "javascript",
            "javascriptreact",
            "typescriptreact",
            "css",
            "sass",
            "scss",
            "svelte",
            "vue",
        },
    })
end
