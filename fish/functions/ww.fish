# Wofer with fzf

function ww
  # if not test -e /tmp/last_dir
    # touch /tmp/last_dir
  # end
  clear
  wofer ~/wofer/extensions/fzf -c ~/.config/wofer/fuzzy
  # cd (cat /tmp/last_dir)
end
