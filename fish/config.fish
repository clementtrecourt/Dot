# ~/.config/fish/config.fish

# 1. Variables et chemins globaux (qui doivent être dispo même en non-interactif)
fish_add_path "$HOME/.local/bin"

if test (tty) = /dev/tty1
    exec mango
end
if not set -q SSH_AUTH_SOCK
    ssh-agent -c | source
end

ssh-add -l >/dev/null 2>&1
or ssh-add ~/.ssh/id_ed25519
# 2. Configuration interactive
if status is-interactive
    # Starship custom prompt
    starship init fish | source

    # Direnv + Zoxide (Syntaxe idiomatique Fish)
    type -q direnv; and direnv hook fish | source
    type -q zoxide; and zoxide init fish --cmd cd | source

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

    function mark_prompt_start --on-event fish_prompt
        echo -en "\e]133;A\e\\"
    end

    if not set -q TMUX
        # 'exec' remplace le shell par tmux. '-A' attache à la session 'main' ou la crée.
        exec tmux new-session -A -s main
    end
end
