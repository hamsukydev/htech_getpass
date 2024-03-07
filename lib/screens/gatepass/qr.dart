import 'package:flutter/material.dart';
import 'package:getpass/model/request.dart';
import 'package:getpass/shared/const.dart';

class QrG extends StatelessWidget {
  final Request request; // Define a property to hold the request object

  // Constructor to initialize the request object
  QrG({required this.request});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(), // AppBar for the page
      body: Center(
        child: Container(
          width:
              qr_codeContainerSize, // Width of the container holding the QR code
          child: Wrap(
            children: [
              Column(
                children: [
                  ClipPath(

                      /// Doc id as data
                      // child: QrImage(
                      //   size: qr_codeImgSize, // Size of the QR code image
                      //   data: request.id, // Data to encode in the QR code
                      // ),
                      ),
                  SizedBox(height: sizedBoxheight), // Vertical spacing
                  Text(
                    qr_scanInfo, // Information about QR code scanning
                    textAlign: TextAlign.center, // Center-align the text
                    style: TextStyle(
                      fontSize:
                          infoTextSize, // Font size of the information text
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
