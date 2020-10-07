import 'package:flutter/material.dart';
import './screens/home_page.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // textTheme: GoogleFonts.openSansTextTheme(
        //   Theme.of(context).textTheme,
        // ),
      ),
      home: HomePage(),
    );
  }
}
