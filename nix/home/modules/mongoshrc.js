const ports = {
  gappa: 27117,
  study: 27118,
  achoo: 27119,
  snafu: 27217,
  rubik: 27317,
  kaiju: 27917,
};
const defaultOpts = {
  port: ports.gappa,
  db: 'lichess',
  deleteFirst: false,
}

const fid = (coll, id, proj = {}) => db.getCollection(coll).findOne({ _id: id }, proj);
const find = (coll, query, proj = {}) => db.getCollection(coll).find(query, proj);

const upid = (coll, id, up) => db.getCollection(coll).updateOne({ _id: id }, { $set: up });

const prod = (port, db = 'lichess') => connect(`mongodb://localhost:${port}/${db}`);
const sec = () => prod(ports.gappa);

const secImportOne = (coll, id, opts = {}) => {
  opts = { ...defaultOpts, ...opts };
  if (opts.deleteFirst) db[coll].deleteOne({ _id: id });
  db[coll].insertOne(prod(opts.port, opts.db).getCollection(coll).findOne({ _id: id }));
}

const secImportMany = (coll, query, opts = {}) => {
  opts = { ...defaultOpts, ...opts };
  if (opts.deleteFirst) db[coll].deleteMany(query);
  let ins = 0, dup = 0;
  prod(opts.port, opts.db).getCollection(coll).find(query).forEach(doc => {
    try {
      db[coll].insertOne(doc);
      ins++;
    } catch (e) {
      dup++;
    }
  });
  console.log(`Inserted: ${ins}, Duplicates: ${dup}`);
}

const uploadOne = (coll, id, opts = {}) => {
  opts = { ...defaultOpts, port: ports.kaiju, ...opts };
  prod(opts.port, opts.db).getCollection(coll).insertOne(db[coll].findOne({ _id: id }));
}

const uploadMany = (coll, query, opts = {}) => {
  opts = { ...defaultOpts, port: ports.kaiju, ...opts };
  const prodColl = prod(opts.port, opts.db).getCollection(coll);
  db[coll].find(query).forEach(doc => prodColl.insertOne(doc));
}
