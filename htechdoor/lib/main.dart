import 'package:flutter/material.dart';
import 'package:htechdoor/screens/wrapper.dart';
import 'package:htechdoor/shared/const.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: Wrapper(),
    );
  }
}
