import 'package:flutter/material.dart';
import 'package:aphasiatalk/Help.dart';
import 'package:aphasiatalk/Home.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:aphasiatalk/Favorite.dart';
import 'package:aphasiatalk/screens/ifeel.dart';
import 'package:aphasiatalk/screens/iwant.dart';
import 'package:aphasiatalk/models/Saved.dart';
import 'package:aphasiatalk/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gradients/flutter_gradients.dart';

class TestHomeUI extends StatelessWidget {
  final FlutterTts tts = FlutterTts();
  final messageController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  TestHomeUI() {
    tts.setLanguage('th');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[900],
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal[900], Colors.yellowAccent[700]],
            ),
          ),
        ),
        //backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text('AphasiaTalk on Mobile',
            style: TextStyle(
                fontFamily: 'Montserrat', fontSize: 18.0, color: Colors.white)),
        centerTitle: true,
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
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal[900], Colors.yellowAccent[700]],
          ),
        ),
        child: new SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            child: Column(children: [
              Stack(children: [
                Container(
                    height: MediaQuery.of(context).size.height - 82.0,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent),
                Positioned(
                    top: 60.0,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(45.0),
                              topRight: Radius.circular(45.0),
                            ),
                            color: Colors.white),
                        height: MediaQuery.of(context).size.height - 100.0,
                        width: MediaQuery.of(context).size.width)),
                Positioned(
                    top: 7.0,
                    left: (MediaQuery.of(context).size.width / 2) - 170.0,
                    child: Hero(
                        tag: Text('Welcome Home'),
                        child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/atcartoon.png'),
                                    fit: BoxFit.cover)),
                            height: 75.0,
                            width: 341.0))),
                Positioned(
                    top: 100.0,
                    left: 25.0,
                    right: 25.0,
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('พิมพ์ข้อความที่นี่',
                              style: TextStyle(
                                  fontSize: 22.0, fontWeight: FontWeight.bold)),
                          SizedBox(height: 12.0),
                          Center(
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'พิมพ์ข้อความที่ต้องการพูด',
                                    suffixIcon: IconButton(
                                      onPressed: messageController.clear,
                                      icon: Icon(Icons.clear),
                                    ),
                                  ),
                                  controller: messageController,
                                  validator: (String str) {
                                    if (str.isEmpty) {
                                      return "กรุณาพิมพ์ข้อความ";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.teal[900],
                                        onPrimary: Colors.white,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 50, vertical: 20),
                                        textStyle: TextStyle(fontSize: 20),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: Text(
                                        'อ่าน',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      onPressed: () {
                                        if (formKey.currentState.validate()) {
                                          tts.speak(messageController.text);
                                        }
                                      },
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.yellowAccent[700],
                                        onPrimary: Colors.white,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 20),
                                        textStyle: TextStyle(fontSize: 20),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: Text(
                                        'เพิ่มในรายการโปรด',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      onPressed: () {
                                        if (formKey.currentState.validate()) {
                                          var message = messageController.text;

                                          //เตรียมข้อมูล
                                          Saved favor = Saved(message: message);

                                          //เรียก provider
                                          var provider =
                                              Provider.of<FavProvider>(context,
                                                  listen: false);
                                          provider.addFavorite(favor);
                                          messageController.clear();
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 28,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Iwant()),
                                    );
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    color: Colors.teal[900],
                                    child: Padding(
                                      padding: const EdgeInsets.all(30.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text('ฉันต้องการ',
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      color: Colors.white)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Ifeel()),
                                    );
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    color: Colors.teal[900],
                                    child: Padding(
                                      padding: const EdgeInsets.all(30.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text('ฉันรู้สึก',
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      color: Colors.white)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ))
              ])
            ])),
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
                    style: TextStyle(
                        color: Colors.teal[900],
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
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
    );
  }
}
