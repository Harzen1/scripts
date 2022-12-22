#!/bin/bash
# current files
f1=$HOME/.config/alacritty/.
f2=$HOME/.config/awesome/.
f3=$HOME/.config/mpd/.
f4=$HOME/.config/mpDris2/.
f5=$HOME/.config/ncmpcpp/.
f6=$HOME/.config/picom/.
f7=$HOME/.zshrc
f8=$HOME/.config/starship.toml
# github files
b1=$HOME/Documents/dotfiles/alacritty/.
b2=$HOME/Documents/dotfiles/awesome/.
b3=$HOME/Documents/dotfiles/mpd/.
b4=$HOME/Documents/dotfiles/mpDris2/.
b5=$HOME/Documents/dotfiles/ncmpcpp/.
b6=$HOME/Documents/dotfiles/picom/.
b7=$HOME/Documents/dotfiles/zshrc/.
b8=$HOME/Documents/dotfiles/starship/.

declare -a options=(
"1 - Backup to github"
"2 - Restore from backup"
)
declare -a files=(
"1 - Alacritty"
"2 - AwesomeWM"
"3 - Mpd"
"4 - MpDris2"
"5 - Ncmpcpp"
"6 - Picom"
"7 - Starship"
"9 - Zshrc"
"All Files"
)
a=1
### dmenu select
option=$(printf '%s\n' "${options[@]}" | rofi -i -dmenu ${#files[@]} -p "Option: ")
if [[ "$option" == "1 - Backup to github" ]];then
    file=$(printf '%s\n' "${files[@]}" | rofi -i -dmenu ${#files[@]} -p "Files: ")
    if [[ "$file" == "All Files" ]];then
        while [[ $a -le 8 ]];
        do
            file=f$a
            backup=b$a
            echo "cp -r ${!file} ${!backup}"
            # cp -r ${!file} ${!backup}
            a=$(( $a + 1 ))
        done
        notify-send 'Dotfiles Backed up'
    fi
elif [[ "$option" == "2 - Restore from backup" ]]; then
    notify-send 'restore'
    file=$(printf '%s\n' "${files[@]}" | rofi -i -dmenu ${#files[@]} -p "Files: ")
    if [[ "$file" == "All Files" ]];then
        while [[ $a -le 8 ]];
        do
            file=f$a
            backup=b$a
            echo "File: ${!file}"
            # cp -r ${!backup} ${!file} 
            a=$(( $a + 1 ))
        done
        notify-send 'Dotfiles Restored From backup'
    fi
fi
