home = os.getenv("HOME")
path = os.getenv("PATH")

scrPath = home .. "/.local/share/bin"

hl.on("hyprland.start", function()
    hl.exec_cmd(scrPath .. "/resetxdgportal.sh")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd(scrPath .. "/polkitkdeauth.sh")
--    hl.exec_cmd("waybar")
    hl.exec_cmd("quickshell")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("udiskie --no-automount --smart-tray")
    hl.exec_cmd("nm-applet --indicator")
--    hl.exec_cmd("dunst")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    --hl.exec_cmd(scrPath .. "/swwwallpaper.sh ")
--    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd(scrPath .. "/batterynotify.sh")
    hl.exec_cmd("systemctl --user start kanata.service")
end)

hl.env("PATH", path .. ":" .. scrPath)
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("GDK_SCALE", "1")
--hl.env("GDK_DPI_SCALE", "0.5")


hl.config({
    master = {
        new_status = "master",
    },
})

hl.config({
    input = {
        kb_layout = "us,es",
        --kb_options = "grp:alt_shift_toggle",
        follow_mouse = 1,
        sensitivity = 0,
        force_no_accel = true,
        numlock_by_default = true,
    }

})

hl.config({
    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        force_default_wallpaper = 0,
    }
})

hl.config({
    xwayland = {
        force_zero_scaling = true,
    }
})

-- MONITORS
samsung = "HDMI-A-5"
dell = "DP-5"
hl.monitor({
    output = dell,
    mode = "3840x2160",
    position = "0x0",
    scale = 2,
})

hl.monitor({
    output = samsung,
    mode = "1920x1080",
    position = "1920x0",
    scale = 1,
})


hl.config({
    general = {
        gaps_in = 3,
        gaps_out = 3,
        border_size = 1,
        layout = "master",

        -- https://wiki.hypr.land/Configuring/Variables/#variable-types for info about colors
        col = {
            active_border = { colors = { "rgba(bd93f999)", "rgba(8be9fd99)" }, angle = 60 },
            inactive_border = { colors = { "rgba(6272a499)" } },
        },

        --Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = true,

        -- Please see https://wiki.hypr.land/Configuring/Tearing/ before you turn this on
        allow_tearing = false,

    }

})
hl.config({
    decoration = {
        rounding = 10,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity = 0.92,
        inactive_opacity = 0.90,

        shadow = {
            enabled = false,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },

        -- https://wiki.hypr.land/Configuring/Variables/#blur
        blur = {
            enabled = true,
            size = 5,
            passes = 6,
            vibrancy = 0.1696,
        }
    }

})

for i = 1, 5 do
    hl.workspace_rule({ workspace = i, monitor = dell })
end
for i = 6, 10 do
    hl.workspace_rule({ workspace = i, monitor = samsung })
end

-- KEYBINDS

mainMod = "SUPER"
term = "kitty"
editor = "emacs"
file = "thunar"
browser = "firefox"
pdfReader = "okular"

