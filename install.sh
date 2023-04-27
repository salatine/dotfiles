#!/usr/bin/env bash
scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
shareFolders=( ".fonts" ".icons" ".themes" )
home="$HOME"
ignoreFiles=( "install.sh" "readme.md" ".git" )

main() {
    addRootFiles
    addConfigFiles
    addShareFolders
}

addRootFiles() {
    for file in $(find "$scriptDir" -maxdepth 1 -type f); do
        for ignore in "${ignoreFiles[@]}"; do
            if [ "$file" == "$scriptDir/$ignore" ]; then
                continue 2
            fi
        done
        if [ -f "$home/$(basename $file)" ]; then
            echo "$home/$(basename $file) already exists, overwrite? (y/n)"
            read overwrite
            if [ "$overwrite" == "y" ]; then
                cp $file $home
                echo "overwrote $home/$(basename $file)"
            fi
        else
            cp $file $home
            echo "copied $file to $home"
        fi
    done
}

checkConfig() {
    if [ ! -d "$home/.config" ]; then
        mkdir $home/.config
        echo "created $home/.config"
    fi
}

addConfigFiles() {
    checkConfig
    for folder in $(find "$scriptDir/.config" -maxdepth 1 -type d | grep ".config/"); do
        if [ -d "$home/.config/$(basename $folder)" ]; then
            echo "$home/.config/$(basename $folder) already exists, overwrite? (y/n)"
            read overwrite
            if [ "$overwrite" == "y" ]; then
                cp -r $folder $home/.config
                echo "overwrote $home/.config/$(basename $folder)"
            fi
        else
            cp -r $folder $home/.config
            echo "copied $folder to $home/.config"
        fi
    done
}

addShareFolders() {
    for folder in "${shareFolders[@]}"; do
        shareFolder=${folder:1}
        if [ ! -d "$home/.local/share/$shareFolder" ]; then
            
            mkdir -p $home/.local/share/$shareFolder
            echo "created $home/.local/share/$shareFolder"
        fi
        cp -r $scriptDir/$folder/* $home/.local/share/$shareFolder
        echo "copied $scriptDir/$folder/* to $home/.local/share/$shareFolder"
    done
}

main