local hostname = io.popen("hostname"):read("*l")

if hostname == "nixos" then
    require("monitors")
else
    require("monitors-work")
end
hl.config({
    input = {
        kb_layout          = "qwerty-fr",
    },
})


hl.exec_cmd("hyprshade auto")
hl.bind("SUPER + P", hl.dsp.exec_cmd("hyprshot -m region --freeze"))
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.plugin.load("/nix/store/vk2iyw3f7l4js6ls3jvy1pjs2xhnai9f-gloview-0.3.0/lib/libgloview.so")
hl.config({
    plugin = {
        gloview = {
            layout = "rows",
            gap = 24,
            blur = 1,
            anchor = "top",
            dynamic_workspaces = 1,
            duration = 100,
            passthrough_keys = 0,
            show_special = 1
        },
    },
})
hl.bind("SUPER + TAB", hl.plugin.gloview.toggle)
