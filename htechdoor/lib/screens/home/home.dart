import 'package:flutter/material.dart';
import 'package:htechdoor/screens/request/info.dart';
import 'package:htechdoor/services/apihelper.dart';
import 'package:htechdoor/shared/const.dart';
import 'package:htechdoor/shared/theme.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isLoading = false;
  late DateTime _leaveDateTime, _returnDateTime, _current = DateTime.now();

  get request => null;

  get action => null;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? loader()
        : Scaffold(
            appBar: ThemeAppBar(
              title: home_title,
            ),
            body: Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Generate gatepass button
                    ThemeButtonWidth(
                      text: home_lblbtnScanQR,
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        String _ackMsg = "";
                        String scannedValue = await BarcodeScanner.scan().then(
                          (value) {
                            setState(() {
                              _isLoading = false;
                            });
                            return value;
                          },
                          onError: (e) {
                            print("e: $e");
                            _ackMsg = e.toString();
                          },
                        );

// Sending the value to the server
                        setState(() {
                          _isLoading = true;
                        });
                        await APIHandler.getRequestData(
                          qrCodeValue: scannedValue,
                        ).then(
                          (res) {
                            if (request != null) {
                              _leaveDateTime =
                                  DateTime.parse(request.leaveDateAndTime);
                              _returnDateTime =
                                  DateTime.parse(request.returnDateAndTime);
                              if (_leaveDateTime.isBefore(_returnDateTime) &&
                                  _current.isAfter(_leaveDateTime) &&
                                  _current.isBefore(_returnDateTime)) {
                                ///////// valid QR code
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => RequestInfo(),
                                  ),
                                );
                              } else {
                                _ackMsg = home_qrError;
                              }
                            }
                          },
                          onError: (e) {
                            _ackMsg = e.toString();
                          },
                        );
                        showSnackBar(
                          context: context,
                          content: Text(_ackMsg),
                          action: action,
                        );
                        setState(() {
                          _isLoading = false;
                        });
                      },
                      context: null,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

mixin BarcodeScanner {
  static scan() {}
}
