# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export PATH=/opt/homebrew/bin:$PATH
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/mysql@5.7/bin:$PATH"

export LOCAL_SCRIPTS_PATH=~/dev/.scripts

ZSH_THEME="caedan"

plugins=(
	git
	macos
	zsh-interactive-cd
	zsh-syntax-highlighting
	zsh-autosuggestions
    )

source $ZSH/oh-my-zsh.sh


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
alias vz='v ~/.zshrc'
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
# Terraform
alias tv='terraform -v'
alias tlts='switchTerraformVersion lts'
alias t11='switchTerraformVersion 11'
alias t12='switchTerraformVersion 12'
alias tout='terraform plan -out plan'
alias tap='terraform apply plan'

function switchTerraformVersion() {
    local target_version=$1
    local path_to_terraform='/usr/local/bin/'
    sudo ln -sf "$path_to_terraform"terraform_"$target_version" "$path_to_terraform"terraform
}

function decodeError() {
    echo "Enter encoded string:"
    read encodedString
    aws sts decode-authorization-message --encoded-message $encodedString | jq .context.action
}

# AWS
alias awsprofiles='cat ~/.aws/credentials_*'
alias asich=switchAWSProfile
alias decodeError='decodeError'
function setAWSProfile() {
   local newProfile=$1
   export AWS_PROFILE=$1
   echo "AWS Profile is now "$AWS_PROFILE
}

function switchAWSProfile() {
   "$LOCAL_SCRIPTS_PATH"/aws__switch-profile.sh
}

alias whichaws=whichAWSProfile
function whichAWSProfile() {
   echo $AWS_PROFILE
}

alias build-latest-schema="bash ~/dev/.scripts/cw-get-prod-schema.sh"
alias build-latest-dump="bash ~/dev/.scripts/cw-get-prod.sh"

# Bun completions
[ -s "/Users/caedan/.bun/_bun" ] && source "/Users/caedan/.bun/_bun"

# Bun
export BUN_INSTALL="/Users/caedan/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
