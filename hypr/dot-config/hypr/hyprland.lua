-- Bare-minimum Hyprland config (requires Hyprland >= 0.55 for Lua).
-- Omarchy-flavored defaults, with focus movement remapped to hjkl.

local terminal = "wezterm"
local menu     = "wofi --show drun"

----------------------------------------------------------------------
-- Monitors. Auto-detect; override per host once outputs are known.
----------------------------------------------------------------------
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

----------------------------------------------------------------------
-- Look & feel (Omarchy defaults).
----------------------------------------------------------------------
hl.config({
    general = {
        gaps_in     = 5,
        gaps_out    = 10,
        border_size = 2,
        col = {
            active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },
        layout = "dwindle",
    },
    decoration = {
        rounding = 0,
        blur = { enabled = true, size = 2, passes = 2 },
    },
    dwindle = { preserve_split = true, force_split = 2 },
    misc = {
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
        focus_on_activate        = true,
    },
    input = {
        kb_layout    = "us",
        repeat_rate  = 40,
        repeat_delay = 250,
        numlock_by_default = true,
        follow_mouse = 1,
        touchpad = {
            clickfinger_behavior = true,
            scroll_factor = 0.4,
            natural_scroll = true,
            disable_while_typing = true,
        },
    },
    animations = { enabled = true },
})

-- Snappier than defaults — higher `speed` is faster.
hl.animation({ leaf = "global",     enabled = true,  speed = 10, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = false })

----------------------------------------------------------------------
-- Keybindings.
----------------------------------------------------------------------
local mod = "SUPER"

-- Apps
hl.bind(mod .. " + Return",         hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + D",              hl.dsp.exec_cmd(menu))
hl.bind(mod .. " + Q",              hl.dsp.window.close())
hl.bind(mod .. " + SHIFT + Escape", hl.dsp.exec_cmd("hyprlock"))

-- Window state
hl.bind(mod .. " + F",             hl.dsp.window.fullscreen())
hl.bind(mod .. " + SHIFT + SPACE", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + E",             hl.dsp.layout("togglesplit")) -- dwindle

-- Focus (hjkl override — primary reason this config exists)
hl.bind(mod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + L", hl.dsp.focus({ direction = "right" }))

-- Move window (Shift + hjkl).
-- Native dispatcher, not `exec_cmd("hyprctl dispatch swapwindow l")`: since the
-- config moved to Lua, hyprctl evaluates its argument as a Lua expression, so
-- the old bare-string form died with `')' expected near 'l'` and these four
-- binds silently did nothing.
hl.bind(mod .. " + SHIFT + H", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mod .. " + SHIFT + J", hl.dsp.window.swap({ direction = "down" }))
hl.bind(mod .. " + SHIFT + K", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mod .. " + SHIFT + L", hl.dsp.window.swap({ direction = "right" }))

-- Resize mode (Super + R enters; hjkl resize, Shift+hjkl bigger steps, Esc exits)
hl.bind(mod .. " + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
    local step, big = 40, 120
    hl.bind("H", hl.dsp.window.resize({ x = -step, y = 0,     relative = true }), { repeating = true })
    hl.bind("J", hl.dsp.window.resize({ x = 0,     y = step,  relative = true }), { repeating = true })
    hl.bind("K", hl.dsp.window.resize({ x = 0,     y = -step, relative = true }), { repeating = true })
    hl.bind("L", hl.dsp.window.resize({ x = step,  y = 0,     relative = true }), { repeating = true })

    hl.bind("SHIFT + H", hl.dsp.window.resize({ x = -big, y = 0,    relative = true }), { repeating = true })
    hl.bind("SHIFT + J", hl.dsp.window.resize({ x = 0,    y = big,  relative = true }), { repeating = true })
    hl.bind("SHIFT + K", hl.dsp.window.resize({ x = 0,    y = -big, relative = true }), { repeating = true })
    hl.bind("SHIFT + L", hl.dsp.window.resize({ x = big,  y = 0,    relative = true }), { repeating = true })

    hl.bind("Escape", hl.dsp.submap("reset"))
    hl.bind(mod .. " + R", hl.dsp.submap("reset")) -- Super+R toggles out too

    -- Swallow every other key so resize mode is modal — nothing leaks to apps until Esc.
    hl.bind("catchall", hl.dsp.no_op())
end)

-- Workspaces 1-9
for i = 1, 9 do
    hl.bind(mod .. " + " .. i,         hl.dsp.focus({ workspace = i }))
    hl.bind(mod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- Cycle workspaces (Tab / mouse wheel)
hl.bind(mod .. " + Tab",         hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + SHIFT + Tab", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mod .. " + mouse_down",  hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up",    hl.dsp.focus({ workspace = "e-1" }))

-- Drag / resize floating windows with mouse
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Screenshots (hyprshot captures, satty annotates; see scripts/screenshot)
local screenshot = "$HOME/.config/hypr/scripts/screenshot"
hl.bind(mod .. " + SHIFT + S",        hl.dsp.exec_cmd(screenshot .. " region"))
hl.bind("Print",                      hl.dsp.exec_cmd(screenshot .. " all"))
hl.bind(mod .. " + Print",            hl.dsp.exec_cmd(screenshot .. " window"))
-- Skip the annotation step — region straight to clipboard.
hl.bind(mod .. " + SHIFT + CTRL + S", hl.dsp.exec_cmd(screenshot .. " region --raw"))

-- Media keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

----------------------------------------------------------------------
-- Environment + autostart.
----------------------------------------------------------------------
hl.env("XCURSOR_SIZE",    "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("mako")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
end)
