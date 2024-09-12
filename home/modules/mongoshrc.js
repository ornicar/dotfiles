const ports = {
  rodan: 27117,
  study: 27118,
  achoo: 27119,
  snafu: 27217,
  rubik: 27317,
  kaiju: 27917,
};

const fid = (coll, id, proj = {}) => db.getCollection(coll).findOne({ _id: id }, proj);
const find = (coll, query, proj = {}) => db.getCollection(coll).find(query, proj);

const upid = (coll, id, up) => db.getCollection(coll).updateOne({ _id: id }, { $set: up });

const prod = (port, db = 'lichess') => connect(`mongodb://localhost:${port}/${db}`);
const sec = () => prod(ports.rodan);

const secImportOne = (coll, id, port, dbName = 'lichess') =>
  db[coll].insertOne(prod(port || ports.rodan, dbName).getCollection(coll).findOne({ _id: id }));

const secImportMany = (coll, query, port, dbName = 'lichess') => {
  let ins = 0, dup = 0;
  prod(port || ports.rodan, dbName).getCollection(coll).find(query).forEach(doc => {
    try {
      db[coll].insertOne(doc);
      ins++;
    } catch (e) {
      dup++;
    }
  });
  console.log(`Inserted: ${ins}, Duplicates: ${dup}`);
}
