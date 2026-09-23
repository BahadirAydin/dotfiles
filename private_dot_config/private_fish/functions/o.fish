function o --description 'Open files with the default application'
    for f in $argv
        xdg-open $f &>/dev/null &
        disown
    end
end
