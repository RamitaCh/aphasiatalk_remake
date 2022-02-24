import 'dart:io';

import 'package:aphasiatalk/models/Saved.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class FavDB {
  //db services

  String dbName; //Name of db

  FavDB({this.dbName});

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
  Future<int> InsertData(Saved favor) async {
    //create store
    //by go to db first
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("Message");

    var filter = Filter.equals("Message", favor.message);
    var numrec = await store.count(db, filter: filter);
    var keyID;
    if (numrec == 0) {
      //json
      keyID = store.add(db, {"Message": favor.message});
    }
    db.close();

    return keyID;
  }

  //delete data
  Future<int> DeleteData(Saved favor) async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("Message");
    //json
    var finder = Finder(filter: Filter.equals("Message", favor.message));
    var keyID = store.delete(db, finder: finder);
    db.close();

    return keyID;
  }

  //pull data
  Future<List<Saved>> loadAlldata() async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("Message");
    var snapshot = await store.find(db, finder: Finder(sortOrders: [SortOrder(Field.key, false)]));
    var favwriteList = <Saved>[];
    for (var record in snapshot) {
      favwriteList.add(Saved(message: record["Message"].toString()));
    }
    
    return favwriteList;
  }
}
