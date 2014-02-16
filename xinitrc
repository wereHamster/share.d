xmodmap ~/.Xmodmap

xrdb -merge ~/.Xresources
urxvtd -q -o -f

feh --bg-fill ~/.artwork/Mbvj8J5.jpg

$HOME/.bin/redshift -r -l 46.813187:8.22421 -t 6500:3700 &

exec xmonad
