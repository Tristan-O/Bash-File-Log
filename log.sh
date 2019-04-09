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
    getfattr --only-values -e text -n user.log $1 > $LOGPATH$TEMP_CURR 2>&-
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
    getfattr --only-values -e text -n user.logUpdateTime $1 2>&-
    echo ''
    getfattr --only-values -e text -n user.log $1 2>&-
    echo ''
  else
    echo 'File does not exist'
  fi
}

llog() {
  TEMP_CURR=recent.log
  TEMP_PREV=all.log

  if [ -d "$1" ]
  then
    if [ -f $LOGPATH$TEMP_CURR ]
    then
      cat "FROM UNKNOWN FILE, UNKNOWN DATE" >> "$LOGPATH$TEMP_PREV"
      cat "$LOGPATH$TEMP_CURR" >> "$LOGPATH$TEMP_PREV"
      rm "$LOGPATH$TEMP_CURR"
    fi
    touch $LOGPATH$TEMP_CURR

    for subfile in $1*; do
      [[ -e $subfile ]] || continue
      echo "##########################################################################################################" >> "$LOGPATH$TEMP_CURR"
      readlink -f $subfile >> "$LOGPATH$TEMP_CURR"
      log $subfile >> "$LOGPATH$TEMP_CURR"
    done

    vim $LOGPATH$TEMP_CURR
    rm "$LOGPATH$TEMP_CURR"
  else
    echo 'Not a directory'
  fi
}

