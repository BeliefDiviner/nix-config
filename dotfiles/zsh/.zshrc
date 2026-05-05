# SSH keychain.
if [[ $(uname) == "Darwin" ]]; then
    $(brew --prefix)/bin/keychain --quiet ~/.ssh/git-private ~/.ssh/git-forgood ~/.ssh/google_compute_engine
elif [[ $(uname -r | grep "WSL") ]]; then
    /usr/bin/keychain --quiet ~/.ssh/git-private ~/.ssh/git-forgood
fi
source ~/.keychain/$(uname -n)-sh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

if [[ $(uname) == "Darwin" ]]; then
    source $ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme
elif [[ $(uname -r | grep "WSL") ]]; then
    source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
fi

# Heavily based on, up to straight-up copy-pase, 
# (1) https://github.com/Phantas0s/.dotfiles
# (2) https://thevaluable.dev/zsh-install-configure-mouseless/
# Navigation.
setopt AUTO_CD              # Go to folder path without using cd.

setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
# setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

setopt CORRECT              # Spelling correction
setopt CDABLE_VARS          # Change directory to a path stored in a variable.
setopt EXTENDED_GLOB        # Use extended globbing syntax.

# History.
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.

# Dircolours.
if [[ $(uname -r | grep "WSL") ]]; then
    eval "$(dircolors -b $ZDOTDIR/.dircolors)"
fi

# History.
source $ZDOTDIR/.hist

# Aliases.
source $ZDOTDIR/.aliases

# Completion.
source $ZDOTDIR/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# Autosuggestions.
if [[ $(uname) == "Darwin" ]]; then
    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh 
elif [[ $(uname -r | grep "WSL") ]]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 
fi

# Syntax highlight.
if [[ $(uname) == "Darwin" ]]; then
    source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ $(uname -r | grep "WSL") ]]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# WSL integration.
if [[ $(uname -r | grep "WSL") ]]; then
    source $ZDOTDIR/.wsl
fi

if [[ $(uname) == "Darwin" ]]; then
    # Shell command completion for gcloud.
    if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

    #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
    export SDKMAN_DIR="$HOME/.sdkman"
    [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
fi
