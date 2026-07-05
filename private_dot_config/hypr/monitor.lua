--# MONITOR CONFIGURATION ## 

hl.monitor({
    output = "eDP-1",
    mode = "1920x1080@60",
    position = "3440x0",
    scale = "1",
})

hl.monitor({
    output = "HDMI-A-2",
    mode = "3440x1440@49.99",
    position = "0x0",
    scale = "1",
})

hl.monitor({
    output = "HDMI-A-1",
    disabled = true,
})

hl.workspace_rule({
    workspace = "1",
    monitor = "HDMI-A-2",
})

hl.workspace_rule({
    workspace = "10",
    monitor = "eDP-1",
})
