-- ================================================================================================
-- TITLE : blink.cmp
-- ABOUT : Completion engine. Shows the autocomplete popup and provides LSP "capabilities"
--         (via get_lsp_capabilities in lua/servers/init.lua) so servers know the editor
--         supports completion, snippets, signature help, etc.
--         LSP, path, buffer, snippet, signature help, cmdline and kind icons are built in.
--         Snippets use Neovim's native vim.snippet engine, loaded from friendly-snippets.
-- LINKS :
--   > github           : https://github.com/saghen/blink.cmp
--   > friendly-snippets: https://github.com/rafamadriz/friendly-snippets  (premade snippets)
--   > blink-copilot    : https://github.com/fang2hou/blink-copilot        (Copilot source)
-- ================================================================================================

return {
    "saghen/blink.cmp",
    version = "1.*", -- release tags ship a prebuilt Rust fuzzy matcher (no cargo needed)
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
        "rafamadriz/friendly-snippets", -- big library of ready-made snippets
        "fang2hou/blink-copilot", -- Copilot source (uses copilot.lua, see lua/plugins/copilot.lua)
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- keybinds active while the completion menu / insert mode is open
        keymap = {
            preset = "none",
            ["<C-k>"] = { "select_prev", "fallback" }, -- up in menu
            ["<C-j>"] = { "select_next", "fallback" }, -- down in menu
            ["<C-b>"] = { "scroll_documentation_up", "fallback" }, -- scroll doc popup up
            ["<C-f>"] = { "scroll_documentation_down", "fallback" }, -- scroll doc popup down
            ["<C-l>"] = { "show", "show_documentation", "hide_documentation" }, -- force-open menu
            ["<C-q>"] = { "cancel", "fallback" }, -- close menu, undo preview insert
            ["<CR>"] = { "accept", "fallback" }, -- Enter = confirm highlighted
            ["<Tab>"] = { "snippet_forward", "fallback" }, -- next snippet placeholder
            ["<S-Tab>"] = { "snippet_backward", "fallback" }, -- prev snippet placeholder
        },

        completion = {
            -- nothing selected until you move with <C-j>/<C-k>, so <CR> inserts a newline
            -- unless you picked an item (matches the old `confirm({ select = false })`)
            list = { selection = { preselect = false, auto_insert = true } },
            documentation = { auto_show = true, auto_show_delay_ms = 200 },
        },

        -- function argument hints while typing
        signature = { enabled = true },

        -- `:` command-line completion. Default only shows the menu after <Tab>;
        -- auto_show opens it as you type. <Tab>/<S-Tab> cycle, <CR> runs the command.
        cmdline = {
            completion = { menu = { auto_show = true } },
        },

        -- completion sources; copilot gets a score boost so AI suggestions rank at the top
        sources = {
            default = { "copilot", "lsp", "path", "snippets", "buffer" },
            providers = {
                copilot = {
                    name = "copilot",
                    module = "blink-copilot",
                    score_offset = 100,
                    async = true,
                },
            },
        },

        -- Rust matcher (typo-tolerant); warns and falls back to Lua if the binary is missing
        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
}
