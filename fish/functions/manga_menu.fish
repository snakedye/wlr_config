function manga_menu --description 'nwggrid menu for mangas in library'
  set -l args ""
  ls /home/$USER/.mangas/ | while read manga
    set args "/home/$USER/.mangas/$manga/.chapter:$args"
  end
  nwggrid -d $args -s 200 -o 0.9 -b 434c5e
end
