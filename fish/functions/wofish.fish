# Wofi file browser

set SHOW_HIDDEN false
# set -Ux EXEC wofi -c ~/.config/wofi/wofer

function lsi --description "ls with icons"
  echo "   .."
  if $SHOW_HIDDEN
    set all -A
  end
  if test $argv!=''
    echo "$argv here"
  end
  if ! test -z $argv[1]
    echo $argv[1]
  end
  for entry in (ls $all)
    if test -d "$entry"
      switch $entry
        case Videos
          echo "辶  $entry"
        case Music
          echo "   $entry"
        case Audiobooks
          echo "   $entry"
        case Pictures
          echo "   $entry"
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
          echo "   $entry"
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
    echo "   Delete "(pwd)
  else
    echo "   Launch $argv[1]"
    switch $argv[1]
      case '*.'{png,jpeg,jpg,gif,webp,svg}
        if test (pwd)=$HOME/wallpapers
          echo "   Set $argv[1] as wallpaper"
        else
          echo "   Upload $argv[1] to imgur"
        end
      case '*.'{zip,tar.gz}
        echo "遲   Extract $argv[1]"
    end
    echo "   Edit $argv[1] in $EDITOR"
    echo "   Send $argv[1] with KDE Connect"
	  echo "  Execute $argv[1]"
    echo "   Copy $argv[1]"
    echo "   Move $argv[1]"
    echo "   Upload $argv[1] to gofile.io"
    echo "   Rename $argv[1]"
    echo "   Move to trash $argv[1]"
    echo "   Delete $argv[1]"
  end
end

function extension
  ~/wofer/extensions/$argv[1] $argv[2]
end

function menu --description "file/folder menu options"
  set LOC ''
  if test -d $argv[1]
    set -l OPTION ( prompt "$argv[1]" | wofi -c ~/.config/wofi/wofer | tail -1 );
    set LOC $PWD
    set d "-r"
  else if test -f $argv[1]
    set -l OPTION ( prompt "$argv[1]" | wofi -c ~/.config/wofi/wofer | tail -1 );
    set LOC $argv[1]
  else if test -n $argv
    set OPTION $argv[1]
    set LOC $argv[2]
  end
  switch (string sub -s 5 $OPTION)
    case Execute'*'
      ./$LOC
      exit
    case Edit'*'
      foot fish -c "vim $LOC" &
      exit
    case Launch'*'
      launcher "$LOC"
    case Open'*'
      foot ranger "$LOC" &
      exit
    case Send'*'
      extension kdeconnect "$LOC"
    case Copy'*' cp
      set -l OBJECT "$PWD/$LOC"
      set -l DESTINATION (runner Copy)
      cp $d "$OBJECT" "$DESTINATION" 
    case Set'*'
      pkill swaybg
      swaybg -o 'HDMI-A-1' -i "$LOC" -m fill &
    case 'Move to trash*'
      mv "$LOC" ~/.local/share/Trash/files/
    case Move'*'
      set -l OBJECT "$PWD/$LOC"
      set -l DESTINATION (runner Move)
      mv "$OBJECT" "$DESTINATION" 
      cd "$DESTINATION"
    case Rename'*'
      mv "$LOC" (echo   Enter the new name | wofi -c ~/.config/wofi/wofer)
    case Upload'*'
      if string match -rq 'imgur' $OPTION
        extension imgur "$LOC"
        set -l image "$PWD/$LOC"
        notify-send 'Uploaded to imgur' (wl-paste) -i "$image"
      else
        gofile "$LOC"
      end
    case Extract'*'
      set -l DESTINATION (runner Extract)
      if unzip -q "$LOC" -d "$DESTINATION"
        :
      else
        tar xzf "$LOC" -C "$DESTINATION"
      end
    case Delete'*'
      rm $d -f "$LOC"
    end
end

function launcher --description 'apps shortcuts'
  switch ( echo "$argv[1]" | sed 's/.*\.//' )
    case jpg jpeg png webp svg gif
      imv "$argv[1]" &
    case md
      export PATH="$HOME/.cargo/bin:$PATH"
      alacritty -e nvim $argv[1] -c Illuminate &
    case pdf
      zathura -c ~/.config/zathura/ "$argv[1]" &
    case '*'
      xdg-open "$argv[1]"
    end
  exit
end

function shortcuts
  switch $argv[1]
    case 'ZZ'
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
    case ':wall'
      cd ~/wallpapers
    case !delete
      rm -r "(pwd)"
    case :m
      extension manga
      exit
    case '*'
      if string match -rq '^[?].*' $argv[1]
        set -l query string sub -s 1 "$argv[1]"
        set -l finder ( fd $query | wofi -c ~/.config/wofi/wofer )
        if test -d $finder
          cd "$finder"
        else
          menu "$finder"
        end
      else if string match -rq '^/.*' $argv[1]
        cd $argv[1]
      else if string match -rq '~/.*' $argv[1] # a corriger
        set dir (string replace '~' $HOME $argv[1])
        cd $dir
      else if test -n $argv
        menu $argv
      end
  end
end

function runner
  while true
    set stdout (lsi $argv | wofi -c ~/.config/wofi/wofer)
    set ENTRY (echo "$stdout" | sed 's/.[ ]*//')
    if test -z $stdout
      break
    else if test -f "$ENTRY"
      menu "$ENTRY"
    else if test -f "$stdout"
      menu "$stdout"
    else if test -d "$stdout" || string match -rq '^[~]/.*' $stdout
      switch $stdout
        case /'*'
          cd "$stdout"
        case ~'*'
          set dir (string replace '~' $HOME/$stdout)
          cd $dir
      end
    else if test -d "$ENTRY"
      cd "$ENTRY"
      echo $ENTRY
    else if string match '.* here' "$stdout"
      echo $PWD
      break
    else if string match '\.\.' $ENTRY
      cd ..
    else
      shortcuts $stdout
    end
  end
end

function wofish
  runner
end
