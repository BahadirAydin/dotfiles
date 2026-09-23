set FNM_PATH "$HOME/.local/share/fnm"
if test -d $FNM_PATH
    set PATH $FNM_PATH $PATH
    for cmd in node npm npx corepack
        function $cmd --inherit-variable cmd
            functions --erase node npm npx corepack
            fnm env | source
            $cmd $argv
        end
    end
end
