import 'package:flutter/foundation.dart';
import 'package:aphasiatalk/database/favor_db.dart';
import 'package:aphasiatalk/models/Saved.dart';

class FavProvider with ChangeNotifier {
  List<Saved> fav = [
    //Saved(message: "สวัสดีจ้า"),
    //Saved(message: "สวัสดีค่ะ"),
    //Saved(message: "สวัสดีครับ")
  ];

//pull data
  List<Saved> getFavorite() {
    return fav;
  }

  void initData() async {
    var db = FavDB(dbName: "data.db");

    fav = await db.loadAlldata();
    notifyListeners();
  }



  void addFavorite(Saved favor) async {
    var db = FavDB(dbName: "data.db");

    //save data
    await db.InsertData(favor);

    //pull data
    fav = await db.loadAlldata();
    //fav.insert(0, favor);

    //แจ้งเตือน consumer
    notifyListeners();
  }

  void delete(Saved favor) async{
    var db = FavDB(dbName: "data.db");

    //delete data
    await db.DeleteData(favor);

    //pull data
    fav = await db.loadAlldata();

    //แจ้งเตือน consumer
    notifyListeners();
  }
}