hl.bind(mainMod .. "+ N", hl.dsp.exec_cmd("qs ipc call notificationsPanel toggle"))
-- Window/Session actions
--hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(scrPath .. "/dontkillsteam.sh")) -- killactive, kill the window on focus
hl.bind(mainMod .. "+ Q", hl.dsp.window.close())
hl.bind("ALT + F4", hl.dsp.exec_cmd(scrPath .. "/dontkillsteam.sh "))                -- killactive, kill the window on focus
hl.bind(mainMod .. " + delete", hl.dsp.exit())                                       -- kill hyperland session
hl.bind(mainMod .. "+ W", hl.dsp.window.float())                                     -- toggle the window on focus to float
--hl.bind(mainMod .. "+ G", togglegroup, ) -- toggle the window on focus to group (tab mode)
hl.bind("ALT +  return", hl.dsp.window.fullscreen())                                 -- toggle the window on focus to fullscreen
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("hyprlock"))                              -- lock screen
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.exec_cmd(scrPath .. "/windowpin.sh"))      -- toggle pin on focused window
--hl.bind(mainMod .. " + backspace", hl.dsp.exec_cmd(scrPath .. "/logoutlaunch.sh 1")) -- logout menu
hl.bind(mainMod .. " + backspace", hl.dsp.exec_cmd("qs ipc call sessionMenu open")) -- logout menu
--hl.bind(CONTROL, ESCAPE, hl.dsp.exec_cmd("killall waybar || waybar ") -- toggle waybar

-- Application shortcuts
hl.bind(mainMod .. "+ T", hl.dsp.exec_cmd(term))    -- open terminal
hl.bind(mainMod .. "+ E", hl.dsp.exec_cmd(file))    -- open file manager
hl.bind(mainMod .. "+ C", hl.dsp.exec_cmd(editor))  -- open vscode
hl.bind(mainMod .. "+ F", hl.dsp.exec_cmd(browser)) -- open browser
hl.bind(mainMod .. "+ O", hl.dsp.exec_cmd(pdfReader))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("hyprpicker -acn"))
hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd("systemctl suspend && hyprlock"))
--hl.bind($CONTROL SHIFT, ESCAPE, hl.dsp.exec_cmd(scrPath .. "/sysmonlaunch.sh")) -- open htop/btop if installed or default to top (system monitor")

-- Rofi is toggled on/off if you repeat the key presses
--hl.bind(mainMod .. "+ A", hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/rofilaunch.sh d"))   -- launch desktop applications
hl.bind(mainMod .. "+ A", hl.dsp.exec_cmd("qs ipc call appsPanel open"))   -- launch desktop applications
hl.bind(mainMod .. "+ tab", hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/rofilaunch.sh w")) -- switch between desktop applications
hl.bind(mainMod .. "+ R", hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/rofilaunch.sh f"))   -- browse system files") --hl.bind(mainMod .. " + CTRL + L", exec, ~/dmenu-scripts/rofi-kbdistribution # change kbd layout


-- Audio control
hl.bind("F10", hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o m"))                  -- toggle audio mute
hl.bind("F11", hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o d"))                  -- decrease volume
hl.bind("F12", hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o i"))                  -- increase volume
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o m"))        -- toggle audio mute
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -i m"))     -- toggle microphone mute
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o d")) -- decrease volume
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o i")) -- increase volume
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

-- Brightness control
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(scrPath .. "/brightnesscontrol.sh i"))   -- increase brightness
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(scrPath .. "/brightnesscontrol.sh d")) -- decrease brightness

-- Screenshot/Screencapture
hl.bind(mainMod .. "+ P", hl.dsp.exec_cmd(scrPath .. "/screenshot.sh s"))          -- drag to snip an area / click on a window to print it
hl.bind(mainMod .. " + CTRL + P", hl.dsp.exec_cmd(scrPath .. "/screenshot.sh sf")) -- frozen screen, drag to snip an area / click on a window to print it
hl.bind(mainMod .. " + ALT + P", hl.dsp.exec_cmd(scrPath .. "/screenshot.sh m"))   -- print focused monitor
hl.bind("print", hl.dsp.exec_cmd(scrPath .. "/screenshot.sh p"))                   -- print all monitor outputs

-- Exec custom scripts
--hl.bind(mainMod .. "+ ALT + G", hl.dsp.exec_cmd(scrPath .. "/gamemode.sh ")) -- disable hypr effects for gamemode
hl.bind(mainMod .. "+ ALT + right", hl.dsp.exec_cmd(scrPath .. "/swwwallpaper.sh -n "))                          -- next wallpaper
hl.bind(mainMod .. "+ ALT + left", hl.dsp.exec_cmd(scrPath .. "/swwwallpaper.sh -p ) -- previous wallpaper"))    --hl.bind($mainMod ALT, up, hl.dsp.exec_cmd("$scrPath/wbarconfgen.sh n # next waybar mode") --hl.bind($mainMod ALT, down, exec, $scrPath/wbarconfgen.sh p # previous waybar mode
hl.bind(mainMod .. "+ SHIFT + D", hl.dsp.exec_cmd(scrPath .. "/wallbashtoggle.sh  ) -- toggle wallbash on/off")) --hl.bind($mainMod SHIFT, T, exec, pkill -x rofi || $scrPath/themeselect.sh # theme select menu
hl.bind(mainMod .. "+ SHIFT + A", hl.dsp.exec_cmd("pkill -x rofi || $scrPath/rofiselect.sh "))                   -- rofi style select menu
hl.bind(mainMod .. "+ SHIFT + W", hl.dsp.exec_cmd("pkill -x rofi || $scrPath/swwwallselect.sh "))                -- rofi wall select menu
hl.bind(mainMod .. "+ V", hl.dsp.exec_cmd("pkill -x rofi || $scrPath/cliphist.sh c  "))                          -- open Pasteboard in screen center
hl.bind(mainMod .. "+ SPACE", hl.dsp.exec_cmd(scrPath .. "/keyboardswitch.sh "))                                 -- change keyboard layout

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. "+ l", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. "+ h", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. "+ k", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. "+ j", hl.dsp.focus({ direction = "d" }))
hl.bind("ALT + Tab", hl.dsp.focus({ direction = "d" }))

-- Switch workspaces with mainMod + [0-9]
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. "+" .. key, hl.dsp.focus({ workspace = i }))                -- focus workspace
    hl.bind(mainMod .. " + CTRL + " .. key, hl.dsp.window.move({ workspace = i })) --move to workspace
    --hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({worskspace = i, follow = false})) -- move silently
end

-- Move active window to a workspace with mainMod + SHIFT + [0-9]

-- Switch workspaces relative to the active workspace with mainMod + CTRL + [←→]
--hl.bind(mainMod .. " + CTRL + l", workspace, r+1)
--hl.bind(mainMod .. " + CTRL + h", workspace, r-1)

--# move to the first empty workspace instantly with mainMod + CTRL + [↓]
--hl.bind(mainMod .. " + CTRL + j", workspace, empty)

-- Resize windows
--hl.bind(mainMod .. "+ SHIFT + l", hl.dsp.window.resize({x = 30, y = 0, window = "activewindow"}))
--hl.bind(mainMod .. "+ SHIFT + h", hl.dsp.window.resize({x = -30, y = 0}))
--hl.bind(mainMod .. "+ SHIFT + j", hl.dsp.window.resize({x = 0, y = 30}))
--hl.bind(mainMod .. "+ SHIFT + k", hl.dsp.window.resize({x = 0, y = -30}))


-- Move active window to a relative workspace with mainMod + CTRL + ALT + [←→]
--hl.bind($mainMod CTRL ALT, l, movetoworkspace, r+1)
--hl.bind($mainMod CTRL ALT, h, movetoworkspace, r-1)

-- Move active window around current workspace with mainMod + SHIFT + CTRL [←→↑↓]
hl.bind(mainMod .. "+SHIFT + CONTROL + h", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. "+SHIFT + CONTROL + l", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. "+SHIFT + CONTROL + k", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. "+SHIFT + CONTROL + j", hl.dsp.window.move({ direction = "d" }))

-- Scroll through existing workspaces with mainMod + scroll
--hl.bind($mainMod, mouse_down, workspace, e+1)
--hl.bind($mainMod, mouse_up, workspace, e-1)

-- Move/Resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. "+ mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. "+ mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Special workspaces (scratchpad)
hl.bind(mainMod .. " + ALT + S", hl.dsp.window.move({ workspace = "special" }))
hl.bind(mainMod .. "+ S", hl.dsp.workspace.toggle_special())



-- Trigger when the switch is turning off, Might cause bugs. Recommend to use logind instead.
--bindl= , switch:on:Lid Switch, exec, swaylock && systemctl suspend

--Master
hl.bind(mainMod .. "+ M", hl.dsp.layout("swapwithmaster"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.layout("focusmaster"))


--Animations
hl.curve("wind", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("winIn", { type = "bezier", points = { { 0.1, 1.1 }, { 0.1, 1.1 } } })
hl.curve("winOut", { type = "bezier", points = { { 0.3, -0.3 }, { 0, 1 } } })
hl.curve("liner", { type = "bezier", points = { { 1, 1 }, { 1, 1 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 6, bezier = "wind", style = "slide" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 6, bezier = "winIn", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "winOut", style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5, bezier = "wind", style = "slide" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 30, bezier = "liner", style = "loop" })

hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "liner" })
hl.animation({ leaf = "fade", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "wind" })

--layer rule

hl.layer_rule({
    match = {
      namespace = "quickshell",
    },
    blur = true,
    ignore_alpha = 0.5,
})
-- windowrule = match:title Signal, workspace 5
hl.window_rule({
    match = {
        title = "Signal"
    },
    workspace = "5"
})
hl.window_rule({
    match = {
        class = "thunar",
    },
    float = true,
    size = { "(monitor_w*0.5)", "(monitor_h*0.5)" },
    opacity = "0.8",
})
hl.window_rule({
    match = {
        class = "Emacs",
    },
    opacity = "0.90",
})
hl.window_rule({
    match = {
        class = "kitty",
    },
    opacity = "0.85",
})

--NVIDIA
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")


-- zoom
--
local MAX_ZOOM = 5
local MIN_ZOOM = 1
local ZOOM_TOGGLE_FACTOR = 4

---@param offset number
---@return nil
local function zoom(offset)
    local current = hl.get_config("cursor.zoom_factor")
    if offset ~= nil then
        current = current + offset
    elseif current ~= MIN_ZOOM then
        current = MIN_ZOOM
    else
        current = ZOOM_TOGGLE_FACTOR
    end
    current = math.max(MIN_ZOOM, math.min(MAX_ZOOM, current))
    hl.config({ cursor = { zoom_factor = current } })
end

hl.bind("SUPER + Z", zoom)
hl.bind("SUPER + equal", function()
    zoom(0.5)
end)
hl.bind("SUPER + minus", function()
    zoom(-0.5)
end)
