-- ================================================================================================
-- TITLE : servers (LSP orchestrator)
-- ABOUT : Entry point loaded by lua/plugins/nvim-lspconfig.lua via `require("servers")`.
--         Builds the shared LSP capabilities once, registers every server's config by
--         calling its recipe file, then enables them all so Neovim starts them on demand.
-- ================================================================================================

-- Capabilities describe what this editor supports (completion, snippets, signature help, ...).
-- cmp_nvim_lsp augments the defaults so servers know nvim-cmp is driving completion.
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Language Server Protocol (LSP) -- each call registers one server's config (see lua/servers/*).
require("servers.lua_ls")(capabilities)
require("servers.pyright")(capabilities)
require("servers.gopls")(capabilities)
require("servers.jsonls")(capabilities)
require("servers.ts_ls")(capabilities)
require("servers.bashls")(capabilities)
require("servers.clangd")(capabilities)
require("servers.dockerls")(capabilities)
require("servers.emmet_ls")(capabilities)
require("servers.html")(capabilities)
require("servers.cssls")(capabilities)
require("servers.yamlls")(capabilities)
require("servers.tailwindcss")(capabilities)

-- Linters & Formatters -- efm bridges CLI tools (stylua, black, prettier, ...) into the LSP client.
require("servers.efm-langserver")(capabilities)

-- Enable the registered servers. Neovim auto-starts each one when a matching filetype opens.
vim.lsp.enable({
    "lua_ls",
    "pyright",
    "gopls",
    "jsonls",
    "ts_ls",
    "bashls",
    "clangd",
    "dockerls",
    "emmet_ls",
    "html",
    "cssls",
    "yamlls",
    "tailwindcss",
    "efm",
})

-- Buffer-local keymaps, set only once a server actually attaches to a buffer.
vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP keymaps on attach",
    callback = function(event)
        local map = function(keys, fn, desc)
            vim.keymap.set("n", keys, fn, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("gd", vim.lsp.buf.definition, "Goto definition")
        map("gD", vim.lsp.buf.declaration, "Goto declaration")
        map("gr", function()
            require("fzf-lua").lsp_references({ jump1 = false })
        end, "List references")
        map("gi", require("fzf-lua").lsp_implementations, "Goto implementation")
        map("K", vim.lsp.buf.hover, "Hover docs")
        map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        map("<leader>ca", vim.lsp.buf.code_action, "Code action")
        vim.keymap.set("x", "<leader>ca", vim.lsp.buf.code_action,
            { buffer = event.buf, desc = "LSP: Code action (range)" })
        map("<leader>f", function()
            vim.lsp.buf.format({ async = true })
        end, "Format buffer")
        map("[d", function()
            vim.diagnostic.jump({ count = -1 })
        end, "Prev diagnostic")
        map("]d", function()
            vim.diagnostic.jump({ count = 1 })
        end, "Next diagnostic")
        map("<leader>d", vim.diagnostic.open_float, "Show diagnostic float")
    end,
})
