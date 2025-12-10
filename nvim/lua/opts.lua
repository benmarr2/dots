local M = {}

M.obsidian_opts = {
  workspaces = {
    {
      name = "personal",
      path = "~/Documents/Notes",
    },
  },
  daily_notes = {
    folder = "00_Diary",
    date_format = "%d-%b-%Y",
    template = "daily.md",
  },
  templates = {
    folder = "04_Templates",
  },
}

return M
