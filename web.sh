#!/bin/bash

if [ -z $@ ]
then
    cd /home/kdani/repos/browser_opener
    make places.txt
    cat "places.txt"
else
    cd /home/kdani/repos/browser_opener
    URI=$@
    COMMAND=`echo $URI | cut -d'|' -f1`
    "./$COMMAND.sh" `echo $URI | cut -d'|' -f3` > /dev/null &
    cd -
fi
