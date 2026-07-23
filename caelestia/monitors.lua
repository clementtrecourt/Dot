-- Écran gauche : BenQ DP-2
hl.monitor({
    output = "DP-2",
    mode = "1920x1080@60",
    position = "0x0",
    scale = 1,
    vrr = 0,
})

-- Écran droit : Samsung DP-1
hl.monitor({
    output = "DP-1",
    mode = "2560x1440@144",
    position = "1920x0",
    scale = 1,
    vrr = 0,
})

-- Écran droit Samsung DP-1 : workspaces 1-5
for i = 1, 5 do
    hl.workspace_rule({
        workspace = tostring(i),
        monitor = "DP-1",
    })
end

-- Écran gauche BenQ DP-2 : workspaces 6-10
for i = 6, 10 do
    hl.workspace_rule({
        workspace = tostring(i),
        monitor = "DP-2",
    })
end

-- Workspace initial Samsung (droite)
hl.workspace_rule({
    workspace = "1",
    monitor = "DP-1",
    default = true,
})

-- Workspace initial BenQ (gauche)
hl.workspace_rule({
    workspace = "6",
    monitor = "DP-2",
    default = true,
})
