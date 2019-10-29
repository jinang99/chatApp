import 'package:chat/chatscreen.dart';
import 'package:flutter/material.dart';
import 'package:chat/homepage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Speak Up',
      home: new HomePage()
      
      ); 
  }
}