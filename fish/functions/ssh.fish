# ~/.config/fish/functions/ssh.fish

function ssh
    # Tentative silencieuse avec BatchMode (clé seulement, pas de mdp)
    command ssh -o BatchMode=yes -o ConnectTimeout=5 $argv 2>/dev/null
    set exit_code $status

    # Si succès : c'est bon, on a fini
    if test $exit_code -eq 0
        return 0
    end

    # Extraire user@host (dernier arg de type user@host ou juste host)
    set target ""
    for arg in $argv
        if string match -qr '^[^-]' -- $arg
            set target $arg
        end
    end

    if test -z "$target"
        # Pas de cible trouvée, fallback ssh normal
        command ssh $argv
        return $status
    end

    # Tenter ssh-copy-id (demandera le mot de passe une fois)
    echo "🔑 Clé absente pour $target — lancement de ssh-copy-id..."
    if ssh-copy-id $target
        echo "✅ Clé copiée. Reconnexion..."
        command ssh $argv
    else
        # ssh-copy-id a échoué (mdp faux, réseau, etc.) — fallback normal
        echo "⚠️  ssh-copy-id échoué, connexion normale..."
        command ssh $argv
    end
end
