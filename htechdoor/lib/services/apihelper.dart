import 'dart:convert';
import 'dart:io';

import 'package:htechdoor/models/request.dart';
import 'package:http/http.dart' as http;
import 'package:htechdoor/models/doorkeeper.dart';
import 'package:htechdoor/models/request.dart' as req;

class APIHandler {
  // Exception messages
  static const String _socketExceptionMessage =
      "Cannot connect to the server. Please check your network connection.";
  static const String _otherExceptionMessage = "Something went wrong.";

  static const String _baseUrl = "http://192.168.0.106:5000";
  static const Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'accept': 'application/json'
  };

  static const Duration _requestDuration = Duration(seconds: 15);

  static Doorkeeper? get doorkeeper => null;

  // Auth APIs
  static Future<Map<String, dynamic>> login({
    required String email,
  }) async {
    final String path = "/api/doorkeeper/login";
    final Uri uri = Uri.parse(_baseUrl + path);

    try {
      final http.Response response = await http
          .post(
            uri,
            headers: _headers,
            body: jsonEncode({
              "email": email,
            }),
          )
          .timeout(_requestDuration);

      return jsonDecode(response.body);
    } on SocketException {
      throw _socketExceptionMessage;
    } catch (e) {
      throw _otherExceptionMessage;
    }
  }

  static Future<void> checkOTP({
    required String email,
    required String myotp,
    required String otp,
  }) async {
    final String path = "/api/doorkeeper/checkOTP";
    final Uri uri = Uri.parse(_baseUrl + path);

    try {
      final http.Response response = await http
          .post(
            uri,
            headers: _headers,
            body: jsonEncode({
              "email": email,
              "myOTP": myotp,
              "otp": otp,
            }),
          )
          .timeout(_requestDuration);

      _setDoorkeeperObject(
          jsonDecodedResponse: jsonDecode(response.body), setToken: true);
    } on SocketException {
      throw _socketExceptionMessage;
    } catch (e) {
      throw _otherExceptionMessage;
    }
  }

  // Request
  static Future<void> getRequestData({required String qrCodeValue}) async {
    final String path = "/api/request/$qrCodeValue";
    final Uri uri = Uri.parse(_baseUrl + path);

    try {
      final http.Response response = await http
          .get(
            uri,
            headers: _headers,
          )
          .timeout(_requestDuration);

      if (response.body.isNotEmpty) {
        _setRequestObject(
            jsonDecodedResponse: jsonDecode(response.body)["request"]);
      }
    } on SocketException {
      throw _socketExceptionMessage;
    } catch (e) {
      throw _otherExceptionMessage;
    }
  }

  // Private methods
  static void _setDoorkeeperObject(
      {required dynamic jsonDecodedResponse, required bool setToken}) {
    doorkeeper?.id = jsonDecodedResponse["doorKeeper"]["_id"];
    doorkeeper?.email = jsonDecodedResponse["doorKeeper"]["email"];
    doorkeeper?.name = jsonDecodedResponse["doorKeeper"]["name"];

    if (setToken) {
      doorkeeper?.token = jsonDecodedResponse["token"];
    }
  }

  static void _setRequestObject({required dynamic jsonDecodedResponse}) {
    Request(
      id: '',
      requestStatus: '',
      reason: '',
      leaveDateAndTime: '',
      returnDateAndTime: '',
    );
    request.id = jsonDecodedResponse["_id"];
    request.requestStatus = jsonDecodedResponse["approved"];
    request.reason = jsonDecodedResponse["reason"];
    request.returnDateAndTime = jsonDecodedResponse["return"];
    request.leaveDateAndTime = jsonDecodedResponse["leave"];
  }

  // ignore: recursive_getters
  static dynamic get request => request;
}
