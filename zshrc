# Tmux command history
bindkey '^R' history-incremental-search-backward
bindkey -e
export LC_ALL=en_US.UTF-8

bindkey -v

# default editor
editor=`which nvim 2> /dev/null`
if [[ "$?" -eq 0 ]]
then
    EDITOR=$editor
else
    editor=`which vim 2> /dev/null`
    if [[ "$?" -eq 0 ]]
    then
        EDITOR=$editor
    else
        EDITOR=/usr/bin/nano
    fi
fi
export EDITOR

# Reglage du terminal
if [ "$SHLVL" -eq 1 ]; then
    TERM=xterm-256color
fi

# search in history based on what is type
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward

# ctrl + arrow in archlinux
bindkey '^[Od' backward-word
bindkey '^[Oc' forward-word

# Definition des couleurs
if [ -f $C_PATH_TO_PERSONAL_CONFIG/ls_colors ]; then
    source $C_PATH_TO_PERSONAL_CONFIG/ls_colors
fi

# Couleurs pour le man
man()
{
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}

if [[ -n $C_SCHOOL ]]; then
    # let's work in the tmp instead of home
    export OHOME=/tmp/$USER
    if [[ ! -e $OHOME ]]; then
        mkdir $OHOME
        chmod 700 $OHOME
    fi
fi

cpb()
{
    if [[ -z $1 ]] || [[ -z $2 ]]; then
        echo "Usage: cpb source destination"
        echo "Note that the source can be a directory or a file"
    fi
    if [[ -d $1 ]]; then
        if [[ ! -d $2 ]]; then
            mkdir $2
        fi
        (cd $1 && tar -cf - *) | bar -s $(du -sk $1 | cut -f 1)k -dan | (cd $2 && tar -xBpf -)
    elif [[ -f $1 ]]; then
        bar -if $1 -of $2 -dan
    fi
}
