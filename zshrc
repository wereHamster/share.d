export ZSH=$HOME/src/share.d/zsh

# Source every .zsh file in this repo.
for config_file ($ZSH/**/*.zsh) source $config_file

# Initialize autocomplete here, otherwise functions won't be loaded.
autoload -U compinit
compinit

# Load every completion after autocomplete loads.
for config_file ($ZSH/**/completion.zsh) source $config_file

[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh
