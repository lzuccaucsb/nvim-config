-- ======================================================================
-- TITLE : harpoon
-- LINKS :
--    > github : https://github.com/ThePrimeagen/harpoon
-- ABOUT : Fast file pinning and muscle-memory navigation.
-- ======================================================================

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2", -- Ensures you are using the modern Harpoon v2 engine
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    -- Initialize Harpoon with auto-save settings
    harpoon:setup({
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      },
    })

    -- 1. Mark a file (This fixes your <leader>a crash!)
    vim.keymap.set("n", "<leader>a", function()
      harpoon:list():add()
      print("📌 File harpooned!") -- Gives you nice visual feedback at the bottom
    end, { desc = "Harpoon Add File" })

    -- 2. Open the native Harpoon text menu (Great for viewing or rearranging slots)
    -- Triggered by Alt+h (Option+h, since macos-option-as-alt is on in Ghostty).
    vim.keymap.set("n", "<M-h>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Harpoon Open Menu (Alt+h)" })

    -- 3. Pure Muscle-Memory Hotkeys (Optional but highly recommended)
    -- This lets you teleport directly to slots 1-4 without opening any menus
    vim.keymap.set("n", "<C-j>", function() harpoon:list():select(1) end, { desc = "Harpoon Slot 1" })
    vim.keymap.set("n", "<C-k>", function() harpoon:list():select(2) end, { desc = "Harpoon Slot 2" })
    vim.keymap.set("n", "<C-l>", function() harpoon:list():select(3) end, { desc = "Harpoon Slot 3" })
    vim.keymap.set("n", "<C-;>", function() harpoon:list():select(4) end, { desc = "Harpoon Slot 4" })
  end,
}
