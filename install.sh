scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
home="$HOME"

# for each file in the dotfiles directory, check if it exists in the home directory, if it does then ask if it should be overwritten, if it doesn't then copy it
# create home/.config if it doesn't exist
# for every folder in dotfiles/.config/, check if it exists in the home/.config/ directory, if it does then ask if it should be overwritten, if it doesn't then copy it

for file in $(find "$scriptDir" -maxdepth 1 -type f); do
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

if [ ! -d "$home/.config" ]; then
    mkdir $home/.config
    echo "Created $home/.config"
fi

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