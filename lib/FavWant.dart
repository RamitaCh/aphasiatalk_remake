import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:aphasiatalk/Favorite.dart';
import 'package:aphasiatalk/Help.dart';
import 'package:aphasiatalk/Home.dart';
import 'package:aphasiatalk/models/WantSaved.dart';
import 'package:aphasiatalk/provider/WantProvider.dart';
import 'package:provider/provider.dart';

class FavWant extends StatefulWidget{
  @override
  _FavWantState createState() => _FavWantState();
}
class _FavWantState extends State<FavWant> {

  void initState(){
    super.initState();
    Provider.of<WantFavProvider>(context, listen: false).initData();
  }

  final FlutterTts tts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: new AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Favorite()),
              );
            },
          ),
          title: const Text('Aphasia', style: TextStyle(color: Colors.black)),
          actions: <Widget>[
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.red[900],
              child: IconButton(
                icon: const Icon(
                  Icons.warning_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Help()),
                  );
                },
              ),
            ),
          ],
          backgroundColor: Colors.white,
        ),
        body: Consumer(builder: (context, WantFavProvider provider, child) {
          var count = provider.fav.length; //count
          return ListView.builder(
              itemCount: count,
              itemBuilder: (context, int index) {
                WantSaved data = provider.fav[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 16.0),
                  child: Card(
                    color: Colors.teal[900],
                    child: ListTile(
                      leading: Image.network(data.image),
                      title: Text(data.message,
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      dense: true,
                      onTap: () {
                        tts.speak(data.message); // Text-to-speech
                      },
                      trailing: IconButton(
                        onPressed: () {
                          var delete = data.message;
                          var deleteImg = data.image;

                          //prepare data
                          WantSaved favor = WantSaved(image: deleteImg,message: delete);

                          var provider = Provider.of<WantFavProvider>(context,listen: false);
                          provider.delete(favor);

                        },
                        icon: const Icon(
                          Icons.delete_forever,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              });
        }),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                  child: Text('เมนูหลัก',
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Favorite()),
                    );
                  },
                  child: Text('รายการโปรด',
                      style: TextStyle(color: Colors.teal[900], fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
