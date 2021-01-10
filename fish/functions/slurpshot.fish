function slurpshot
  switch $argv
    case -f
      grim - | swappy -f -
    case -g
      set -l geometry (swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | slurp)
      if string match -r $geometry "[0-9]+.*" $geometry
        grim -g $geometry - | swappy -f -
      else
        grim -o (printf "HDMI-A-1\nDP-2" | wofi --dmenu -L 2) - | swappy -f -
      end
    case -wf
      set -l geometry (swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | slurp)
      if string match -r $geometry "[0-9]+.*" $geometry
        wf-recorder -f ~/Videos/(date +recording_%Y-%m-%d-%H%M%S.mp4) -g $geometry
      else
        wf-recorder -f ~/Videos/(date +recording_%Y-%m-%d-%H%M%S.mp4) -o (printf "HDMI-A-1\nDP-2" | wofi --dmenu -L 2)
      end
      notify-send "Recording saved" ~/Videos/(date +recording_%Y-%m-%d-%H%M%S.mp4) -i video
    end
end
