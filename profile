
for m in ~/.share.d/bash/profile/*; do
    . "$m"
done

# Interactive shell, load the appropriate file
if [[ $- = *i* ]] ; then
    for m in ~/.share.d/bash/interactive/*; do
        . "$m"
    done
fi

PATH=$HOME/.cabal/bin:$HOME/.hsenv/bin:$PATH
export PATH

[ -f ~/.bashrc ]         && source ~/.bashrc
[ -f ~/.local/z/z.sh ]   && source ~/.local/z/z.sh
[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh
[ -d ~/.hsenv ]          && eval "$(~/.hsenv/bin/hsenv init -)"
