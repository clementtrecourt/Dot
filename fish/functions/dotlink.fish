function dotlink --description "Symlinke les dotfiles ~/Dot vers ~/.config"
    set dot $HOME/Dot
    set cfg $HOME/.config

    set -l pairs \
        "fish:fish" \
        "nvim:nvim" \
        "kitty:kitty" \
        "starship.toml:starship.toml" \
        ".tmux.conf:.tmux.conf"

    for pair in $pairs
        set src $dot/(string split ":" $pair)[1]
        set dst_rel (string split ":" $pair)[2]

        # .tmux.conf va dans $HOME, pas $cfg
        if string match -q ".*" $dst_rel
            set dst $HOME/$dst_rel
        else
            set dst $cfg/$dst_rel
        end

        if not test -e $src
            continue
        end

        if test -L $dst
            echo "  déjà lié : $dst"
        else if test -e $dst
            echo "  conflit  : $dst (existe déjà, ignoré)"
        else
            mkdir -p (dirname $dst)
            ln -s $src $dst
            echo "  lié      : $dst -> $src"
        end
    end
end
