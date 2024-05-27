// mongosh --quiet ~/.scripts/publish-mongodb-collection.js 27117 lichess cms_page

const [port, dbName, coll] = process.argv.slice(4);

use(dbName);

prod = connect(`mongodb://localhost:${port}/${dbName}`);

print(`Publishing local ${coll} to ${port}/${dbName}`);

db[coll].find().forEach(doc => prod[coll].insertOne(doc));

quit();
