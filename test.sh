
#!/bin/bash
### Echo Colors
nc='\033[0m'
gc='\033[0;32m'
rc='\033[0;31m'
### Configs Folders
declare -a configs=(
"1  $HOME/.config/kitty/             $HOME/Documents/GitHub/configs/dotfiles/"
"2  $HOME/.config/mpd/mpd.conf       $HOME/Documents/GitHub/configs/dotfiles/mpd/"
"3  $HOME/.config/ncmpcpp/config     $HOME/Documents/GitHub/configs/dotfiles/ncmpcpp/"
"4  $HOME/.xprofile                  $HOME/Documents/GitHub/configs/dotfiles/xprofile/"
"5  $HOME/.config/picom/             $HOME/Documents/GitHub/configs/dotfiles/picom/"
"6  $HOME/.config/bspwm/             $HOME/Documents/GitHub/configs/dotfiles/bspwm-polybar/"
"7  $HOME/.config/sxhkd/             $HOME/Documents/GitHub/configs/dotfiles/bspwm-polybar/"
"8  $HOME/.config/polybar/           $HOME/Documents/GitHub/configs/dotfiles/bspwn-polybar/"
"9  $HOME/.config/rofi/              $HOME/Documents/GitHub/configs/dotfiles/"
"10 $HOME/.config/dunst/             $HOME/Documents/GitHub/configs/dotfiles/"
"11 $HOME/.zshrc                     $HOME/Documents/GitHub/configs/dotfiles/zshrc/"
"All"
)
### temp file to store output
temp=$(mktemp /tmp/backup.XXX)
### counter variable for while loop
a=1
### dmenu select
choice=$(printf '%s\n' "${configs[@]}" | rofi -i -dmenu ${#configs[@]} -p "Select Option:")
if [[ "$choice" == "All" ]];then
    ### while loop to backup all files
    while [[ $a -le 11 ]];
    do
        file=$(printf '%s\n' "${configs[@]}" | awk '{if(NR=='$a') print $2}')
        backup=$(printf '%s\n' "${configs[@]}" | awk '{if(NR=='$a') print $3}')
        ok=$(echo -e "$file ""${gc} Backup Successful!${nc}" )
        fail=$(echo -e "$file ""${rc} Backup Failed!${nc}" )
        cp -r $file $backup 2>/dev/null && echo $ok>>$temp|| echo $fail>>$temp
        a=$(( $a + 1 ))
    done
elif [ "$choice" ];then
    ### backup only selected file
    b=$(echo "$choice" | awk '{print $1}')
    file=$(printf '%s\n' "${configs[@]}" | awk '{if(NR=='$b') print $2}')
    backup=$(printf '%s\n' "${configs[@]}" | awk '{if(NR=='$b') print $3}')
    ok=$(echo -e "$file ""${gc} Backup Successful!${nc}" )
    fail=$(echo -e "$file ""${rc} Backup Failed!${nc}" )
    cp -r $file $backup 2>/dev/null && echo $ok>$temp|| echo $fail>$temp
fi
if [ ! "$choice" ];then exit 0;fi
cat $temp | column -t
# single backup notification
if [ "$(cat $temp | wc -l)" = 1 ] && [ -z "$(cat $temp | grep Failed)" ];then 
notify-send -i mintupdate-up-to-date -u normal "$(echo -e Dotfiles Backup'\n'Backup Finished!)"
elif [ "$(cat $temp | wc -l)" = 1 ] && [ -z "$(cat $temp | grep Success)" ];then 
notify-send -i mintupdate-error -u normal "$(echo -e Dotfiles Backup'\n'Backup Failed!)";fi
# all files backup notification
if [ "$(cat $temp | wc -l)" -gt 2 ] && [ -z "$(cat $temp | grep Failed)" ];then
notify-send -i mintupdate-up-to-date -u normal "$(echo -e Dotfiles Backup'\n'Backup Finished!'\n'Without Errors)"
elif [ "$(cat $temp | wc -l)" -gt 2 ];then
notify-send -i mintupdate-checking -u normal "$(echo -e Dotfiles Backup'\n'Backup Finished!'\n'With Errors)";fi
rm $temp 2>/dev/null
