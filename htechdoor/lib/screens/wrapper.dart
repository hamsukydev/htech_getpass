import 'package:flutter/material.dart';
import 'package:htechdoor/authenticate/authenticate.dart';

import 'home/home.dart';

class Wrapper extends StatelessWidget {
  get doorkeeper => null;

  @override
  Widget build(BuildContext context) {
    // doorkeeper model checking if not null then Home() else
    return doorkeeper != null ? Home() : Authenticate();
  }
}
