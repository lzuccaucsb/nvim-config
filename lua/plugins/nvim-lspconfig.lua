return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "creativenull/efmls-configs-nvim",
        "saghen/blink.cmp", -- provides LSP capabilities (see lua/servers/init.lua)
    },
    config = function()
        require("utils.diagnostics").setup()
        require("servers")
    end,
  }
