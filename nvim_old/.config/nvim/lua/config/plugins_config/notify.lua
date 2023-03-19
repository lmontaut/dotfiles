local status_ok, nvim_notify = pcall(require, "notify")
if not status_ok then
  print "Plugin notify failed to load."
  return
end

nvim_notify.setup({
  -- Animation style
  stages = "fade_in_slide_out",
  -- Default timeout for notifications
  timeout = 3000,
  background_colour = "#2E3440",
  icons = {
    ERROR = "",
    WARN = "",
    INFO = "",
    DEBUG = "",
    TRACE = "✎",
  },
})

vim.notify = nvim_notify
