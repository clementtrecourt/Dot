-- Écran gauche : Samsung
hl.monitor({
    output = "DP-3",
    mode = "1920x1080@60",
    position = "0x0",
    scale = 1,
    vrr = 0,
})

-- Écran droit : Philips
hl.monitor({
    output = "HDMI-A-3",
    mode = "1920x1080@60",
    position = "1920x0",
    scale = 1,
    vrr = 0,
})

-- Écran gauche (Samsung) : workspaces 6-10
for i = 6, 10 do
    hl.workspace_rule({
        workspace = tostring(i),
        monitor = "DP-3",
    })
end

-- Écran droit (Philips) : workspaces 1-5
for i = 1, 5 do
    hl.workspace_rule({
        workspace = tostring(i),
        monitor = "HDMI-A-3",
    })
end

-- Workspace initial Philips (droite)
hl.workspace_rule({
    workspace = "1",
    monitor = "HDMI-A-3",
    default = true,
})

-- Workspace initial Samsung (gauche)
hl.workspace_rule({
    workspace = "6",
    monitor = "DP-3",
    default = true,
})
