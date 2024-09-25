import 'package:flutter/material.dart';
import 'package:woflix/screens/detailsscreen.dart';
import 'package:woflix/screens/homescreen.dart';
import 'package:woflix/screens/searchscreen.dart';
import 'package:woflix/screens/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      // Define the initial screen (Splash Screen or Home Screen)
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home':(context) => HomeScreen() ,       
        '/search': (context) => SearchScreen(),  
        '/details': (context) => DetailsScreen(), 
      },
    );
  }
}
