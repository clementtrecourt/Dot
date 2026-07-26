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
