import 'package:flutter/foundation.dart';
import 'package:aphasiatalk/database/feelFavor_db.dart';
import 'package:aphasiatalk/models/FeelSaved.dart';

class FeelFavProvider with ChangeNotifier {
  List<FeelSaved> fav = [
    //Saved(message: "สวัสดีจ้า"),
    //Saved(message: "สวัสดีค่ะ"),
    //Saved(message: "สวัสดีครับ")
  ];

//pull data
  List<FeelSaved> getFavorite() {
    return fav;
  }

  void initData() async {
    var db = FeelFavDB(dbName: "data.db");

    fav = await db.loadAlldata();
    notifyListeners();
  }

  void addFavorite(FeelSaved favor) async {
    var db = FeelFavDB(dbName: "data.db");

    //save data
    await db.InsertData(favor);

    //pull data
    fav = await db.loadAlldata();

    //แจ้งเตือน consumer
    notifyListeners();
  }

  void delete(FeelSaved favor) async{
    var db = FeelFavDB(dbName: "data.db");

    //delete data
    await db.DeleteData(favor);

    //pull data
    fav = await db.loadAlldata();

    //แจ้งเตือน consumer
    notifyListeners();
  }
}
