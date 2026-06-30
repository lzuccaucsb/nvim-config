-- ======================================================================
-- TITLE : nvim-ts-autotag
-- ABOUT : Auto close and auto rename HTML/JSX tags using treesitter.
-- LINKS :
--    > github : https://github.com/windwp/nvim-ts-autotag
-- ======================================================================
return {
	"windwp/nvim-ts-autotag",
	ft = {
		"html",
		"javascript",
		"typescript",
		"javascriptreact",
		"typescriptreact",
		"svelte",
		"vue",
		"markdown",
		"xml",
	},
	opts = {},
}
