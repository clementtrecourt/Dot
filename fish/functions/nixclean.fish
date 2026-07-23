function nixclean --description "Garbage collect + optimise le store Nix"
    set before (df -h / | awk 'NR==2{print $3}')
    echo "Espace utilisé avant : $before"
    sudo nix-collect-garbage -d
    sudo nix store optimise
    set after (df -h / | awk 'NR==2{print $3}')
    echo "Espace utilisé après : $after"
end
