import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class APIHandler {
  static const String _socketExceptionMessage =
      "Can not connect to the server ($_url), or check your network connection";
  static const String _otherExceptionMessage = "Something went wrong";
  static const String _url = "192.168.0.106:5000";
  static final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'accept': 'application/json'
  };
  static const Duration _requestDuration = Duration(seconds: 15);

  static Future<dynamic> login({required String email}) async {
    try {
      String path = "/api/auth/login";
      http.Response res = await http
          .post(
            Uri.http(_url, path),
            headers: _headers,
            body: jsonEncode({"email": email}),
          )
          .timeout(_requestDuration);
      return jsonDecode(res.body);
    } on SocketException {
      throw _socketExceptionMessage;
    } catch (e) {
      throw _otherExceptionMessage;
    }
  }

  static Future<dynamic> checkOTP({
    required String email,
    required String myotp,
    required String otp,
  }) async {
    try {
      String path = "/api/auth/checkOTP";
      http.Response res = await http
          .post(
            Uri.http(_url, path),
            headers: _headers,
            body: jsonEncode({"email": email, "myOTP": myotp, "otp": otp}),
          )
          .timeout(_requestDuration);
      var profilePic = '';
      var user = User(
          id: '',
          email: '',
          mobile: '',
          name: '',
          isPending: '',
          token: '',
          profilePic: profilePic);
      user.id = jsonDecode(res.body)["user"]["_id"];
      user.email = jsonDecode(res.body)["user"]["email"];
      user.mobile = jsonDecode(res.body)["user"]["mobile"];
      user.name = jsonDecode(res.body)["user"]["name"];
      return user;
    } on SocketException {
      throw _socketExceptionMessage;
    } catch (e) {
      throw _otherExceptionMessage;
    }
  }

  static Future<dynamic> me() async {
    try {
      String path = "/api/auth/me";
      http.Response res = await http.post(
        Uri.http(_url, path),
        headers: {
          'x-authorization-token': 'berear ${user}',
        },
      ).timeout(_requestDuration);
      if (res.body.isNotEmpty) {
        return jsonDecode(res.body);
      }
    } on SocketException {
      throw _socketExceptionMessage;
    } catch (e) {
      throw _otherExceptionMessage;
    }
  }

  static Future<bool> lastRequestStatus() async {
    try {
      String path = "api/request/getRequest";
      var token;
      http.Response res = await http.post(
        Uri.http(_url, path),
        headers: {
          'x-authorization-token': "berear ${user}",
          'Content-Type': 'application/json',
          'accept': 'application/json',
        },
      );
      var reqs = jsonDecode(res.body)["requests"];
      if (reqs.length > 0) {
        _setRequestObject(jsonDecodedResponse: reqs[reqs.length - 1]);
        return true;
      }
      return false;
    } on SocketException {
      throw _socketExceptionMessage;
    } catch (e) {
      throw _otherExceptionMessage;
    }
  }

  static Future<bool> makeRequest({
    required String reason,
    required String returnDateAndTime,
    required String leaveDateAndTime,
    required String name,
  }) async {
    try {
      String path = "api/request/";
      http.Response res = await http
          .post(
            Uri.http(_url, path),
            headers: {
              'x-authorization-token': "berear ${user}",
              'Content-Type': 'application/json',
            },
            body: jsonEncode(
              {
                "reason": reason,
                "return": returnDateAndTime,
                "leave": leaveDateAndTime,
                "name": name,
              },
            ),
          )
          .timeout(_requestDuration);
      var jsonDecodedBody = jsonDecode(res.body);
      if (jsonDecodedBody["request"] != null &&
          jsonDecodedBody["user"] != null) {
        _setRequestObject(jsonDecodedResponse: jsonDecodedBody["request"]);
        _setUserObject(jsonDecodedResponse: jsonDecodedBody);
        return true;
      }
      return false;
    } on SocketException {
      throw _socketExceptionMessage;
    } catch (e) {
      throw _otherExceptionMessage;
    }
  }

  static void _setUserObject({
    required dynamic jsonDecodedResponse,
    bool setToken = false,
  }) {
    var user = User(
        id: '',
        email: '',
        mobile: '',
        name: '',
        profilePic: '',
        isPending: '',
        token: '');
    user.id = jsonDecodedResponse["user"]["_id"];
    user.email = jsonDecodedResponse["user"]["email"];
    user.mobile = jsonDecodedResponse["user"]["mobile"];
    user.name = jsonDecodedResponse["user"]["name"];
    user.profilePic = jsonDecodedResponse["user"]["profilePic"];
    user.isPending = jsonDecodedResponse["user"]["isPending"];
    if (setToken) {
      user.token = jsonDecodedResponse["token"];
    }
  }

  static void _setRequestObject({dynamic jsonDecodedResponse}) {
    if (req == null || req!.request == null) {
      req = YourClassContainingRequest(
        request: Request(
          id: '',
          requestStatus: '',
          reason: '',
          leaveDateAndTime: '',
          returnDateAndTime: '',
        ),
      );
    }
    req!.request!.id = jsonDecodedResponse["_id"];
    req!.request!.requestStatus = jsonDecodedResponse["approved"];
    req!.request!.reason = jsonDecodedResponse["reason"];
    req!.request!.returnDateAndTime = jsonDecodedResponse["return"];
    req!.request!.leaveDateAndTime = jsonDecodedResponse["leave"];
  }
}

mixin token {}

mixin user {
  var token;

  bool? get isPending => null;
}

class User {
  String id;
  String email;
  String mobile;
  String name;
  String profilePic;
  String isPending;
  String token;

  User({
    required this.id,
    required this.email,
    required this.mobile,
    required this.name,
    required this.profilePic,
    required this.isPending,
    required this.token,
  });
}

class YourClassContainingRequest {
  Request? request;

  YourClassContainingRequest({this.request});
}

class Request {
  String id;
  String requestStatus;
  String reason;
  String leaveDateAndTime;
  String returnDateAndTime;

  Request({
    required this.id,
    required this.requestStatus,
    required this.reason,
    required this.leaveDateAndTime,
    required this.returnDateAndTime,
  });
}

YourClassContainingRequest? req;
