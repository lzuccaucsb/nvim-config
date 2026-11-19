-- ================================================================================================
-- TITLE : copilot
-- ABOUT : GitHub Copilot, fed into the blink.cmp menu (see lua/plugins/blink-cmp.lua).
--         Inline ghost text and the panel are off; suggestions appear as completion items.
-- LINKS :
--   > copilot.lua  : https://github.com/zbirenbaum/copilot.lua
--   > blink-copilot: https://github.com/fang2hou/blink-copilot
-- ================================================================================================

return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
        suggestion = { enabled = false }, -- disable inline ghost text; blink.cmp drives it
        panel = { enabled = false },
    },
}
