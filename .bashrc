#### Animated ASCII
if [[ -n $PS1 ]]; then
   (
     tput civis
     for frame in ~/.config/neofetch/frames_colour/*.txt; do
       clear
       cat "$frame"
       sleep 0.01
       # Herhangi bir tuşa basıldı mı kontrol et
       if read -t 0 -n 1 2>/dev/null; then
         break
       fi
     done
     tput sgr0
     tput cnorm
     clear
   ) || true
   # stdin buffer'ı temizle
   while read -t 0.01 -n 1 2>/dev/null; do :; done
fi
