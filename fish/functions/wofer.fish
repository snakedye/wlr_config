# Wofi file browser

set SHOW_HIDDEN false
set EXTENSIONS ~/wofer/extensions

function lsi --description "ls with icons"
  echo "   .. "
  if $SHOW_HIDDEN
    set all -A
  end
  if ! test -z $argv[1]
    echo $argv[1]
  end
  for entry in (ls $all)
    if test -d "$entry"
      switch $entry
        case Videos
          echo "辶   $entry"
        case Music
          echo "   $entry"
        case Audiobooks
          echo "   $entry"
        case Pictures
          echo "   $entry"
        case Downloads
          echo "   $entry"
        case Documents
          echo "   $entry"
        case *
          echo "   $entry"
      end

    else
      switch $entry
        case '*.sh'
          echo "   $entry"
        case '*.'{md,txt,log}
          echo "   $entry"
        case '*.'{png,jpg,svg,webp,gif}
          echo "   $entry"
        case '*.fish'
          echo "   $entry"
        case '*.rs'
          echo "   $entry"
        case '*.js'
          echo "   $entry"
        case '*.py'
          echo "   $entry"
        case '*.'{c,h}
          echo "   $entry"
        case '*.go'
          echo "   $entry"
        case '*.pdf'
          echo "   $entry"
        case '*.'{mp4,mkv}
          echo "辶   $entry"
        case '*.'{mp3,m4a}
          echo "   $entry"
        case '*.'{tar,zip}
          echo "遲    $entry"
        case '*'
          echo "   $entry"
      end
    end
  end
end

function prompt
  if ! test -f $argv[1]
    set -l name (echo $argv[1] | sed "s|//|/|")
    echo "   Open directory in ranger"
    echo "   Copy "(pwd)
    echo "   Move "(pwd)
    echo "   Delete "(pwd)
  else
    echo "   Launch $argv[1]"
    switch ( echo $argv[1] | sed 's/.*\.//' )
      case png jpeg jpg gif mp4 webp svg
        echo "   Upload $argv[1] to imgur"
      case zip tar.gz
        echo "遲   Extract $argv[1]"
    end
    echo "   Edit $argv[1] in $EDITOR"
    echo "   Send $argv[1] with KDE Connect"
	  echo "  Execute $argv[1]"
    echo "   Copy $argv[1]"
    echo "   Move $argv[1]"
    echo "   Upload $argv[1] to gofile.io"
    echo "   Rename $argv[1]"
    echo "   Delete $argv[1]"
  end
end

function menu --description "file/folder menu options"
  set -l OPTION ( prompt "$argv[1]"\
  			| wofi -i -c ~/wofer/config | sed 's|^[^a-zA-Z0-9]*||' );
  set LOC ''
  if test -d $argv[1]
    set LOC (pwd)
    set d "-r"
  else
    set LOC $argv[1]
  end
  switch (echo "$OPTION" | sed 's/ .*//')
    case Execute
      ./$LOC
      exit
    case Edit
      alacritty -e fish -c "vim $LOC" &
      exit
    case Launch
      launcher "$LOC"
    case Open
      alacritty -e ranger "$LOC" &
      exit
    case Send
      $EXTENSIONS/kdeconnect "$LOC"
    case Copy
      set -l OBJECT (pwd)"/$LOC"
      set -l DESTINATION (wofer -c)
      cp $d "$OBJECT" "$DESTINATION" 
    case Move
      set -l OBJECT (pwd)"/$LOC"
      set -l DESTINATION (wofer -m)
      mv "$OBJECT" "$DESTINATION" 
      cd "$DESTINATION"
    case Rename
      mv "$LOC" (echo   Enter the new name | wofi -c ~/wofer/config)
    case Upload
      if contains imgur $OPTION
        $EXTENSIONS/imgur "$LOC"
        set -l image (pwd)/$LOC
        notify-send 'Uploaded to imgur' (wl-paste) -i "$image"
      else
        gofile "$LOC"
      end
    case Extract
      set -l DESTINATION (wofer -e)
      if unzip -q "$LOC" -d "$DESTINATION"
        :
      else
        tar xzf "$LOC" -C "$DESTINATION"
      end
    case Delete
      rm $d -f "$LOC"
    end
end

function launcher --description 'apps shortcuts'
  switch ( echo "$argv[1]" | sed 's/.*\.//' )
    case jpg jpeg png webp svg gif
      imv "$argv[1]" &
    case md
      export PATH="$HOME/.cargo/bin:$PATH"
      alacritty -e nvim "$argv[1]" -c Illuminate &
    case pdf
      zathura -c ~/.config/zathura/ "$argv[1]" &
    case '*'
      xdg-open "$argv[1]"
    end
  exit
end

function shortcuts
  switch $argv[1]
    case '?' :
      menu 
    case ':help'
      xdg-open https://gitlab.com/snakedye/wofer
    case :h :hidden
      if $SHOW_HIDDEN
        set SHOW_HIDDEN false
      else
        set SHOW_HIDDEN true
      end
    case ':sway'
      cd ~/.config/sway
    case ':waybar'
      cd ~/.config/waybar
    case ':fish'
      cd ~/.config/fish/functions
    case ':sc'
      cd ~/School
    case !delete
      rm -r "(pwd)"
    case :m
      $EXTENSIONS/manga
      # manga_menu
      exit
    case '*'
      if echo $argv[1] | grep '?.*'
        set -l query ( echo "$argv[1]" | grep -o '[^?].*' )
        set -l finder ( fd $query | wofi -i -c ~/wofer/config )
        if ! cd $finder
          menu "$finder"
        end
      else if contains / "$argv[1]"
        cd $argv[1]
      else
        set -l finder (fd $argv[1] | head -1)
        if ! cd "$finder"
          menu "$finder"
      end
    end
  end
end

function wofer --description 'loops wofi'
  switch $argv
    case -c
      set action "Copy Here"
    case -e
      set action "Extract here"
    case -m
      set action "Move Here"
  end
  while true
    set stdout (lsi $action | wofi -i -m -c ~/wofer/config | sed 's|^~|/home/bryan|')
    set ENTRY (echo "$stdout" | grep -o " .*" | sed "s| *||")
    if test -z $stdout
      break
    else if test -f "$ENTRY"
      menu "$ENTRY"
    else if test -f "$stdout"
      menu "$stdout"
    else if test -d "$stdout"
      cd "$stdout"
    else if test -d "$ENTRY"
      cd "$ENTRY"
    else if contains $action $stdout
      echo (pwd)
      break
    else if test '..'=$ENTRY
      cd ..
    else
      shortcuts $stdout
    end
  end
end
