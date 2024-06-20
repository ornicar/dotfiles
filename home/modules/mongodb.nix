{ ... }: {
  home.file.".mongoshrc.js".text = # javascript
    ''
      const sec = () => connect('mongodb://localhost:27117/lichess');

      const secImportOne = (coll, id) => db.getCollection(coll).insertOne(sec().getCollection(coll).findOne({ _id: id }));
      const secImportMany = (coll, query) => {
        let ins = 0, dup = 0;
        sec().getCollection(coll).find(query).forEach(doc => {
          try {
            db.getCollection(coll).insertOne(doc);
            ins++;
          } catch (e) {
            dup++;
          }
        });
        console.log(`Inserted: ''${ins}, Duplicates: ''${dup}`);
      }
    '';
}
