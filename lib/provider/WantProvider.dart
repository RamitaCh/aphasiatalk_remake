import 'package:flutter/foundation.dart';
import 'package:aphasiatalk/database/wantFavor_db.dart';
import 'package:aphasiatalk/models/WantSaved.dart';

class WantFavProvider with ChangeNotifier {
  List<WantSaved> fav = [
    //Saved(message: "สวัสดีจ้า"),
    //Saved(message: "สวัสดีค่ะ"),
    //Saved(message: "สวัสดีครับ")
  ];

//pull data
  List<WantSaved> getFavorite() {
    return fav;
  }

  void initData() async {
    var db = WantFavDB(dbName: "data.db");

    fav = await db.loadAlldata();
    notifyListeners();
  }

  void addFavorite(WantSaved favor) async {
    var db = WantFavDB(dbName: "data.db");

    //save data
    await db.InsertData(favor);

    //pull data
    fav = await db.loadAlldata();

    //แจ้งเตือน consumer
    notifyListeners();
  }

  void delete(WantSaved favor) async{
    var db = WantFavDB(dbName: "data.db");

    //delete data
    await db.DeleteData(favor);

    //pull data
    fav = await db.loadAlldata();

    //แจ้งเตือน consumer
    notifyListeners();
  }
}
