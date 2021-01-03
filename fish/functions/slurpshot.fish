function slurpshot
  switch $argv
    case -f
      grim - | swappy -f -
    case -g
      set -l geometry (swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | slurp)
      grim -g $geometry - | swappy -f -
    end
end
