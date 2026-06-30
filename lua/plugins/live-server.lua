-- ======================================================================
-- TITLE : live-server
-- LINKS :
--    > github : https://github.com/barrett-ruth/live-server.nvim
-- ABOUT : Live-reload dev server for HTML/CSS/JS (wraps npm live-server).
-- ======================================================================

return {
  "barrett-ruth/live-server.nvim",
  build = "npm install -g live-server",
  cmd = { "LiveServerStart", "LiveServerStop" },
  config = true,
}
