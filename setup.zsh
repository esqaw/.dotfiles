#!/bin/zsh

USAGE="
Usage: `basename $0` [--update]
"
install_xmonad=false

while [ "$1" != "" ]; do
    case "$1"  in
        --xmonad )
            install_xmonad=true
            ;;
        --zsh )
            install_zsh=true
            ;;
        * )
            echo $USAGE
            exit 1
    esac
    shift
done

function setup_X
{
    cp ./defaults/.xinitrc ~/
    cp ./defaults/.Xdefaults ~/ 
}

function setup_xmonad
{
    setup_X
    sudo apt-get install xmonad dmenu xmobar
    mkdir ~/.xmonad
    cp ./defaults/xmonad.hs ~/.xmonad/
    cp ./defaults/.dmenurc ~/
    cp ./defaults/.xmobarrc ~/
    echo "installing xmonad"
}

function setup_zsh
{
    if ! [[ -d ~/.oh-my-zsh ]] ; then
        git clone git@github.com:esqaw/oh-my-zsh.git ~/.oh-my-zsh
    else
        echo "not cloning repo because it exists"
    fi
    cp ./defaults/zshrc.zsh-template ~/.zshrc
    # Install esqaw theme
    # TODO(arsen): Figure out a way to get this variable from shell, it's there in terminal
    ZSH_CUSTOM="~/.oh-my-zsh/custom"
    mkdir -p $ZSH_CUSTOM/themes
    curl https://raw.githubusercontent.com/esqaw/esqaw-zsh-theme/master/esqaw.zsh-theme -o $ZSH_CUSTOM/themes/esqaw.zsh-theme
}

if $install_xmonad ; then
    setup_xmonad
fi

if $install_zsh ; then
    setup_zsh
fi