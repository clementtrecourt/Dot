function sysinfo --description "Résumé rapide du système"
    set kernel (uname -r)
    set nix_ver (nix --version 2>/dev/null | head -1)
    set gen (sudo nix-env --list-generations --profile /nix/var/nix/profiles/system 2>/dev/null | tail -1)
    set disk (df -h / | awk 'NR==2{print $3"/"$2" ("$5")"}')
    set mem (free -h | awk '/^Mem/{print $3"/"$2}')
    set cpu (grep -m1 "model name" /proc/cpuinfo | cut -d: -f2 | string trim)
    set uptime_str (uptime -p)

    echo ""
    echo "  Kernel    : $kernel"
    echo "  Nix       : $nix_ver"
    echo "  Génération: $gen"
    echo "  CPU       : $cpu"
    echo "  RAM       : $mem"
    echo "  Disque    : $disk"
    echo "  Uptime    : $uptime_str"
    echo ""
end
