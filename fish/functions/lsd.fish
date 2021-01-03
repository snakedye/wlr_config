function lsd --description "ls with icons"
  if test -n $argv
    set stdin (string sub -s 5 $argv)
  end
  if test -d $stdin
    set list (ls $stdin)
  else if test -e $stdin
    set entry $stdin
    head -200 $entry
  else
    # set list (ls)
    echo $argv
  end
  for entry in $list
    if test -d "$stdin/$entry" || test -d $entry
      switch $entry
        case Videos
          set directory "   $entry"
        case Music
          set directory "   $entry"
        case Audiobooks
          set directory "   $entry"
        case Pictures
          set directory "   $entry"
        case Downloads
          set directory "   $entry"
        case Documents
          set directory "   $entry"
        case '*'
          set directory "   $entry"
      end
      echo (set_color blue) $directory
    else
      switch $entry
        case '*.sh'
          set file "   $entry"
        case '*.'{md,txt,log}
          set file "   $entry"
        case '*.'{png,jpg,svg,webp,gif}
          set file "   $entry"
        case '*.fish'
          set file "   $entry"
        case '*.rs'
          set file "   $entry"
        case '*.js'
          set file "   $entry"
        case '*.py'
          set file "   $entry"
        case '*.css'
          set file "   $entry"
        case '*.'{c,h}
          set file "   $entry"
        case '*.go'
          set file "   $entry"
        case '*.pdf'
          set file "   $entry"
        case '*.'{mp4,mkv}
          set file "   $entry"
        case '*.'{mp3,m4a}
          set file "   $entry"
        case '*.'{tar,zip}
          set file "遲    $entry"
        case '*'
          set file "   $entry"
      end
      # if test -L $stdin
        # echo (set_color purple) $file
      # else if test -x $stdin
        # echo (set_color green) $file
      # else
        echo (set_color white) $file
      # end
    end
  end
end
