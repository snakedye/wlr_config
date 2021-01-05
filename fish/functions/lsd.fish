function lsd --description "ls or cat"
  if test -d $argv
    exa -1 $argv
  else if test -e $argv
    cat $argv
  end
end
