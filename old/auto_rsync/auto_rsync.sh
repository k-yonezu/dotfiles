#!/bin/zsh

# setting
LOCAL_DIR=$HOME/hoo
REMOTE_DIR="fugo"
HOST="hoge"
USER="huga"

# command
fswatch -o -l 3 $LOCAL_DIR | xargs -I{} \
rsync -auvzCP --delete \
--filter=":- .gitignore" --exclude='.*.sw*' --log-file=$HOME/auto_rsync/log/rsync > /dev/null \
$LOCAL_DIR $USER@$HOST:$REMOTE_DIR &
