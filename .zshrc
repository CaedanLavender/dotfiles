# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export PATH=/opt/homebrew/bin:$PATH
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/mysql@5.7/bin:$PATH"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

ZSH_THEME="caedan"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	macos
	zsh-interactive-cd
	zsh-syntax-highlighting
	zsh-autosuggestions
	)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


export FZF_DEFAULT_OPTS='--layout=reverse --border --multi --ansi --exit-0'
function ghq-list-then-look
{
  local ghq_root=$(ghq root)
  local selected=$(ghq list \
    | fzf --height 90% \
    --preview='find $(ghq root)/{} -depth 1 -type f | grep -i -e "readme.[(md)|(mkd)|(markdown)]" | head -1 | xargs head -$LINES' \
        --preview-window down \
        --color='hl+:green:italic,hl:green:italic,fg+:,bg+:' \
        --color='pointer:blue,gutter:-1,header:blue:bold,prompt:green:bold,info:gray' \
        --header "GHQ List")

  if [ -n "${selected}" ]; then
    clear
    cd "${ghq_root}/${selected}"
  fi
}

function ghq-list-then-open-in-browser
{
  local ghq_root=$(ghq root)
  local selected=$(ghq list \
    | fzf --height 90% \
    --preview='find $(ghq root)/{} -depth 1 -type f | grep -i -e "readme.[(md)|(mkd)|(markdown)]" | head -1 | xargs head -$LINES' \
        --preview-window down \
        --color='hl+:green:italic,hl:green:italic,fg+:,bg+:' \
        --color='pointer:blue,gutter:-1,header:blue:bold,prompt:green:bold,info:gray' \
        --header "GHQ List")

  if [ -n "${selected}" ]; then
    clear
    local path_to_git_directory="${ghq_root}/${selected}"
    local remote_url=$(git -C ${path_to_git_directory} config --get remote.origin.url)
    local pattern=".+:\/\/.+@(.+)\.git"
    local git_url=$([[ $remote_url =~ $pattern ]] && echo "${match[1]}")
    open http://$git_url
  fi
}

# bindkey -v

# RUNS NEOFETCH AUTOMATICALLY IN GIT REPOSITORIES
#LAST_REPO=""

#cd() {
#	builtin cd "$@"
#	git rev-parse 2>/dev/null
#
#	if [ $? -eq 0 ]; then
#		if [ "$LAST_REPO" != $(basename $(git rev-parse --show-toplevel)) ]; then
#			onefetch --show-logo never --text-colors 9 --image ~/cowboy_bebop.jpg
#			LAST_REPO=$(basename $(git rev-parse --show-toplevel))
#		fi
#	fi
#}

# ===============================================

# GENERAL
alias root='cd /'
alias user='cd ~'
alias drive="cd '/Users/caedan/GD-Personal'"
alias dirc='pwd | pbcopy && echo Working directory was copied to the clipboard'
alias fn='copyFileName'

function copyFileName() {
#   echo "Pattern:"
#   read filename
   filename=$1
   echo "Copying: $(ls ${filename}*)"
   eval $(ls ${filename}* | pbcopy)
}
# VIM
alias v='nvim'

# DOTFILES
alias vimrc='vim ~/.vimrc'
alias vimz='vim ~/.zshrc'
alias config='cd ~/.config/'
alias rz='zsh'

# EXA
alias lsl='exa -la  --git --no-user --group-directories-first'
alias lss='exa -l  --git --no-user --group-directories-first'
alias lst='exa -la --git --no-user --group-directories-first -T -L 2'

# CODE
alias c='code .'

# DOCKER
alias dprune='docker system prune -f'

# GIT
alias g='ghq-list-then-look'
alias ggg='ghq-list-then-open-in-browser'
alias guii='gitui'
alias gad='git add .'
alias gush='git push'
alias gall='git pull --all'
alias gat='git status'
alias gich='git switch -'
alias groom='git remote prune origin'
alias gim='gitCommit'

function gitCommit() {
   echo "Commit message:"
   read commitMessage
   echo "Commit message body:"
   read commitExtraMessage
   gitCommand="git commit -m \"${commitMessage}\" $([[ ! -z $commitExtraMessage ]] && echo "-m \"${commitExtraMessage}\"")"
   eval $gitCommand
}

# AWS
alias awsp='setAWSProfile production'
alias awsd='setAWSProfile developer'
alias awsr='setAWSProfile root'
alias awsprofiles='cat ~/.aws/credentials'
alias asich=switchAWSProfile

function setAWSProfile() {
   local newProfile=$1
   export AWS_PROFILE=$1
   echo "AWS Profile is now "$AWS_PROFILE
}

function switchAWSProfile() {
   if [ "$AWS_PROFILE" = "developer" ]
      then
      export AWS_PROFILE=production
   elif [ "$AWS_PROFILE" = "production" ]
      then
      export AWS_PROFILE=developer
   else
      AWS_PROFILE=developer
      echo "AWS Profile was unset, now using: "$AWS_PROFILE
      return 1
   fi
   echo "Now using AWS Profile: "$AWS_PROFILE
}

alias wicha=whichAWSProfile
function whichAWSProfile() {
   echo $AWS_PROFILE
}

alias build-latest-schema="bash ~/dev/.scripts/cw-get-prod-schema.sh"
alias build-latest-dump="bash ~/dev/.scripts/cw-get-prod.sh"

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# bun completions
[ -s "/Users/caedan/.bun/_bun" ] && source "/Users/caedan/.bun/_bun"

# Bun
export BUN_INSTALL="/Users/caedan/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
