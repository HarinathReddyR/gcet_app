import 'dart:async';
import 'dart:convert';
import 'package:gcet_app/models/attendance_model.dart';
import 'package:gcet_app/models/forgotpass.dart';
import 'package:gcet_app/models/schedule_model.dart';
import 'package:http/http.dart' as http;
import 'package:gcet_app/models/api_model.dart';

const _base = "https://home-hub-app.herokuapp.com";
const _tokenURL = _base + _tokenEndpoint;

const _scheme = "http";
const _host = "localhost";
const _port = 3000;
const _tokenEndpoint = "/api/login/";
const _attendancepath = "/api/attendance";
const _schedulepath = "/api/schedule";
const _forgotPassword = "/api/login/OTP";

Future<Token> getToken(UserLogin userLogin) async {
  // print(_tokenURL);
  final http.Response response = await http.post(
    Uri(scheme: _scheme, host: _host, port: _port, path: _tokenEndpoint),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userLogin.toDatabaseJson()),
  );
  if (response.statusCode == 200) {
    return Token.fromJson(json.decode(response.body));
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<List<AttendanceModel>> getAttendance(String user) async {
  // print(_tokenURL);
  final http.Response response = await http.get(
      Uri(scheme: _scheme, host: _host, port: _port, path: _attendancepath));

  if (response.statusCode == 200) {
    List<dynamic> attenMaps = jsonDecode(response.body);
    return attenMaps
        .map((attenMap) => AttendanceModel.fromJson(attenMap))
        .toList();
  } else {
    print(response.body.toString());
    throw Exception(json.decode(response.body));
  }
}

Future<List<ScheduleModel>> getSchedule(String user, DateTime date) async {
  // print(_tokenURL);
  final http.Response response = await http.get(Uri(
    scheme: _scheme,
    host: _host,
    port: _port,
    path: _schedulepath,
    queryParameters: {
      'rollNo': user,
      'date': date.toIso8601String(),
    },
  ));

  if (response.statusCode == 200) {
    List<dynamic> scheduleMap = jsonDecode(response.body);
    return scheduleMap
        .map((scheduleMap) => ScheduleModel.fromJson(scheduleMap))
        .toList();
  } else {
    print(response.body.toString());
    throw Exception(json.decode(response.body));
  }
}

Future<Forgot> forgotsubmit(String username) async {
  final http.Response response = await http.get(Uri(
    scheme: _scheme,
    host: _host,
    port: _port,
    path: _forgotPassword,
    queryParameters: {
      'username': username,
    },
  ));
  if (response.statusCode == 200) {
    Map<String, dynamic> forgotMap = jsonDecode(response.body);
    var a = Forgot.fromJson(forgotMap);
    return a;
  } else {
    print(response.body.toString());
    throw Exception(json.decode(response.body));
  }
}
