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
    $PERS_PATH/osx
    mkdir $HOME/bin

    # add exa
    curl -0 https://github.com/ogham/exa/releases/download/v0.4.0/exa-osx-x86_64.zip > $HOME/exa-osx-x86_64.zip
    unzip $HOME/exa-osx-x86_64.zip
    mv exa-osx-x86_64 $HOME/bin/exa
    rm exa-osx-x86_64.zip

    # add font for osx
    cd
    git clone https://github.com/powerline/fonts temp_fonts
    cd temp_fonts
    mkdir ~/Library/Fonts
    ./install.sh
    open /Applications/Font\ Book.app

    # add qwerty-fr layout
    curl -0 http://marin.jb.free.fr/qwerty-fr/qwerty-fr_mac.tgz > $HOME/Downloads/qwerty-fr_mac.tgz
    mkdir $HOME/Library/Keyborad\ Layouts
    tar xzf $HOME/Downloads/qwerty-fr_mac.tgz -C $HOME/Library/Keyborad\ Layouts
fi
