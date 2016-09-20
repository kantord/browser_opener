#!/bin/bash

if [[ -z $@ ]]
then
    cd ~/repos/arch-config/browser_opener
    make places.txt
    cat "places.txt"
else
    cd ~/repos/arch-config/browser_opener
    URI=$@
    COMMAND=`echo $URI | cut -d'|' -f1`
    "./$COMMAND.sh" `echo $URI | cut -d'|' -f3` > /dev/null &
fi
