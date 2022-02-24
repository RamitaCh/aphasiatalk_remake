import 'dart:io';

import 'package:aphasiatalk/models/FeelSaved.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class FeelFavDB {
  //db services

  String dbName; //Name of db

  FeelFavDB({this.dbName});

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
  Future<int> InsertData(FeelSaved favor) async {
    //create store
    //by go to db first
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("Feel");

    var filter = Filter.equals("feelmessage", favor.message);
    var numrec = await store.count(db, filter: filter);
    var keyID;
    if (numrec == 0) {
      keyID = store.add(db, {"feelimg": favor.image, "feelmessage": favor.message});
    }

    db.close();

    return keyID;
  }

  //delete data
  Future<int> DeleteData(FeelSaved favor) async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("Feel");

    //json
    var finder = Finder(filter: Filter.equals("feelmessage", favor.message));
    var keyID = store.delete(db, finder: finder);
    db.close();

    return keyID;
  }

  //pull data
  Future<List<FeelSaved>> loadAlldata() async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("Feel");
    var snapshot = await store.find(db, finder: Finder(sortOrders: [SortOrder(Field.key, false)]));
    var favfeelList = <FeelSaved>[];
    for (var record in snapshot) {
      favfeelList.add(FeelSaved(image: record["feelimg"].toString() ?? null, message: record["feelmessage"]));
    }

    return favfeelList;
  }

}
