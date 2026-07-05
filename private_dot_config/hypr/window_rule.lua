hl.window_rule({
    match = {
        class = "(org.pulseaudio.pavucontrol)",
    },
    float = true,
})

hl.window_rule({
    match = {
        class = "(blueman-manager)",
    },
    float = true,
})

hl.window_rule({
    match = {
        class = "(^zoom$)",
    },
    float = true,
})

hl.window_rule({
    match = {
        class = "(org.qbittorrent.qBittorrent)",
    },
    float = true,
})

hl.window_rule({
    match = {
        class = "(anki)",
    },
    float = true,
})

hl.window_rule({
    match = {
        class = ".*",
    },
    idle_inhibit = "fullscreen",
})

hl.window_rule({
    match = {
        class = "(firefox)",
        title = "^(Opening .*)$",
    },
    float = true,
})

hl.window_rule({
    match = {
        class = "(firefox)",
        title = "^(Save As)$",
    },
    float = true,
})
