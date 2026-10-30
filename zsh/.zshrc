# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

########### NOTE: Core Options ############
typeset -U PATH                 # deduplicate PATH entries automatically

bindkey -v
KEYTIMEOUT=1                    # fix vi-mode escape lag (default is 400ms)

setopt AUTO_CD                  # type a directory name to cd into it
#setopt CORRECT                  # suggest corrections for mistyped commands
setopt NO_BEEP
setopt EXTENDED_GLOB            # enables #, ^, ~ glob operators
setopt GLOB_DOTS                # globs match dotfiles without explicit dot

########### NOTE: History ############
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_IGNORE_DUPS         # skip consecutive duplicate entries
setopt HIST_IGNORE_SPACE        # lines starting with space are not saved (useful for secrets)
setopt HIST_VERIFY              # show expanded history line before executing
setopt HIST_REDUCE_BLANKS       # strip extra whitespace before saving
setopt SHARE_HISTORY            # share history across all open sessions in real time
setopt EXTENDED_HISTORY         # save timestamps: `: timestamp:elapsed;command`

########### NOTE: Completion ############
zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
# only regenerate the completion dump file once per day (faster startup)
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

########### NOTE: Exports ############
export EDITOR="nvim"
export NVM_DIR="$HOME/.nvm"
# android avd
#export ANDROID_HOME=~/Android/Sdk
# handling GTK theme in env.conf hyprland now, no need to do it here
#export GTK_THEME="Adwaita-dark"
# use wayland or fallback to xwayland
#export QT_QPA_PLATFORM="wayland;xcb"
#export PATH=$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools

########### NOTE: PATH ############
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/sync/code/bash/inpath"
export PATH="$PATH:$HOME/go/bin"

########### NOTE: NVM ############
# lazy-loaded so it doesn't slow down shell startup (~200-500ms savings)
#nvm()  { unset -f nvm node npm npx; [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"; [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"; nvm "$@"; }
#node() { nvm; node "$@"; }
#npm()  { nvm; npm  "$@"; }
#npx()  { nvm; npx  "$@"; }
########### NOTE: NVM ############
# lazy-loaded so it doesn't slow down shell startup (~200-500ms savings)
_load_nvm() {
  unset -f nvm node npm npx _load_nvm
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
}

nvm()  { _load_nvm; nvm "$@"; }
node() { _load_nvm; node "$@"; }
npm()  { _load_nvm; npm "$@"; }
npx()  { _load_nvm; npx "$@"; }

########### NOTE: Plugins ############
# enable zoxide — using --cmd cd replaces cd itself so muscle memory still works
eval "$(zoxide init zsh --cmd cd)"
# load powerlevel10k
source ~/.zsh/zsh-plugins/powerlevel10k/powerlevel10k.zsh-theme
# load zsh-autosuggestions
source ~/.zsh/zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# zsh-syntax-highlighting must be sourced last
source ~/.zsh/zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

########### NOTE: Keybindings ############
# make ctrl + space complete the autosuggestion
bindkey '^ ' autosuggest-accept
# make ctrl + p and ctrl + n cycle through history
bindkey '^P' up-history
bindkey '^N' down-history

########### NOTE: Aliases ############
# use eza (modern ls replacement with git info + icons) if available, fallback to ls
if command -v eza &>/dev/null; then
  alias ll='eza -lah --icons --git'
  alias lt='eza --tree --icons -L 2'
else
  alias ll='ls -lAh --color=auto'
fi
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias pt="nvim ~/tl.txt"
alias restartwaybar='killall -SIGUSR2 waybar'
alias connectbt='~/personal/scripts/connectbt.sh'
alias cscrcpy='scrcpy --shortcut-mod=lalt,ralt -w --no-audio; sleep 2 && adbunlock'
#alias avm='emulator -avd android10 -cores 2 -no-snapshot-save -no-snapshot-load -no-boot-anim -no-metrics -no-audio -camera-back none -gpu host'
alias pixel='QT_QPA_PLATFORM=xcb emulator -avd android10 -gpu host -no-boot-anim -no-metrics -no-audio -camera-back none'
alias nexus='QT_QPA_PLATFORM=xcb emulator -avd nexus6a10 -gpu host -no-boot-anim -no-metrics -no-audio -camera-back none'
alias nexus6a7='QT_QPA_PLATFORM=xcb emulator -avd nexus6a7 -gpu host -no-boot-anim -no-metrics -no-audio -camera-back none'

########### NOTE: Proxy ############
#export HTTP_PROXY=http://192.168.134.11:8089
#export HTTPS_PROXY=http://192.168.134.11:8089
#export NO_PROXY=localhost,127.0.0.1,.perplexity.ai,.figma.com,.sanet.lc,.openai.com,.chatgpt.com,.penpot.app,.glassdoor.co.in,groww.in,.tutflix.org
#unset HTTP_PROXY
#unset HTTPS_PROXY

########### NOTE: Completion Ignores ############
# ignore these extensions when tab-completing
fignore=(.class .o .a .so .dylib .out .pyc .pyo .elc .swp .swo .DS_Store)

# claude limit for non claude models
export CLAUDE_CODE_MAX_CONTEXT_TOKENS=1,048,576;
