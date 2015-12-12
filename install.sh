#!/bin/bash

# vim config
CONFIG_VIM=$HOME/.config/nvim
VIM_DEPOT=github.com/Geam/config_neovim.git

if [[ -e $CONFIG_VIM ]]
then
    rm -rf $CONFIG_VIM
else
    CONFIG_PARENT=`dirname $CONFIG_VIM`
    if [[ ! -e $CONFIG_PARENT ]]; then
        mkdir -p $CONFIG_PARENT
    fi
fi

git clone "git@$VIM_DEPOT" $CONFIG_VIM
# because some person keep using my personal config instead of doing their own,
# they need to use the https version of this repo
if [[ "$?" -ne 0 ]]; then
    git clone "https://$VIM_DEPOT" $CONFIG_VIM
fi
cd $CONFIG_VIM
mkdir $CONFIG_VIM/tmp

if [[ "$USER" != "geam" ]] && [[ "$USER" != "mdelage" ]]; then
    # remove my git config if it's not me
    sed -i.back '/git/d' $PERS_PATH/ln
fi

if [[ -n $SCHOOL42 ]]; then
    # create personal script dir if it doesn't exist
    if [[ ! -e "$PERS_PATH/scripts" ]]; then
        mkdir "$PERS_PATH/scripts"
    fi
fi
