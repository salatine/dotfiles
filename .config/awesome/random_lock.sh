file=$(find $HOME/.wallpapers/lockscreen -type f | shuf -n 1)
betterlockscreen -u $file
betterlockscreen -l blur 0.5
