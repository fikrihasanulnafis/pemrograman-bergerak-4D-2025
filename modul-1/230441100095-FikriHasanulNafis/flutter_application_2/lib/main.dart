import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(MyTravelApp());
}

class MyTravelApp extends StatelessWidget {
  const MyTravelApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: TravelHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
