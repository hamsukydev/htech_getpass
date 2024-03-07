// /import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:getpass/screens/wrapper.dart';
import 'package:getpass/shared/const.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
// removes debug banner, not necessary to put
      debugShowCheckedModeBanner: false,

      title: title,
      home: Wrapper(),
    );
  }
}
