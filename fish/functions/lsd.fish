function lsd --description "ls or cat"
  if test -d $argv
    for entry in (exa -1 $argv)
      if test -d $argv/$entry
        echo (set_color blue)$entry/
      else
        echo (set_color white)$entry
      end
    end
  else if test -e $argv
    cat $argv
  end
end
