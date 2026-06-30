-- ================================================================================================
-- TITLE : yamlls (YAML Language Server) LSP Setup
-- ABOUT : Completion, validation, and JSON-schema support for YAML files.
-- LINKS :
--   > github: https://github.com/redhat-developer/yaml-language-server
-- ================================================================================================

--- @param capabilities table LSP client capabilities (from nvim-cmp via cmp_nvim_lsp)
--- @return nil
return function(capabilities)
    vim.lsp.config("yamlls", {
        capabilities = capabilities,
        settings = {
            yaml = {
                -- map known filename patterns to remote JSON schemas for validation + completion
                schemas = {
                    ["https://json.schemastore.org/composer.json"] = "composer.json",
                    ["https://json.schemastore.org/docker-compose.json"] = "docker-compose*.yml",
                },
                validate = true,
                format = {
                    enable = true,
                },
            },
        },
        filetypes = { "yaml" },
    })
end
