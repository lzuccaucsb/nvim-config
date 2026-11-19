-- ================================================================================================
-- TITLE : gitsigns.nvim
-- ABOUT : Git signs in the sign column (added / changed / deleted lines vs. the index), plus
--         hunk actions: jump, preview, stage, reset, blame, diff.
--         Keymaps use the <leader>g prefix (<leader>h is taken by window movement).
-- LINKS :
--   > github : https://github.com/lewis6991/gitsigns.nvim
-- ================================================================================================

return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        on_attach = function(bufnr)
            local gs = require("gitsigns")
            local map = function(mode, keys, fn, desc)
                vim.keymap.set(mode, keys, fn, { buffer = bufnr, desc = "Git: " .. desc })
            end
            local selection = function()
                return { vim.fn.line("."), vim.fn.line("v") }
            end

            -- navigation: in diff mode keep Vim's built-in ]c / [c (jump between changes)
            map("n", "]c", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "]c", bang = true })
                else
                    gs.nav_hunk("next")
                end
            end, "Next hunk")
            map("n", "[c", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "[c", bang = true })
                else
                    gs.nav_hunk("prev")
                end
            end, "Prev hunk")

            -- stage / reset (visual mode acts on the selected lines only)
            map("n", "<leader>gs", gs.stage_hunk, "Stage / unstage hunk")
            map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
            map("v", "<leader>gs", function() gs.stage_hunk(selection()) end, "Stage selected lines")
            map("v", "<leader>gr", function() gs.reset_hunk(selection()) end, "Reset selected lines")
            map("n", "<leader>gS", gs.stage_buffer, "Stage buffer")
            map("n", "<leader>gR", gs.reset_buffer, "Reset buffer")

            -- inspect
            map("n", "<leader>gp", gs.preview_hunk, "Preview hunk (popup)")
            map("n", "<leader>gi", gs.preview_hunk_inline, "Preview hunk (inline)")
            map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame line")
            map("n", "<leader>gB", gs.toggle_current_line_blame, "Toggle inline blame")
            map("n", "<leader>gd", gs.diffthis, "Diff file vs index")
            map("n", "<leader>gq", gs.setqflist, "Hunks to quickfix")

            -- text object: `ih` = inner hunk (e.g. `vih` select, `dih` delete)
            map({ "o", "x" }, "ih", gs.select_hunk, "Select hunk")
        end,
    },
}
