import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:aphasiatalk/Favorite.dart';
import 'package:aphasiatalk/Help.dart';
import 'package:aphasiatalk/Home.dart';
import 'package:aphasiatalk/models/iwant_model.dart';
import 'package:aphasiatalk/screens/iwant.dart';
import 'package:aphasiatalk/screens/iwant_eat_desserts.dart';
import 'package:aphasiatalk/screens/iwant_eat_fried.dart';
import 'package:aphasiatalk/screens/iwant_eat_fruits.dart';
import 'package:aphasiatalk/screens/iwant_eat_grilled.dart';
import 'package:aphasiatalk/screens/iwant_eat_salad.dart';
import 'package:aphasiatalk/screens/iwant_eat_singledish.dart';
import 'package:aphasiatalk/screens/iwant_eat_soup.dart';
import 'package:aphasiatalk/screens/iwant_eat_steamed.dart';

class WantEat extends StatefulWidget {
  @override
  _WantEatState createState() => _WantEatState();
}

class _WantEatState extends State<WantEat> {
  List<IwantModel> iwantModels = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readIwfoodT();
  }

  Future<void> readIwfoodT() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var iwantfoodt = firestore
        .collection('Iwant')
        .doc('av9GjXDgd6HdvekrXdNQ')
        .collection('Foods')
        .orderBy('Ftid');

    await iwantfoodt.snapshots().listen((response) {
      List<DocumentSnapshot> snapshots = response.docs;
      for (var snapshot in snapshots) {
        //print('snapshot = $snapshot');
        //print('Iwant = ${snapshot['']}');

        IwantModel iwantModel = IwantModel.fromMap(snapshot.data());
        setState(() {
          iwantModels.add(iwantModel);
        });
      }
    });
  }

  Widget showImage(int index) {
    String picfoodT = iwantModels[index].foodpic;

    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.width * 0.4,
      child: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        child: Row(
        children: [
          picfoodT != null ? Image.network(picfoodT) : Container(),
        ],
      ),)
    );
  }

  Widget showText(int index) {
    String iwFoodT = iwantModels[index].foodT;

    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      //height: MediaQuery.of(context).size.width * 0.2,
      child: Column(
        children: [
          Text(
            iwFoodT ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ],
      ),
    );
  }

  Widget showListView(int index) {
    return Row(
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
                MaterialPageRoute(builder: (context) => Iwant()),
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
          itemCount: iwantModels.length,
          itemBuilder: (BuildContext buildContext, int index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
              child: Card(
                child: ListTile(
                    tileColor: Colors.teal[900],
                    title: showListView(index),
                    onTap: () {
                      if(index == 0){
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WantEatSingledish()),
                      );
                      }
                      else if(index == 1){
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WantEatSoup()),
                      );
                      }
                      else if(index == 2){
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WantEatFried()),
                      );
                      }
                      else if(index == 3){
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WantEatSteamed()),
                      );
                      }
                      else if(index == 4){
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WantEatGrilled()),
                      );
                      }
                      else if(index == 5){
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WantEatSalads()),
                      );
                      }
                      else if(index == 6){
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WantEatDesserts()),
                      );
                      }
                      else{
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WantEatFruits()),
                      );
                      }
                    }),
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