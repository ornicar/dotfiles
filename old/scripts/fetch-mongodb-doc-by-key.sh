#!/bin/bash

REMOTE=$1
DB=$2
COLL=$3
KEY=$4
VALUE=$5
FILE=$DB-$COLL.document.export.json

ssh $REMOTE mongoexport --db $DB --collection $COLL -q \'{\"$KEY\":\"$VALUE\"}\' --out /root/$FILE
scp $REMOTE:$FILE ./
ssh $REMOTE rm /root/$FILE
echo "db.$COLL.deleteOne({'$KEY':'$ID'})"
mongo $DB --eval "db.$COLL.deleteOne({'$KEY':'$ID'})"
mongoimport --db $DB --collection $COLL $FILE
rm $FILE
