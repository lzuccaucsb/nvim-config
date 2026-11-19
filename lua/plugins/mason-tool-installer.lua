-- ================================================================================================
-- TITLE : mason-tool-installer
-- ABOUT : Installs every LSP server, linter and formatter this config uses through Mason, so a
--         fresh machine only needs `nvim` to be ready. Runs on startup and only installs what
--         is missing. Manual: :MasonToolsInstall / :MasonToolsUpdate.
--         Keep this list in sync with lua/servers/init.lua and lua/servers/efm-langserver.lua.
--         Some tools need a toolchain: gofumpt/revive need Go, luacheck needs luarocks,
--         Node-based ones need npm, Python-based ones need python3.
-- LINKS :
--   > github : https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
-- ================================================================================================

return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
        ensure_installed = {
            -- LSP servers (lua/servers/init.lua)
            "lua-language-server",
            "pyright",
            "gopls",
            "json-lsp",
            "typescript-language-server",
            "bash-language-server",
            "clangd",
            "dockerfile-language-server",
            "emmet-ls",
            "html-lsp",
            "css-lsp",
            "yaml-language-server",
            "tailwindcss-language-server",
            "efm",

            -- Linters & formatters run through efm (lua/servers/efm-langserver.lua)
            "stylua",
            "luacheck",
            "ruff",
            "gofumpt",
            "revive",
            "prettierd",
            "eslint_d",
            "fixjson",
            "shellcheck",
            "shfmt",
            "hadolint",
            "cpplint",
            "clang-format",
            "djlint",
        },
        run_on_start = true,
        start_delay = 3000, -- ms; let startup finish before installing
    },
}
