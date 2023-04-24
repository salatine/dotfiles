scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
shareFolders=( ".fonts" ".icons" ".themes" )
home="$HOME"
ignoreFiles=( "install.sh" "readme.md" ".git" )

main() {
    addRootFiles
    checkConfig
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
                echo "Overwrote $home/$(basename $file)"
            fi
        else
            cp $file $home
            echo "Copied $file to $home"
        fi
    done
}

checkConfig() {
    if [ ! -d "$home/.config" ]; then
        mkdir $home/.config
        echo "Created $home/.config"
    fi
}

addConfigFiles() {
    for folder in $(find "$scriptDir/.config" -maxdepth 1 -type d | grep ".config/"); do
        if [ -d "$home/.config/$(basename $folder)" ]; then
            echo "$home/.config/$(basename $folder) already exists, overwrite? (y/n)"
            read overwrite
            if [ "$overwrite" == "y" ]; then
                cp -r $folder $home/.config
                echo "Overwrote $home/.config/$(basename $folder)"
            fi
        else
            cp -r $folder $home/.config
            echo "Copied $folder to $home/.config"
        fi
    done
}

addShareFolders() {
    for folder in "${shareFolders[@]}"; do
        shareFolder=${folder:1}
        if [ ! -d "$home/.local/share/$shareFolder" ]; then
            
            mkdir -p $home/.local/share/$shareFolder
            echo "Created $home/.local/share/$shareFolder"
        fi
        cp -r $scriptDir/$folder/* $home/.local/share/$shareFolder
        echo "Copied $scriptDir/$folder/* to $home/.local/share/$shareFolder"
    done
}

main