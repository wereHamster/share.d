xmodmap ~/.Xmodmap

xrdb -merge ~/.Xresources
urxvtd -q -o -f

# feh --bg-fill ~/.artwork/ACraLcw.jpg
feh --bg-fill ~/.artwork/Pps56Zk.jpg

$HOME/.bin/redshift -r -l 46.813187:8.22421 -t 6500:3700 &

exec $HOME/.xmonad/xmonad-x86_64-linux
