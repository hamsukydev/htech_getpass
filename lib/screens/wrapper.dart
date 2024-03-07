import 'package:flutter/material.dart';
import 'package:getpass/authenticate/authenticate.dart';
import 'package:getpass/model/user.dart';

import 'home/home.dart';

class Wrapper extends StatelessWidget {
  get user => null;

  @override
  Widget build(BuildContext context) {
    return user == null ? Authenticate() : Home();
  }
}
