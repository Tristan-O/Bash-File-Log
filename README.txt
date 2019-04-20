log:

- move this folder to desired location.

- add the following lines to .bashrc file
export LOGPATH="/path/to/log/folder/"
source {$LOGPATH}log.sh

- then add the following line to .vimrc file
set backupcopy=yes

- this file is not normally created by default.
  you may have to create it to set user settings
  in this way.

- without this step, vim may overwrite your logs
 
- this is because by default vim usually overwrites your old file with a new file, and
 because the logs are
  stored as "extended file
 attributes" the logs are lost

- care should be taken with other text editors as this problem could also occur with those

- if you fail to do this, there is a log kept of
 every log every committed stored in $LOGPATH


prev-dir:
- This causes your bash terminal to return to the previous directory you were in
- installation:
    add "/path/to/prev-dir_bashrc" to ~/.bashrc file
    add "/path/to/prev-dir_bashlogout" to ~/.bash_logout