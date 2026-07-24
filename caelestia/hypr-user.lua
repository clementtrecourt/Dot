local hostname = io.popen("hostname"):read("*l")

if hostname == "home" then
    require("monitors")
else
    require("monitors-work")
end

hl.exec_cmd("hyprshade auto")
