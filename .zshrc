export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME="robbyrussell"

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
export PATH="$HOME/Library/Python/3.13/bin:$PATH"
export PATH="$PATH:$HOME/.lmstudio/bin"

# Plugin Setup
plugins=(
  git
  kubectl
  terraform
  zsh-autosuggestions
  zsh-syntax-highlighting
  globalias
  kube-ps1
  azure
)

# Load Oh My Zsh
source "$ZSH/oh-my-zsh.sh"

# Enable completion
autoload -Uz compinit && compinit

# fzf integration (if installed)
if command -v fzf &>/dev/null; then
  source <(fzf --zsh)
fi

# Custom completions
fpath=(~/.zsh/completions $fpath)
for f in ~/.zsh/completions/*.zsh; do
  source "$f"
done

# Docker & ASDF completions
fpath=("$HOME/.docker/completions" "${ASDF_DATA_DIR:-$HOME/.asdf}/completions" $fpath)

# Only run oh-my-posh outside Apple Terminal
# if [[ "$TERM_PROGRAM" != "Apple_Terminal" ]]; then
#   eval "$(oh-my-posh init zsh --config ~/.zen.toml)"
# fi

# Lazy-load kubectl completion
if command -v kubectl &>/dev/null; then
  kubectl() {
    unfunction kubectl
    source <(command kubectl completion zsh)
    command kubectl "$@"
  }
fi

# Aliases
alias ls="ls --color"
alias c="clear"
alias g="git"
alias gfuck="git reset --soft HEAD~"
alias ks="kubens"
alias myip="curl -s https://ipv4.wtfismyip.com/json | jq '.YourFuckingIPAddress'"
alias aws-profiles="grep -o '\[[^]]*\]' ~/.aws/credentials"
alias kx="kubectx"
alias azc="az account set -s"
alias azl="az account list -o table"
alias grep="\grep"  # preserve GNU grep for alias
alias ax="azctx"
alias kux="kubie ctx"
alias az-ihk="az login --tenant 2c3bd968-e2a6-469f-87e6-36a92b2b4ce0"
alias debug-pod="kubectl run debug-pod-lognseth -i --tty --image busybox:latest"
alias attach-debug-pod="kubectl attach debug-pod-lognseth -c debug-pod -i -t"
alias ghc="gh copilot"

# Globalias filter
GLOBALIAS_FILTER_VALUES=(grep ls)

if [[ "$TERM_PROGRAM" != "Apple_Terminal" ]]; then
  eval "$(oh-my-posh init zsh --config ~/.zen.toml)"
fi
