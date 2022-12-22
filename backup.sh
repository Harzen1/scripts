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
"1 - Backup to local folder"
"2 - Restore from backup"
"3 - Push changes to Github"
"4 - Pull changes from Github"
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
declare -a git=(
"1 - Yes"
"2 - No"
)
a=1
# Rofi Backup
option=$(printf '%s\n' "${options[@]}" | rofi -i -dmenu ${#files[@]} -p "Option: ")
if [[ "$option" == "1 - Backup to github" ]];then
    file=$(printf '%s\n' "${files[@]}" | rofi -i -dmenu ${#files[@]} -p "Files: ")
    if [[ "$file" == "All Files" ]];then
        while [[ $a -le 8 ]];
        do
            file=f$a
            backup=b$a
            cp -r ${!file} ${!backup}
            a=$(( $a + 1 ))
        done
        notify-send 'Dotfiles Backed up'
    fi
    choice=$(printf '%s\n' "${git[@]}" | rofi -i -dmenu ${#git[@]} -p "Push changes to Github?: ")
    if [[ "choice" == "1 - Yes" ]];then
        cd $HOME/Documents/dotfiles
        git add .
        git commit -m "Backup script"
        git push origin master
        notify-send 'Changes pushed to Github'
    else
        fi
    fi
# Rofi restore
elif [[ "$option" == "2 - Restore from backup" ]]; then
    notify-send 'restore'
    file=$(printf '%s\n' "${files[@]}" | rofi -i -dmenu ${#files[@]} -p "Files: ")
    if [[ "$file" == "All Files" ]];then
        while [[ $a -le 8 ]];
        do
            file=f$a
            backup=b$a
            cp -r ${!backup} ${!file} 
            a=$(( $a + 1 ))
        done
        notify-send 'Dotfiles Restored From backup'
    fi
elif [[ "$option" == "3 - Push changes to Github" ]]; then
    cd $HOME/Documents/dotfiles
    git add .
    git commit -m "Backup script"
    git push origin master
    notify-send 'Changes pushed to Github'
elif [[ "$option" == "4 - Pull changes from Github" ]]; then
    cd $HOME/Documents/dotfiles
    git fetch origin master
    git reset --hard origin/master
fi
