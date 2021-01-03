function playerstatus --description "player status"
  set mpris_status (playerctl status)
  set text $mpd_status
  set tooltip "mpd - playing"
  set text (playerctl metadata title)
  set tooltip (playerctl metadata --format "{{ playerName }} : {{ title }}")
  echo '{"text": "'"$text"'", "alt": "'"$mpris_status"'", "tooltip": "'"$tooltip"'", "class": "'"$mpris_status"'" }'
end
