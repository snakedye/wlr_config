# Add manga to library

function addmanga --description "Add manga to my library"
  set -l old (ls -t ~/.mangas | head -1)
  set -l url "$argv[1]"
  set -l number "$argv[2]"
  printf "$url\n$number" | ./mangadex-dl.py
  set -l new (ls -t ~/.mangas | head -1)

  if test "$old" != "$new"
    touch ~/.mangas/$new/.url
    mkdir ~/.mangas/$new/.chapter
    set url (curl "$url/covers/" | grep -o 'https://mangadex.org/images/covers.*?' | sed 's/["].*//'| sort -r  |head -1)
    curl -o "$HOME/.mangas/.covers/$new.jpg" $url
    echo "$url" > ~/.mangas/$new/.url
  end
  set chap (ls -t ~/.mangas/$new/ | head -1 )
  set dir "'$HOME/.mangas/$new/$chap'"
  touch ~/.mangas/$new/.chapter/$new$number.desktop
  echo "[Desktop Entry]
Type=Application
Name=$new Ch.$number
Icon=$HOME/.mangas/.covers/$new.jpg
Exec=cd $dir ; ls ./ | feh
Categories=Manga" > ~/.mangas/$new/.chapter/$new$number.desktop
end
