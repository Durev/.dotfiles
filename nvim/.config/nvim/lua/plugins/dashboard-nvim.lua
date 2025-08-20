local dashboard_header = {
  "            .:                :.            ",
  "          .---:.              :--.          ",
  "        .-----::.             :===-.        ",
  "      .----------:            :=====-.      ",
  "    .::-----------:           :=======-.    ",
  "    ::::------------.         -========:    ",
  "    :::::------------:        -========:    ",
  "    ::::::------------:       -========:    ",
  "    :-------------------.     -========:    ",
  "    :--------..----------:    -========:    ",
  "    :--------.  -----------   -========:    ",
  "    :--------.   :----------. -========:    ",
  "    :--------.    .----------:-========:    ",
  "    :--------.      ----------=========:    ",
  "    :--------.       :--------=========-    ",
  "    :--------.        .-------====+++++-    ",
  "    :--------.         .------=====++++-    ",
  "     :-------.           :----======+=:     ",
  "       :-----.            .---======:       ",
  "         :-==.             .--====:         ",
  "           :-.               -==:           ",
}

-- TODO: Unpin version or change plugin
return {
  "glepnir/dashboard-nvim",
  commit = "bd7163f56ac715a6d687737ea144731ac6ce8478",
  config = function()
    local dashboard = require("dashboard")

    dashboard.hide_statusline = true
    dashboard.custom_footer = { (vim.fn.getcwd():gsub("/Users/vincent.durewski", "")) }
    dashboard.hide_tabline = true
    dashboard.header_pad = 1
    dashboard.center_pad = 3
    dashboard.footer_pad = 3

    dashboard.custom_header = dashboard_header
    dashboard.custom_center = {
      {
        icon = "🔍  ",
        icon_hl = { fg = "#c7d8ff" },
        desc = "Find file     ",
        action = "Telescope find_files hidden=true",
      },
      {
        icon = "🔤  ",
        icon_hl = { fg = "#c7d8ff" },
        desc = "Find word     ",
        action = "Telescope live_grep",
      },
      {
        icon = "📄  ",
        icon_hl = { fg = "#c7d8ff" },
        desc = "New file      ",
        action = "enew",
      },
      {
        icon = "🕣  ",
        icon_hl = { fg = "#c7d8ff" },
        desc = "Recent files  ",
        action = "Telescope oldfiles",
      },
      {
        icon = "💾  ",
        icon_hl = { fg = "#c7d8ff" },
        desc = "Last session  ",
        action = "SessionLoad",
      },
      -- TODO: Link to LSP Installer / Mason?
    }

    -- Sessions
    dashboard.session_directory = string.format("%s/nvim/sessions", os.getenv("DOTFILES"))
    dashboard.session_auto_save_on_exit = true
  end,
}
