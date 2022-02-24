import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aphasiatalk/models/FeelSaved.dart';
import 'package:aphasiatalk/models/ifeel_model.dart';
import 'package:aphasiatalk/Favorite.dart';
import 'package:aphasiatalk/Help.dart';
import 'package:aphasiatalk/Home.dart';
import 'package:aphasiatalk/provider/FeelProvider.dart';
import 'package:aphasiatalk/screens/ifeel.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

class Ifpain extends StatefulWidget {
  const Ifpain({Key key}) : super(key: key);

  @override
  _IfpainState createState() => _IfpainState();
}

class _IfpainState extends State<Ifpain> {
  //Field
  List<IfeelModel> ifeelModels = List();

  //Method
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readPain();
  }

  Future<void> readPain() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var ifpain = firestore
        .collection('Ifeel')
        .doc('teTQBMXXYYWfJXowAvq5')
        .collection('Pain')
        .orderBy('Pnid');

    await ifpain.snapshots().listen((response) {
      List<DocumentSnapshot> snapshots = response.docs;
      for (var snapshot in snapshots) {
        print('snapshot = $snapshot');
        print('Pain = ${snapshot['Pnname']}');

        IfeelModel ifeelModel = IfeelModel.fromMap(snapshot.data());
        setState(() {
          ifeelModels.add(ifeelModel);
        });
      }
    });
  }

  Widget showImage(int index) {
    String picpain = ifeelModels[index].painpic;

    if (picpain != null) {
      return Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.width * 0.4,
          child: Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 12),
            child: Row(
              children: [
                picpain != null ? Image.network(picpain) : Container()
              ],
            ),
          ));
    } else if (picpain == null) {
      return Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.width * 0.4,
          child: Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 12),
            child: Row(
              children: [
                Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/aphasiatalk-169dd.appspot.com/o/Iwant%2Fnoimg.png?alt=media&token=f062776f-34b7-44bd-bbea-43cf0bdb9652'),
              ],
            ),
          ));
    }
  }

  Widget showText(int index) {
    String ifpain = ifeelModels[index].pain;

    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      //height: MediaQuery.of(context).size.width * 0.2,
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: ifpain ?? '',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget showListView(int index) {
    return Row(
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        showImage(index),
        Expanded(
          child: showText(index),
        )
      ],
    );
  }

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
                MaterialPageRoute(builder: (context) => Ifeel()),
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
        body: ListView.builder(
          itemCount: ifeelModels.length,
          itemBuilder: (BuildContext buildContext, int index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
              child: Card(
                color: Colors.teal[900],
                child: ListTile(
                  title: showListView(index),
                  onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => IfpainTts(),
                            settings:
                                RouteSettings(arguments: ifeelModels[index]),
                          ));
                  },
                ),
              ),
            );
          },
        ),
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
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///// --------*****--------คั่นโค้ดหน้าย่อย--------*****-------- /////
///
///
///

class IfpainTts extends StatefulWidget {
  @override
  _IfpainTtsState createState() => _IfpainTtsState();
}
class _IfpainTtsState extends State<IfpainTts> {
  bool isfav = false;

  @override
  Widget build(BuildContext context) {
    final FlutterTts tts = FlutterTts();
    final args =
        ModalRoute.of(context).settings.arguments as IfeelModel;

    String pic = args.painpic;

    if (pic != null) {
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
                  MaterialPageRoute(builder: (context) => Ifeel()),
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
          body: SingleChildScrollView(
            padding: EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 20),
            child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.network(args.painpic,
                            width: 300, height: 300),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('ฉันรู้สึกปวด' + args.pain,
                          style: TextStyle(fontSize: 25, color: Colors.black)),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.teal[900],
                          onPrimary: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          textStyle: TextStyle(fontSize: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'อ่าน',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () {
                          tts.speak('ฉันรู้สึกปวด' + args.pain);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: isfav ? Colors.grey : Colors.yellowAccent[700],
                        onPrimary: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        textStyle: TextStyle(fontSize: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: isfav ? Text("นำออกจากรายการโปรด", style: TextStyle(fontSize: 20,),) : Text("เพิ่มในรายการโปรด", style: TextStyle(fontSize: 20,),),
                      onPressed: () {
                        setState(() {
                          isfav = !isfav;
                        },);
                        if (isfav == true) {
                          var img = args.painpic;
                          var message = 'ฉันรู้สึกปวด' + args.pain;

                          //เตรียมข้อมูล
                          FeelSaved favor = FeelSaved(
                              image: img, message: message);

                          //เรียก provider
                          var provider = Provider.of<FeelFavProvider>(
                              context, listen: false);
                          provider.addFavorite(favor);
                        } else {
                          var deleteImg = args.painpic;
                          var delete = 'ฉันรู้สึกปวด' + args.pain;

                          //prepare data
                          FeelSaved favor = FeelSaved(image: deleteImg,message: delete);

                          var provider = Provider.of<FeelFavProvider>(context,listen: false);
                          provider.delete(favor);

                          print("deleted");
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
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
                        style: TextStyle(color: Colors.black, fontSize: 20)),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (pic == null) {
      var imagesrc =
          'https://firebasestorage.googleapis.com/v0/b/aphasiatalk-169dd.appspot.com/o/Iwant%2Fnoimg.png?alt=media&token=f062776f-34b7-44bd-bbea-43cf0bdb9652';
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
                  MaterialPageRoute(builder: (context) => Ifeel()),
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
          body: SingleChildScrollView(
            padding: EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 20),
            child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.network(imagesrc, width: 300, height: 300),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('ฉันรู้สึกปวด' + args.pain,
                          style: TextStyle(fontSize: 25, color: Colors.black)),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.teal[900],
                          onPrimary: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          textStyle: TextStyle(fontSize: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'อ่าน',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () {
                          tts.speak('ฉันรู้สึกปวด' + args.pain);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: isfav ? Colors.grey : Colors.yellowAccent[700],
                        onPrimary: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        textStyle: TextStyle(fontSize: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: isfav ? Text("นำออกจากรายการโปรด", style: TextStyle(fontSize: 20,),) : Text("เพิ่มในรายการโปรด", style: TextStyle(fontSize: 20,),),
                      onPressed: () {
                        setState(() {
                          isfav = !isfav;
                        },);
                        if (isfav == true) {
                          var img = imagesrc;
                          var message = 'ฉันรู้สึกปวด' + args.pain;

                          //เตรียมข้อมูล
                          FeelSaved favor = FeelSaved(
                              image: img, message: message);

                          //เรียก provider
                          var provider = Provider.of<FeelFavProvider>(
                              context, listen: false);
                          provider.addFavorite(favor);
                        } else {
                          var deleteImg = imagesrc;
                          var delete = 'ฉันรู้สึกปวด' + args.pain;

                          //prepare data
                          FeelSaved favor = FeelSaved(image: deleteImg,message: delete);

                          var provider = Provider.of<FeelFavProvider>(context,listen: false);
                          provider.delete(favor);

                          print("deleted");
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
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
                        style: TextStyle(color: Colors.black, fontSize: 20)),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}