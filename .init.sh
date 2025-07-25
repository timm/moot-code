# Absolute path to this script (e.g., x/sh/dotbashrc)
Here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
Xdir="$(basename "$(dirname "$Here")")"  # bold "x" marker from enclosing folder

# Silence macOS deprecation warnings
export BASH_SILENCE_DEPRECATION_WARNING=1

# Add custom scripts to PATH
export PATH="$Here:$PATH"

# Styling: colors and bold
bold=$(tput bold)
col0=$(tput sgr0)
col1=$(tput setaf 6)  # cyan
col2=$(tput setaf 3)  # yellow
col3=$(tput setaf 2)  # green

# Prompt Git branch (if any)
branch() {
  git branch 2>/dev/null | awk '/^\*/ {print $2}'
}

# 🧠 Dynamic, colored prompt with bold "x" marker, parent/current dir, and Git branch
PROMPT_COMMAND='
  pdir=$(basename "$(dirname "$PWD")")
  cdir=$(basename "$PWD")
  gbr=$(branch)
  PS1="👀 ${bold}${col1}${Xdir}${col0} ${col1}${pdir}/${bold}${cdir}${col0} ${col2}${gbr}${col0} ▶ "
'

# Aliases: directory nav
alias ..='cd ..'
alias ...='cd ../../../'
alias c='clear'
alias q='exit'

# Aliases: ls enhancements
alias ls='ls -G'
alias l='ls -lh'
alias la='ls -la'
alias t='tree -L 1'

# Aliases: Git shortcuts
alias gs='git status -sb'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph --all --decorate'

# Aliases: misc
alias h='history'
alias v="nvim -u '$Here/.nvimrc.lua'"  # Load custom Neovim config

# ⌨️ QoL: quick edit .dotbashrc and reload
alias reload="source '$Here/dotbashrc' && echo ✅ dotbashrc reloaded"
