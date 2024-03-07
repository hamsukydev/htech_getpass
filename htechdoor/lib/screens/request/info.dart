import 'package:flutter/material.dart';
import 'package:htechdoor/shared/const.dart';

class RequestInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                requestInfo_accepted,
                style: requestInfo_text,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
