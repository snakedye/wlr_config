function header -d 'message header can be whatever'
  set -l block (set_color cyan) 'ʕっ•ᴥ•ʔっ hello'
  echo -ne $block\n
end

function footer -d 'message footer can be whatever'
  set -l block (set_color cyan) 'ʕノ)ᴥ(ヾʔ goodbye'
  echo -ne $block\n
end

function seperator
  set -l block (set_color purple) '~ '
  echo $block
end

function display_host
  set -l host (cat /etc/hostname)
  set -l title_block '  '(set_color blue) host
  set -l text_block (set_color yellow) snakedye
  echo -ne $title_block '      ' (seperator) $text_block \n
end

function display_compositor
  set -l title_block '  '(set_color blue) compositor
  set -l text_block (set_color yellow) $XDG_CURRENT_DESKTOP
  echo -ne $title_block '' (seperator) $text_block \n
end

function display_kernel
  set -l kernel (uname -sr | sed 's/-.*//' )
  set -l title_block '  '(set_color blue) kernel
  set -l text_block (set_color yellow) $kernel
  echo -ne $title_block '    ' (seperator) $text_block \n
end

function display_term
  set -l title_block '  '(set_color blue) term
  set -l text_block (set_color yellow) $TERM
  echo -ne $title_block '      ' (seperator) $text_block \n
end

function display_packages
  set -l packages (pacman -Q | wc -l)
  set -l title_block '  '(set_color blue) packages
  set -l text_block (set_color yellow) $packages
  echo -ne $title_block '  ' (seperator) $text_block \n
end

function display_uptime
  set -l uptime (uptime -p | sed 's/[a-z]*[,]*//g')
  set -l days (echo $uptime | awk '{print $1}')
  set -l hours (echo $uptime | awk '{print $2}')
  set -l minutes (echo $uptime | awk '{print $3}')
  set -l title_block '  '(set_color blue) uptime
  if test -z $minutes
    set text_block (set_color yellow) $days'd' 00:$hours
  else
    set text_block (set_color yellow) $days'd' $hours:$minutes
  end
  echo -ne $title_block '    ' (seperator) $text_block \n
end

function fetch --description 'custom fetch'
  header
  echo ""
  display_host
  display_compositor
  display_kernel
  display_uptime
  display_packages
  display_term
  footer
  echo ""
end
