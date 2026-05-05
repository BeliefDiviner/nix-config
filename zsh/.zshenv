# editor
export EDITOR="nvim"
export VISUAL="nvim"
export SYSTEMD_EDITOR="nvim"

# zsh
export ZDOTDIR="$HOME/.config/zsh"

# PATH
export PATH="$HOME/.local/bin:$PATH"

# Vale
export VALE_CONFIG_PATH="$HOME/.config/vale/.vale.ini"
export VALE_STYLES_PATH="$HOME/.config/vale/styles"

# Homebrew
if [[ $(uname) == "Darwin" ]]; then
    export HOMEBREW_PREFIX="/opt/homebrew";
    export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
    export HOMEBREW_REPOSITORY="/opt/homebrew";
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
    export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
    export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
fi

# Update PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

if [[ $(uname) == "Darwin" ]]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
fi

. "$HOME/.cargo/env"  # Load rust stuff

# SSL Certs
if [[ $(uname) == "Darwin" ]]; then
    export SSL_CERT_FILE=$(python3.12 -c "import certifi; print(certifi.where())")
fi
