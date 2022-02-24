import 'package:flutter/material.dart';
import 'package:aphasiatalk/Home.dart';
import 'package:aphasiatalk/provider/WantProvider.dart';
import 'package:aphasiatalk/provider/provider.dart';
import 'package:aphasiatalk/provider/FeelProvider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context){
          return FavProvider();
        }),
        ChangeNotifierProvider(create: (context){
          return FeelFavProvider();
        }),
        ChangeNotifierProvider(create: (context){
          return WantFavProvider();
        })
      ],
          child: MaterialApp(
            title: 'Aphasia',
        home: Home(),
      ),
    );
  }
}