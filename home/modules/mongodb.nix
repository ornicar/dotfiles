{ ... }: {
  home.file.".mongoshrc.js".text = # js
    ''
      const sec = () => connect('mongodb://localhost:27117/lichess');

      const secImport = (coll, id) => db.getCollection(coll).insertOne(sec().getCollection(coll).findOne({ _id: id }));
    '';
}
