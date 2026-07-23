function mkcd --description "Crée un dossier et s'y déplace"
    mkdir -p $argv[1] && cd $argv[1]
end
