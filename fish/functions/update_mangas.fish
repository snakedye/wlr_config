# Update manga library

function update_mangas --description 'Update my manga library'
  set manga $argv[1]
  if test "$manga" = ""
    for manga in (ls ~/.mangas/)
      set chap (ls ~/.mangas/(echo $manga | sed 's/_/ /g') | sort -nr | sed -n "1p" | grep -o "^[a-z0-9]*" | sed "s/[a-z]//g" | sed "s/0*//")
      set -l chap (math $chap+1)
      addmanga (echo $manga | sed 's/ /_/g') $chap
    end
  else
    set chap (ls ~/.mangas/(echo $manga | sed 's/_/ /g') | sort -nr | sed -n "1p" | grep -o "^[a-z0-9]*" | sed "s/[a-z]//g" | sed "s/0*//")
    set -l chap (math $chap+1)
    addmanga "$manga" "$chap"
  end
end
