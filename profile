. ~/.share.d/bash/profile
if [[ $- = *i* ]]; then
    . ~/.share.d/bash/interactive
fi

[ -f ~/.bashrc ] && source ~/.bashrc
