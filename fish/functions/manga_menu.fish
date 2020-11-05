function manga_menu --description 'nwggrid menu for mangas in library'
  set -l args ""
  ls $HOME/.mangas/ | while read manga
    set args "$HOME/.mangas/$manga/.chapter:$args"
  end
  nwggrid -d $args -s 200 -o 0.8 -b 434c5e
end
