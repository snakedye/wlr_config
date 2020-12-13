function recording --description 'stop button for wf-recorder'
  if pgrep wf-recorder
    kill -INT (pgrep wf-recorder)
  else
    wf-recorder -f ~/Videos/(date +recording_%Y-%m-%d-%H%M%S.mp4) -g (slurp)
    notify-send "Recording saved" ~/Videos/(date +recording_%Y-%m-%d-%H%M%S.mp4) -i video
  end
end
