return {
    {
        "zbirenbaum/copilot.lua",
        version = "v2.0.4", -- pin: v2 writes apps.json token avante reads. v3 uses encrypted auth.db (incompatible).
        cmd = "Copilot",
        event = "InsertEnter",
        opts = {
            suggestion = { enabled = false }, -- disable inline ghost text; cmp drives it
            panel = { enabled = false },
        },
    },
    {
        "zbirenbaum/copilot-cmp", -- exposes Copilot as a nvim-cmp source
        dependencies = "zbirenbaum/copilot.lua",
        opts = {},
    },
}
