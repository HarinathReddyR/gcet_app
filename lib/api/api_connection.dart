import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:gcet_app/models/attendance_model.dart';
import 'package:gcet_app/models/forgotpass.dart';
import 'package:gcet_app/models/schedule_model.dart';
import 'package:http/http.dart' as http;
import 'package:gcet_app/models/api_model.dart';
import 'package:image_picker/image_picker.dart';

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

Future<void> postEvent(
    String title, String description, String date, String venue, List<XFile> imageFileList) async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse("http://localhost:3000/api/events"),
  );

  request.fields['title'] = title;
  request.fields['description'] = description;
  request.fields['date'] = date;
  request.fields['venue'] = venue;

  for (int i = 0; i < imageFileList.length; i++) {
    // For web
    if (kIsWeb) {
      Uint8List bytes = await imageFileList[i].readAsBytes();
      request.files.add(http.MultipartFile.fromBytes(
        'images',
        bytes,
        filename: imageFileList[i].name,
      ));
    } else {
      request.files.add(await http.MultipartFile.fromPath(
        'images',
        imageFileList[i].path,
        filename: imageFileList[i].name,
      ));
    }
  }

  try {
    var response = await request.send();
    if (response.statusCode == 200) {
      print('Event posted successfully');
    } else {
      print('Failed to post event: ${response.statusCode}');
    }
  } catch (e) {
    print('Error posting event: $e');
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
