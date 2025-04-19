# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/rd/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall

########### NOTE: Plugins ############
# enable zoxide
eval "$(zoxide init zsh)"
# load powerlevel10k
source ~/.zsh/zsh-plugins/powerlevel10k/powerlevel10k.zsh-theme
# load zsh-syntax-highlighting
source ~/.zsh/zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# load zsh-autosuggestions
source ~/.zsh/zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# make ctrl + space complete the suggestions
bindkey '^ ' autosuggest-accept


########### NOTE: Aliases ############
alias ll='ls -lAh --color=auto'
alias rm='rm -i'
alias mv='mv -i'
alias connectbt='~/personal/scripts/connectbt.sh';
alias cscrcpy='scrcpy --shortcut-mod=lalt,ralt -w --no-audio;sleep 2 && adbunlock';
alias restartwaybar='killall -SIGUSR2 waybar';
#alias avm='emulator -avd android10 -cores 2 -no-snapshot-save -no-snapshot-load -no-boot-anim -no-metrics -no-audio -camera-back none -camera-back none -gpu host'
alias pixel='QT_QPA_PLATFORM=xcb;emulator -avd android10 -gpu host -no-boot-anim -no-metrics -no-audio -camera-back none -camera-back none'
alias nexus='QT_QPA_PLATFORM=xcb;emulator -avd nexus6a10 -gpu host -no-boot-anim -no-metrics -no-audio -camera-back none -camera-back none'
alias nexus6a7='QT_QPA_PLATFORM=xcb;emulator -avd nexus6a7 -gpu host -no-boot-anim -no-metrics -no-audio -camera-back none -camera-back none'

########### NOTE: Exports ############
export TERM=xterm-256color ssh
export LIBVA_DRIVER_NAME=i965;
export GTK_THEME="Adwaita-dark";
export NVM_DIR="$HOME/.nvm"
export EDITOR="nvim"
# android avd
#export ANDROID_HOME=~/Android/Sdk
# use wayland or fallback to xwayland
# export QT_QPA_PLATFORM="wayland";"xcb"
#export PATH=$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

########### NOTE Proxy ##################
#export HTTP_PROXY=http://192.168.134.11:8089
#export HTTPS_PROXY=http://192.168.134.11:8089
#export NO_PROXY=localhost,127.0.0.1,.perplexity.ai,.figma.com,.sanet.lc,.openai.com,.chatgpt.com,.penpot.app,.glassdoor.co.in,groww.in,.tutflix.org
#unset HTTP_PROXY;
#unset HTTPS_PROXY;


# Created by `pipx` on 2024-09-15 16:54:48
export PATH="$PATH:/home/rd/.local/bin"
export PATH="$PATH:$HOME/go/bin"


# print out tl.txt if it is not empty
# if [ -s /home/rd/tl.txt ]; then
#   echo "pending TL";
# fi;
# # create alias to view pending tasks
alias pt="nvim ~/tl.txt"

