-- Restore last cursor position when reopening a file
local last_cursor_group = vim.api.nvim_create_augroup("LastCursorGroup", {})
vim.api.nvim_create_autocmd("BufReadPost", {
    group = last_cursor_group,
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Preserve scroll position (view) when leaving a buffer and restore it on
-- return. Harpoon restores the cursor line but not the scroll offset, so the
-- text can jump to the bottom of the screen. This keeps the view stable.
local view_group = vim.api.nvim_create_augroup("RememberView", {})
local saved_views = {}
vim.api.nvim_create_autocmd("BufLeave", {
    group = view_group,
    callback = function(args)
        if vim.bo[args.buf].buftype == "" then
            saved_views[args.buf] = vim.fn.winsaveview()
        end
    end,
})
vim.api.nvim_create_autocmd("BufWinEnter", {
    group = view_group,
    callback = function(args)
        local view = saved_views[args.buf]
        if view then
            vim.fn.winrestview(view)
        end
    end,
})

-- Highlight the yanked text for 200ms
local highlight_yank_group = vim.api.nvim_create_augroup("HighlightYank", {})
vim.api.nvim_create_autocmd("TextYankPost", {
    group = highlight_yank_group,
    pattern = "*",
    callback = function()
        vim.hl.on_yank({
            higroup = "IncSearch",
            timeout = 200,
        })
    end,
})

