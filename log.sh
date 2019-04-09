#!/bin/bash
 
logset() {
  TEMP_CURR=recent.log
  TEMP_PREV=all.log
  if [ -e "$1" ]
  then
    if [ -f $LOGPATH$TEMP_CURR ]
    then
      cat "FROM UNKNOWN FILE, UNKNOWN DATE" >> "$LOGPATH$TEMP_PREV"
      cat "$LOGPATH$TEMP_CURR" >> "$LOGPATH$TEMP_PREV"
      rm "$LOGPATH$TEMP_CURR"
    fi
    touch $LOGPATH$TEMP_CURR
    getfattr --only-values -e text -n user.log $1 > $LOGPATH$TEMP_CURR
    vim $LOGPATH$TEMP_CURR

    echo "##########################################################################################################" >> "$LOGPATH$TEMP_PREV"
    readlink -f $1 >> "$LOGPATH$TEMP_PREV"

    setfattr -n user.logUpdateTime -v "$(date)" $1
    date >> "$LOGPATH$TEMP_PREV"

    desc=$(<$LOGPATH$TEMP_CURR)
    setfattr -n user.log -v "$desc" $1
    cat "$LOGPATH$TEMP_CURR" >> "$LOGPATH$TEMP_PREV"

    rm "$LOGPATH$TEMP_CURR"
  else
    echo 'File does not exist'
  fi
}

log() {
  if [ -e "$1" ]
  then
    echo 'This log was last updated on:'
    getfattr --only-values -e text -n user.logUpdateTime $1
    echo ''
    getfattr --only-values -e text -n user.log $1
    echo ''
  else
    echo 'File does not exist'
  fi
}
