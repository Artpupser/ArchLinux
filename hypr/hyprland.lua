local function load_pywal()
  local colors = {}

  local path = os.getenv("HOME") .. "/.cache/wal/colors-hyprland.conf"
  for line in io.lines(path) do
    local name, value = line:match("%$(%w+)%s*=%s*(.+)")
    if name and value then
      colors[name] = value
    end
  end

  return colors
end

local wal = load_pywal()

------------------
---- MONITORS ----
------------------

hl.monitor({
  output   = "HDMI-1",
  mode     = "1920x1080@60",
  position = "0x0",
  scale    = "1",
})


---------------------
---- MY PROGRAMS ----
---------------------

local mainMod      = "SUPER"
local terminal     = "ghostty"
local fileManager  = "nemo"
local menu         = "rofi -show drun"
local screenshoter = "flameshot"


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
  hl.exec_cmd("dunst")
  hl.exec_cmd("nm-applet")
  hl.exec_cmd("waybar")
  hl.exec_cmd("/usr/bin/lxqt-policykit-agent")
  hl.exec_cmd("bash ~/.config/mpvpaper_start.sh")
  hl.exec_cmd("bash ~/.config/mpvpaper_auto_pause.sh")
  hl.exec_cmd("sleep 1 && bash ~/.config/wal-vide-sync.sh")
  hl.exec_cmd("bash ~/.config/pywall_to_starship.sh")
  hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
end)

-------------------
-- KEYBINDINGS
-------------------

local dispatch = function(cmd) return hl.dsp.exec_cmd("hyprctl dispatch \"" .. cmd .. "\"") end

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ workspace = "e-1" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ workspace = "e-1" }))
hl.bind(mainMod .. " + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.window.move({ direction = "down" }))

hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("hyprctl switchxkblayout all next"))

hl.bind("Print", hl.dsp.exec_cmd(screenshoter .. " gui"))

for i = 1, 3 do
  local key = i % 10
  hl.workspace_rule({ workspace = i, persistent = true })
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- scratchpad example from your hypr.lua template
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("XCURSOR_SIZE", "20")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("HYPRCURSOR_SIZE", "20")
hl.env("GTK_THEME", "Adwaita:dark")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("GTK_APPLICATION_PREFER_DARK_THEME", "1")


hl.config({
  general = {
    gaps_in          = 5,
    gaps_out         = 5,

    border_size      = 1,

    col              = {
      active_border   = { colors = { wal.color1, wal.color3, wal.color5, wal.color7 }, angle = 45 },
      inactive_border = { colors = { wal.background, wal.color0 }, angle = 30 }
    },

    resize_on_border = false,
    allow_tearing    = false,

    layout           = "dwindle",
  },

  decoration = {
    rounding         = 10,
    rounding_power   = 2,
    active_opacity   = 1.0,
    inactive_opacity = 1.0,

    shadow           = {
      enabled      = true,
      range        = 4,
      render_power = 3,
      color        = 0xee1a1a1a,
    },

    blur             = {
      enabled  = true,
      size     = 3,
      passes   = 1,
      vibrancy = 0.1696,
    },
  },

  animations = {
    enabled = true,
  },

  misc = {
    force_default_wallpaper = 0,
  },
})

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

hl.config({
  dwindle = {
    preserve_split = true, -- You probably want this
  },
})

hl.config({
  master = {
    new_status = "master",
  },
})

hl.config({
  scrolling = {
    fullscreen_on_one_column = true,
  },
})

----------------
----  MISC  ----
----------------

hl.config({
  misc = {
    force_default_wallpaper = -1,
    disable_hyprland_logo   = false,
  },
})


---------------
---- INPUT ----
---------------

hl.config({
  input = {
    kb_layout    = "us,ru",
    kb_variant   = "",
    kb_model     = "",
    kb_options   = "",
    kb_rules     = "",

    follow_mouse = 1,

    sensitivity  = -0.7, -- -1.0 - 1.0, 0 means no modification.
    repeat_delay = 220,
    repeat_rate  = 45,
    touchpad     = {
      natural_scroll = false,
    },
  },
})



hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace"
})



--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------


local suppressMaximizeRule = hl.window_rule({
  name           = "suppress-maximize-events",
  match          = { class = ".*" },

  suppress_event = "maximize",
})

hl.window_rule({
  name     = "fix-xwayland-drags",
  match    = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },

  no_focus = true,
})

hl.window_rule({
  name  = "move-hyprland-run",
  match = { class = "hyprland-run" },

  move  = "20 monitor_h-120",
  float = true,
})
