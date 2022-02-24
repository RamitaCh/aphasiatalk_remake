import 'dart:io';

import 'package:aphasiatalk/models/WantSaved.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class WantFavDB {
  //db services

  String dbName; //Name of db

  WantFavDB({this.dbName});

  Future<Database> openDatabase() async {
    //find location that store the data
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);

    //create database
    DatabaseFactory dbFactory = await databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);

    return db;
  }

  //save data
  Future<int> InsertData(WantSaved favor) async {
    //create store
    //by go to db first
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("Want");

    var filter = Filter.equals("wantmessage", favor.message);
    var numrec = await store.count(db, filter: filter);
    var keyID;
    if (numrec == 0) {
      keyID = store.add(db, {"wantimg": favor.image, "wantmessage": favor.message});
    }
    db.close();

    return keyID;
  }

  //delete data
  Future<int> DeleteData(WantSaved favor) async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("Want");

    //json
    var finder = Finder(filter: Filter.equals("wantmessage", favor.message));
    var keyID = store.delete(db, finder: finder);
    db.close();

    return keyID;
  }

  //pull data
  Future<List<WantSaved>> loadAlldata() async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("Want");
    var snapshot = await store.find(db, finder: Finder(sortOrders: [SortOrder(Field.key, false)]));
    var favwantList = <WantSaved>[];
    for (var record in snapshot) {
      favwantList.add(WantSaved(image: record["wantimg"].toString() ?? null, message: record["wantmessage"]));
    }

    return favwantList;
  }

}
