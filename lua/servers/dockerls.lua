-- ================================================================================================
-- TITLE : dockerls (Docker Language Server) LSP Setup
-- ABOUT : Completion and diagnostics for Dockerfiles.
-- LINKS :
--   > github: https://github.com/rcjsuen/dockerfile-language-server-nodejs
-- ================================================================================================

--- @param capabilities table LSP client capabilities (from blink.cmp)
--- @return nil
return function(capabilities)
    vim.lsp.config("dockerls", {
        capabilities = capabilities,
        -- attach only for Dockerfiles
        filetypes = { "dockerfile" },
    })
end
