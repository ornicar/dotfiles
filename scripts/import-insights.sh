#!/bin/sh

for user in thibault maia1 german11 chess-network lazario konevlad ulisse7; do

  echo $user
  mongo lichess --eval "db.tutor_report.remove({user:'$user'})"
  mongo lichess --eval "db.user4.remove({_id:'$user'})"
  ~/.scripts/fetch-mongodb-document loquy lichess user4 "$user"
  mongo insight --eval "db.insight_user.remove({_id:'$user'})"
  mongo insight --eval "db.insight.remove({u:'$user'})"

done

echo "finalizing..."
~/.scripts/fetch-mongodb-collection root@bowie.lichess.ovh insight insight_user
~/.scripts/fetch-mongodb-collection root@bowie.lichess.ovh insight insight_export
mongo insight --eval 'db.insight_export.aggregate([{$merge:"insight"}])'
mongo insight --eval "db.insight.find({mr:{\$exists:false}}).forEach(i => { if (i.or && Math.random() > 0.01) db.insight.updateOne({_id:i._id},{\$set:{mr:NumberInt(i.or + 50 - Math.round(Math.random() * 100))}})})"
