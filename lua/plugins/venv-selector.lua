-- ================================================================================================
-- TITLE : venv-selector (Python virtualenv switcher)
-- ABOUT : Pick a Python interpreter at runtime and point the running LSP (pyright) at it.
--         Tuned for uv, which creates a project-local `.venv/`. The built-in `cwd` /
--         `workspace` / `file` searches discover that venv; we add one extra search for
--         uv-managed Python installs. Choosing an env sets `python.pythonPath` and restarts
--         the LSP so completion / diagnostics use that environment.
--         Cache restore (re-activate last venv per project) is built-in and on by default.
-- NOTE  : v2 expects `options` / `search` at the TOP LEVEL of opts (no `settings` wrapper).
-- LINKS :
--   > github: https://github.com/linux-cultist/venv-selector.nvim
-- ================================================================================================

return {
    "linux-cultist/venv-selector.nvim",
    -- v2 (uv + fzf-lua support) is now the default `main` branch.
    dependencies = {
        "neovim/nvim-lspconfig",
        "ibhagwan/fzf-lua", -- picker backend (you already use fzf-lua)
    },
    ft = "python", -- load lazily when a Python file opens
    keys = {
        { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Python: select venv" },
    },
    opts = {
        -- Built-in searches (cwd/workspace/file) find uv `.venv`; defaults are merged in.
        -- $FD is substituted with the detected fd binary by the plugin.
        search = {
            uv_managed = {
                command = "$FD '/bin/python$' ~/.local/share/uv/python --full-path --color never -E /proc",
            },
        },
        options = {
            notify_user_on_venv_activation = true,
            fd_binary_name = "fd", -- pin binary (skip PATH auto-detect)
        },
    },
}
