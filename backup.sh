#!/bin/bash
# Dotfiles
# Origin
f1=$HOME/.config/alacritty/.
f2=$HOME/.config/awesome/.
f3=$HOME/.config/mpd/.
f4=$HOME/.config/mpDris2/.
f5=$HOME/.config/ncmpcpp/.
f6=$HOME/.config/picom/.
# special directory
f7=$HOME/.config/starship.toml
f8=$HOME/.zshrc
# Github
b1=$HOME/Documents/dotfiles/alacritty/.
b2=$HOME/Documents/dotfiles/awesome/.
b3=$HOME/Documents/dotfiles/mpd/.
b4=$HOME/Documents/dotfiles/mpDris2/.
b5=$HOME/Documents/dotfiles/ncmpcpp/.
b6=$HOME/Documents/dotfiles/picom/.
b7=$HOME/Documents/dotfiles/starship/.
b8=$HOME/Documents/dotfiles/zshrc/.
# Scripts
scripts=$HOME/Documents/scripts/.
declare -a options=(
"1 - Backup to local folder"
"2 - Restore from backup folder"
"3 - Restore from Github"
"4 - Push changes to Github"
)
declare -a files=(
"1 - Dotfiles"
"2 - Scripts"
"3 - All"
)
declare -a git=(
"1 - Yes"
"2 - No"
)
gitpush(){
cd $HOME/Documents/$folder
git add .
git commit -m "Backup script"
git push origin main
notify-send 'Changes pushed to Github'
}
gitpull(){
cd $HOME/Documents/$folder
git fetch origin main
git reset --hard origin/main
notify-send 'Dotfiles replaced from Github'
}
dotfiles(){
a=1
b=6
folder="dotfiles"
while [[ $a -le $b ]];
do
  file=f$a
  backup=b$a
  cp -r ${!file} ${!backup} 
  a=$(( $a + 1 ))
done
cp -r $f7 $b7
cp -r $f8 $b8
notify-send 'Dotfiles Backed up'
}
scripts(){
folder="scripts"
cp -r $HOME/scripts/. $HOME/Documents/scripts/
notify-send 'Scripts Backed up'
}
# local Folders Options
# Backup
option=$(printf '%s\n' "${options[@]}" | rofi -i -dmenu ${#files[@]} -p "Option: ")
if [[ "$option" == "1 - Backup to local folder" ]];then
    choice=$(printf '%s\n' "${files[@]}" | rofi -i -dmenu ${#files[@]} -p "Files: ")
    if [[ "$choice" == "1 - Dotfiles" ]];then
      dotfiles
    elif [[ "$choice" == "2 - Scripts" ]];then
      scripts
    elif [[ "$choice" == "3 - All" ]];then
     echo hehe 
    fi
    echo hehehehehe
    choice=$(printf '%s\n' "${git[@]}" | rofi -i -dmenu ${#git[@]} -p "Push changes to Github?: ")
    if [[ "$choice" == "1 - Yes" ]];then
      gitpush && exit 0
    else
        exit 0
    fi
    exit 1

# restore
elif [[ "$option" == "2 - Restore from backup folder" ]]; then
    choice=$(printf '%s\n' "${files[@]}" | rofi -i -dmenu ${#files[@]} -p "Folders: ")
    if [[ "$choice" == "1 - Dotfiles" ]];then
        while [[ $a -le $b ]];
        do
            file=f$a
            backup=b$a
            #cp -r ${!backup} ${!file} 
            rsync -qav --exclude=".*" ${!backup} ${!file}
            #cp -r $b7 $HOME/
            a=$(( $a + 1 ))
            notify-send 'Dotfiles Restored From Backup'
        done
        cp -r $b7 $HOME/.config/
        cp -r $b8 $HOME/
    
    elif [[ "$choice" == "2 - Scripts" ]];then
        #cp -r $HOME/Documents/scripts/. /$HOME/Scripts/
        rsync -qav --exclude=".*" $HOME/Documents/scripts/* $HOME/scripts/
        notify-send 'Scripts Restored From Backup'
    fi
    exit 0

# Github Options
elif [[ "$option" == "3 - Restore from Github" ]]; then
    choice=$(printf '%s\n' "${files[@]}" | rofi -i -dmenu ${#files[@]} -p "Repos: ")
    if [[ "$choice" == "1 - Dotfiles" ]];then
        folder="dotfiles"
    elif [[ "$choice" == "2 - Scripts" ]];then
        folder="scripts"
    fi
    gitpull && exit 0

  elif [[ "$option" == "4 - Push changes to Github" ]]; then
    choice=$(printf '%s\n' "${files[@]}" | rofi -i -dmenu ${#files[@]} -p "Repos: ")
    if [[ "$choice" == "1 - Dotfiles" ]];then
        folder="dotfiles"
    elif [[ "$choice" == "2 - Scripts" ]];then
        folder="scripts"
    elif [[ "$choice" == "3 - All" ]];then
        folder="dotfiles"
        gitpush
        folder="scripts"
        gitpush
        exit 0
    fi
    gitpush && exit 0
fi
