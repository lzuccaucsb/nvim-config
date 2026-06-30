-- =========================================================================
-- Diagnostic Sign Configuration Module
-- =========================================================================
-- This module replaces Neovim's default diagnostic gutters signs (E, W, I, H)
-- with clean, modern icons (requires a Nerd Font).
-- =========================================================================

local M = {}

-- Define the custom icons for each diagnostic severity level.
-- Note: These characters use Nerd Font symbols. Ensure your terminal font 
-- supports them to prevent them from rendering as broken blocks.
local diagnostic_signs = {
  Error = " ", -- Font Awesome / Nerd Font error icon
  Warn  = " ", -- Font Awesome / Nerd Font warning icon
  Hint  = "", -- Codicons hint/lightbulb icon
  Info  = "", -- Font Awesome / Nerd Font info icon
}

--- Initializes and applies the diagnostic configuration.
--- This follows the standard Neovim plugin/module setup pattern.
M.setup = function()
  vim.diagnostic.config({
    -- Configure how diagnostic signs are displayed in the sign column (gutter)
    signs = {
      -- Neovim 0.10+ uses the 'text' table to map severities directly to strings
      text = {
        [vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
        [vim.diagnostic.severity.WARN]  = diagnostic_signs.Warn,
        [vim.diagnostic.severity.INFO]  = diagnostic_signs.Info,
        [vim.diagnostic.severity.HINT]  = diagnostic_signs.Hint,
      },
    },
  })
end

return M
