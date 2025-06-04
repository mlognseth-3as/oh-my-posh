plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
	globalias
)

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

source $ZSH/oh-my-zsh.sh

if command -v fzf &>/dev/null; then
  source <(fzf --zsh)
fi

GLOBALIAS_FILTER_VALUES=(
    grep
    ls
)

alias finder-relaunch='launchctl kickstart -k gui/$(id -u)/com.apple.Finder'

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/ml/.lmstudio/bin"
# End of LM Studio CLI section

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
    eval "$(oh-my-posh init zsh --config ~/zen.toml)"
fi
