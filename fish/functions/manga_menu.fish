function manga_menu --description 'nwggrid menu for mangas in library'
  set -l args ""
  ls $HOME/.mangas/ | while read manga
    set args "$HOME/.mangas/$manga/.chapter:$args"
  end
  nwggrid -d $args -s 230 -o 0.9 -b 3b4252 -n 6 -c manga.css
end
