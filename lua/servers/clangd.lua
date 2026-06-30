-- ================================================================================================
-- TITLE : clangd (C/C++ Language Server) LSP Setup
-- ABOUT : LLVM-based language server for C and C++.
-- LINKS :
--   > website: https://clangd.llvm.org/
-- ================================================================================================

--- @param capabilities table LSP client capabilities (from nvim-cmp via cmp_nvim_lsp)
--- @return nil
return function(capabilities)
    vim.lsp.config("clangd", {
        capabilities = capabilities,
        cmd = {
            "clangd",
            -- utf-16 offsets avoid a known encoding mismatch warning with nvim-cmp
            "--offset-encoding=utf-16",
        },
        filetypes = { "c", "cpp" },
    })
end
