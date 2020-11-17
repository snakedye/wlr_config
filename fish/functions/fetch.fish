function fetch --description 'custom fetch'
  set -l host (cat /etc/hostname)
  set -l os 'Arch Linux'
  set -l kernel (uname -sr)
  set -l compositor (echo $XDG_CURRENT_DESKTOP)
  set -l uptime (uptime -p | sed 's/up //')
  set -l packages (pacman -Q | wc -l)
  set -l shell (basename "$SHELL")

  printf "
    $host (UwU)
   $os
   $compositor
   $shell
   $kernel
   $packages
   $uptime"
end
