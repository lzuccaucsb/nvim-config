-- ================================================================================================
-- TITLE : bashls (Bash Language Server) LSP Setup
-- ABOUT : Completion and diagnostics for shell scripts (sh / bash / zsh).
-- LINKS :
--   > github: https://github.com/bash-lsp/bash-language-server
-- ================================================================================================

--- @param capabilities table LSP client capabilities (from nvim-cmp via cmp_nvim_lsp)
--- @return nil
return function(capabilities)
    vim.lsp.config("bashls", {
        capabilities = capabilities,
        -- attach for the common shell filetypes
        filetypes = { "sh", "bash", "zsh" },
    })
end
