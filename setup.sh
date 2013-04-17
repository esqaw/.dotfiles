#!/bin/zsh

INITIALIZE_CONFIG_FILES='non-empty-string'

USAGE="
Usage: `basename $0` [--update]
"
while [ "$1" != "" ]; do
    case "$1" in
        --update )
            INITIALIZE_CONFIG_FILES=
            ;;
        * )
            echo $USAGE
            exit 1
    esac
    shift
done

cp .zshrc_template ~/.zshrc
# TODO(arsen): only works on Linux
sed -i "s+___BASE_DIRECTORY___+`pwd`+g" ~/.zshrc

for script in ./small_scripts/*sh; do
  echo "alias $(grep '#short-name: ' $script | sed 's+#short-name: ++')='$(pwd)/$script'" >> ~/.zshrc
done

if [ "$INITIALIZE_CONFIG_FILES" ] ; then
  echo 'Copying config files..'
  cp ./colors.template ./colors.config
fi
