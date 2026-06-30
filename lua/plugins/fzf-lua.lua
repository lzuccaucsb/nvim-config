-- ======================================================================
-- TITLE : fzf-lua
-- LINKS :
--    > github : https://github.com/ibhagwan/fzf-lua
-- ABOUT : lua-based fzf wrapper and integration.
-- ======================================================================

return {
  "ibhagwan/fzf-lua",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      "<C-p>",
      function()
        require("fzf-lua").files()
      end,
      desc = "FZF Files",
    },
    {
      "<leader>fg",
      function()
        require("fzf-lua").live_grep()
      end,
      desc = "FZF Live Grep",
    },
    {
      "<leader>fb",
      function()
        require("fzf-lua").buffers()
      end,
      desc = "FZF Buffers",
    },
    {
      "<leader>fh",
      function()
        require("fzf-lua").help_tags()
      end,
      desc = "FZF Help Tags",
    },
    {
      "<leader>fx",
      function()
        require("fzf-lua").diagnostics_document()
      end,
      desc = "FZF Diagnostics Document",
    },
    {
      "<leader>fX",
      function()
        require("fzf-lua").diagnostics_workspace()
      end,
      desc = "FZF Diagnostics Workspace",
    },
    {
      "<leader>fs",
      function()
        require("fzf-lua").lsp_document_symbols()
      end,
      desc = "FZF Document Symbols",
    },
    {
      "<leader>fS",
      function()
        require("fzf-lua").lsp_workspace_symbols()
      end,
      desc = "FZF Workspace Symbols",
    },
    -- INTEGRATED: Custom Harpoon Picker
    {
      "<leader>fm",
      function()
        local harpoon = require("harpoon")
        local harpoon_files = harpoon:list()
        local file_paths = {}

        -- Extract file paths from Harpoon's internal list structure
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        -- Pass the array of paths directly into fzf-lua
        require("fzf-lua").fzf_exec(file_paths, {
          prompt = "Harpoon> ",
          winopts = {
            height = 0.40, -- Sleek, smaller dropdown window
            width = 0.55,
          },
          actions = {
            ["default"] = function(selected)
              if selected and selected[1] then
                vim.cmd("edit " .. selected[1])
              end
            end,
          },
        })
      end,
      desc = "FZF Harpoon Marks",
    },
  },
  opts = {},
}
