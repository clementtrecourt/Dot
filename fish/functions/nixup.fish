function nixup --description "Met à jour le flake et rebuild NixOS"
    echo "Mise à jour du flake..."
    sudo nix flake update /etc/nixos
    or return 1
    echo "Rebuild en cours..."
    sudo nixos-rebuild switch --flake /etc/nixos#nixos
end
