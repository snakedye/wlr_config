function playerstatus --description "player status"
  set mpd_status (mpc current --host 127.0.0.1 --port 6002)
  set mpris_status (playerctl status)
  if test $mpd_status!=""
    set text $mpd_status
    set tooltip "mpd - playing"
    set mpris_status "Music"
  else if test $mpris_status!="No players found"
    set text (playerctl metadata title)
    set tooltip (playerctl metadata --format "{{ playerName }} : {{ title }}")
  end
    echo '{"text": "'"$text"'", "alt": "'"$mpris_status"'", "tooltip": "'"$tooltip"'", "class": "'"$mpris_status"'" }'
end
