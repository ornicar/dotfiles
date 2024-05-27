// mongosh --quiet ~/.scripts/fetch-mongodb-document.js 27117 lichess game5 "JGuIFbdD"

const [port, dbName, coll, id] = process.argv.slice(4);

use(dbName);

prod = connect(`mongodb://localhost:${port}/${dbName}?readPreference=secondaryPreferred`);

print(`Fetching ${port}/${dbName} ${coll} ${id}`);

doc = prod[coll].findOne({ _id: id });

if (doc) {
  db[coll].insertOne(doc);
  print(`Saved ${dbName} ${coll} ${id}`);
} else {
  print('Document not found');
}

quit();
