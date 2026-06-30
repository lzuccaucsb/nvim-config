-- ======================================================================
-- TITLE : avante.nvim
-- LINKS :
--    > github : https://github.com/yetone/avante.nvim
-- ABOUT : Cursor-style AI coding assistant sidebar. Uses Copilot auth.
-- ======================================================================

return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- always pull latest; avante moves fast
  -- Build the Rust/Lua bits. Falls back to make on unix.
  build = "make",
  opts = {
    provider = "copilot",
    providers = {
      copilot = {
        model = "gpt-4.1", -- free/unlimited on Copilot Pro. Switch to claude-sonnet-4.6 for hard tasks via :AvanteModels
      },
    },
    -- behaviour and mappings use sensible defaults; tweak here as needed.
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "zbirenbaum/copilot.lua", -- provider auth, already configured in copilot.lua
    --- optional deps below ---
    "nvim-tree/nvim-web-devicons", -- you already have this via webdev-icons
    {
      -- render markdown in the avante sidebar
      "MeanderingProgrammer/render-markdown.nvim",
      opts = { file_types = { "markdown", "Avante" } },
      ft = { "markdown", "Avante" },
    },
  },
}
