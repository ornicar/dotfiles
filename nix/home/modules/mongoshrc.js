const ports = {
  gappa: 27117,
  study: 27118,
  achoo: 27119,
  snafu: 27217,
  lucid: 27317,
  feck1: 27417,
  thonk: 27517,
  kaiju: 27917,
  fw: 27417,
  crom: 27418,
};
const defaultOpts = {
  port: ports.gappa,
  db: 'lichess',
  deleteFirst: false,
};

const fid = (coll, id, proj = {}) => db.getCollection(coll).findOne({ _id: id }, proj);
const find = (coll, query, proj = {}) => db.getCollection(coll).find(query, proj);

const upid = (coll, id, up) => db.getCollection(coll).updateOne({ _id: id }, { $set: up });

const prod = (port, db = 'lichess') => connect(`mongodb://localhost:${port}/${db}`);
const sec = () => prod(ports.gappa);

const secImportOne = (coll, id, opts = {}) => {
  opts = { ...defaultOpts, ...opts };
  if (opts.deleteFirst) db[coll].deleteOne({ _id: id });
  const doc = prod(opts.port, opts.db).getCollection(coll).findOne({ _id: id });
  const debug = `${coll}:${id}`;
  console.log(doc ? `Importing document ${debug}` : `Document ${debug} not found`);
  db[coll].insertOne(doc);
};

const secImportMany = (coll, query, opts = {}) => {
  opts = { ...defaultOpts, ...opts };
  if (opts.deleteFirst) db[coll].deleteMany(query);
  let ins = 0,
    dup = 0;
  prod(opts.port, opts.db)
    .getCollection(coll)
    .find(query)
    .forEach((doc) => {
      try {
        db[coll].insertOne(doc);
        ins++;
        if ((ins + dup) % 1000 === 0) console.log(`Inserted: ${ins}, Duplicates: ${dup}`);
      } catch (e) {
        dup++;
      }
    });
  console.log(`Inserted: ${ins}, Duplicates: ${dup}`);
};

const uploadOne = (coll, id, opts = {}) => {
  opts = { ...defaultOpts, port: ports.kaiju, ...opts };
  prod(opts.port, opts.db)
    .getCollection(coll)
    .insertOne(db[coll].findOne({ _id: id }));
};

const uploadMany = (coll, query, opts = {}) => {
  opts = { ...defaultOpts, port: ports.kaiju, ...opts };
  const prodColl = prod(opts.port, opts.db).getCollection(coll);
  db[coll].find(query).forEach((doc) => {
    try {
      prodColl.insertOne(doc);
    } catch (e) {
      console.error(`Error uploading ${coll}:${doc._id} ${e.code}`);
    }
  });
};

const changeId = (coll, oldId, newId) => {
  const doc = db[coll].findOne({ _id: oldId });
  if (!doc) {
    console.log(`Document ${coll}:${oldId} not found`);
    return;
  }
  doc._id = newId;
  try {
    db[coll].insertOne(doc);
    db[coll].deleteOne({ _id: oldId });
    console.log(`Changed id ${coll}:${oldId} -> ${newId}`);
  } catch (e) {
    console.error(`Error updating id ${coll}:${oldId} -> ${newId}:`, e);
  }
};
