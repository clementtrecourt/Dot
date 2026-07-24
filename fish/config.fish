if not set -q SSH_AUTH_SOCK
    ssh-agent -c | source
end

ssh-add -l >/dev/null 2>&1
or ssh-add ~/.ssh/id_ed25519
if status is-interactive
    # Starship custom prompt
    command -v starship &>/dev/null && starship init fish | source

    # Direnv + Zoxide
    command -v direnv &>/dev/null && direnv hook fish | source
    command -v zoxide &>/dev/null && zoxide init fish --cmd cd | source

    # Better ls
    command -v eza &>/dev/null && alias ls='eza --icons --group-directories-first -1'

    # Better ls (eza) - sans le -1 pour ne pas casser ll ou lla
    alias ls='eza --icons --group-directories-first'
    abbr dev '~/Code/devcontainer/adm.sh'
    abbr l 'ls -1'
    abbr ll 'ls -l'
    abbr la 'ls -a'
    abbr lla 'ls -la'

    # Git Abbrs
    abbr lg lazygit
    abbr gs 'git status'
    abbr ga 'git add .'
    abbr gc 'git commit -am'
    abbr gd 'git diff'
    abbr gl 'git log'
    abbr gp 'git push'
    abbr gpl 'git pull'
    abbr gco 'git checkout'
    abbr gsw 'git switch'
    abbr gsm 'git switch main'
    abbr gb 'git branch'
    abbr gbd 'git branch -d'
    abbr gst 'git stash'
    abbr gsp 'git stash pop'
    abbr gsh 'git show'
    abbr gf 'git fetch'
    abbr gcl 'git clone'
    abbr n nvim

    # NixOS
    abbr nrs 'sudo nixos-rebuild switch --flake /etc/nixos#work'
    abbr nrb 'sudo nixos-rebuild boot   --flake /etc/nixos#work'
    abbr nrd 'sudo nixos-rebuild switch --flake /etc/nixos#work --show-trace 2>&1 | less'
    abbr nrg 'sudo nix-collect-garbage -d && sudo nix store optimise'
    abbr nru 'sudo nix flake update /etc/nixos'
    abbr nsh 'nix-shell -p'
    abbr npk 'nix search nixpkgs'
    # Custom colours
    if not set -q TMUX; and test -f ~/.local/state/caelestia/sequences.txt
        cat ~/.local/state/caelestia/sequences.txt
    end

    # For jumping between prompts in foot terminal
    function mark_prompt_start --on-event fish_prompt
        echo -en "\e]133;A\e\\"
    end

    # Custom fish config
    set -q XDG_CONFIG_HOME && set -l cConf $XDG_CONFIG_HOME/caelestia || set -l cConf $HOME/.config/caelestia
    source $cConf/user-config.fish 2>/dev/null
    if not set -q TMUX
        # 'exec' remplace le shell par tmux. '-A' attache à la session 'main' ou la crée.
        exec tmux new-session -A -s main
    end
end
