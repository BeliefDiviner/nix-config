# jujutsu completion
command -v jj >/dev/null && source <(COMPLETE=zsh jj)
zstyle ':fzf-tab:complete:jj-(show|diff):*' fzf-preview 'jj show --color=always $word'
zstyle ':fzf-tab:complete:jj-log:*'         fzf-preview 'jj log --color=always -r $word'

