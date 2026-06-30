-- ================================================================================================
-- TITLE : tailwindcss LSP Setup
-- ABOUT : IntelliSense for Tailwind CSS utility classes (completion, hover, linting).
-- LINKS :
--   > github: https://github.com/tailwindlabs/tailwindcss-intellisense
-- ================================================================================================

--- @param capabilities table LSP client capabilities (from nvim-cmp via cmp_nvim_lsp)
--- @return nil
return function(capabilities)
    vim.lsp.config("tailwindcss", {
        capabilities = capabilities,
        -- attach for component/framework filetypes that use Tailwind classes
        filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue",
            "svelte",
        },
    })
end
