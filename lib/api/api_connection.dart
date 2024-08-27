import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:gcet_app/db/user_dao.dart';
import 'package:gcet_app/models/attendance_model.dart';
import 'package:gcet_app/models/customform_ques.dart';
import 'package:gcet_app/models/book_model.dart';
import 'package:gcet_app/models/forgotpass.dart';
import 'package:gcet_app/models/monthattendance_model.dart';
import 'package:gcet_app/models/period_nodel.dart';
import 'package:gcet_app/models/schedule_model.dart';
import 'package:gcet_app/models/stu_present_model.dart';
import 'package:http/http.dart' as http;
import 'package:gcet_app/models/api_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

const _base = "https://home-hub-app.herokuapp.com";
const _tokenURL = _base + _tokenEndpoint;
// 192.168.1.5
const _scheme = "http";
const _host = "localhost";
const _port = 3000;
const _tokenEndpoint = "/api/login/";
const _fetchMonthBooks = "/api/attendance/month";
const _schedulepath = "/api/schedule";
const _forgotPassword = "/api/login/OTP";
const _freshBooks = "/api/library/freshBooks";
const _toggleList = "/api/library/toggle";

const _attendancepath = "/api/attendance/subjectwise";
const _fetchdayAttendance = "/api/attendance/date";
const _studentmarkpath = "/api/attendance/mark";
const _studentpresentpath = "/api/attendance/period";
const _overallattendancepath = "/api/attendance/total";

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
    String title,
    String description,
    String date,
    String venue,
    List<XFile> imageFileList,
    bool reg,
    List<Question> ques) async {
  String token = await UserDao().getPersistToken(0);
  var request = http.MultipartRequest(
    'POST',
    Uri.parse("http://localhost:3000/api/events"),
  );
  request.fields['title'] = title;
  request.fields['description'] = description;
  request.fields['date'] = date;
  request.fields['venue'] = venue;
  request.fields['reg'] = (reg) ? jsonEncode(1) : jsonEncode(0);
  request.fields['ques'] = jsonEncode(ques);
  request.headers['Authorization'] = 'Bearer $token';

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

Future<void> postBook(String title, String author, String about,
    PlatformFile selectedFile) async {
  //request.fields['venue'] = venue;

  try {
    final uri = Uri.parse(
        'http://localhost:3000/api/library/add?rollNo=\'ab\''); // Replace with your server endpoint

    final request = http.MultipartRequest('POST', uri)
      ..files.add(
        http.MultipartFile.fromBytes(
          'files', // Field name expected by the server
          selectedFile!.bytes!,
          filename: selectedFile!.name,
          contentType: MediaType('application', 'pdf'), // Content type
        ),
      );
    request.fields['title'] = title;
    request.fields['about'] = about;
    request.fields['author'] = author;
    final response = await request.send();

    if (response.statusCode == 200) {
      print('File uploaded successfully!');
    } else {
      print('Failed to upload file. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error occurred while uploading file: $e');
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

Future<TotalAttendance> getOverallAttendance(String user) async {
  // print(_tokenURL);

  try {
    final http.Response response = await http.get(Uri(
        scheme: _scheme,
        host: _host,
        port: _port,
        path: _overallattendancepath));

    if (response.statusCode == 200) {
      // Parse the JSON response
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return TotalAttendance.fromJson(jsonResponse);
    } else {
      // Handle non-200 responses
      print('Failed to load attendance: ${response.body}');
      throw Exception('Failed to load attendance');
    }
  } catch (e) {
    // Handle any other errors
    print('Error fetching attendance: $e');
    throw Exception('Error fetching attendance');
  }
}

Future<List<ScheduleModel>> getSchedule(String user, DateTime date,
    String branch, String year, String section) async {
  // print(_tokenURL);
  // print(user);
  // print(branch);
  final http.Response response = await http.get(Uri(
    scheme: _scheme,
    host: _host,
    port: _port,
    path: _schedulepath,
    queryParameters: {
      'rollNo': user,
      'branch': branch,
      'year': section,
      'section': section,
      'date': date.toIso8601String()
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

Future<List<Book>> fetchBooks(String category) async {
  final http.Response response = await http.get(Uri(
    scheme: _scheme,
    host: _host,
    port: _port,
    path: _freshBooks,
    queryParameters: {
      'rollNo': '21r11a05k0',
    },
  ));
  //print(response.body);
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((book) => Book.fromJson(book)).toList();
  } else {
    throw Exception('Failed to load fresh arrivals');
  }
}

Future<bool> toggleReadListReqquest(String bookid) async {
  final http.Response response = await http.get(Uri(
    scheme: _scheme,
    host: _host,
    port: _port,
    path: _toggleList,
    queryParameters: {
      'rollNo': '21r11a05k0',
      'BookId': '123',
    },
  ));
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to toggle');
  }
}

Future<Map<DateTime, List<MonthAttendanceModel>>> fetchMonthdata(
    DateTime month) async {
  String formattedMonth =
      '${month.year}-${month.month.toString().padLeft(2, '0')}';
  try {
    final http.Response response = await http.get(Uri(
      scheme: _scheme,
      host: _host,
      port: _port,
      path: _fetchMonthBooks,
      queryParameters: {
        'rollNo': '21r11a05k0',
        'month': formattedMonth,
      },
    ));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);

      List<MonthAttendanceModel> attendanceList = jsonResponse
          .map((item) => MonthAttendanceModel.fromJson(item))
          .toList();

      // Convert list to map
      Map<DateTime, List<MonthAttendanceModel>> attendanceData = {};
      for (var attendance in attendanceList) {
        DateTime date = DateTime.parse(attendance.date.toString());
        if (attendanceData[date] == null) {
          attendanceData[date] = [];
        }
        attendanceData[date]!.add(attendance);
      }

      return attendanceData;
    } else {
      throw Exception(
          'Failed to load month data. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching month data: $e');
    throw Exception('Failed to fetch month data');
  }
}

Future<List<PeriodModel>> fetchPeriodsForDay(DateTime month) async {
  String formattedMonth =
      '${month.year}-${month.month.toString().padLeft(2, '0')}';
  try {
    final http.Response response = await http.get(Uri(
      scheme: _scheme,
      host: _host,
      port: _port,
      path: _fetchdayAttendance,
      queryParameters: {
        'rollNo': '21r11a05k0',
        'month': formattedMonth,
      },
    ));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);

      // Map each item in jsonResponse to a PeriodModel and filter out null values
      List<PeriodModel> periods = jsonResponse
          .map((item) {
            try {
              return PeriodModel.fromJson(item);
            } catch (e) {
              print('Error parsing item: $e');
              return null;
            }
          })
          .whereType<PeriodModel>()
          .toList();

      return periods;
    } else {
      throw Exception('Failed to load fresh arrivals');
    }
  } catch (e) {
    print('Error fetching day attendance data: $e');
    throw Exception('Failed to fetch day data');
  }
}

Future<List<StudentPresent>> fetchStudentPresent(DateTime date,
    ScheduleModel period, String branch, String year, String section) async {
  final http.Response response = await http.get(Uri(
    scheme: _scheme,
    host: _host,
    port: _port,
    path: _studentpresentpath,
    queryParameters: {
      'branch': branch,
      'fromTime': period.fromTime,
      'toTime': period.toTime,
      'subName': period.subName,
      'year': year,
      'section': section,
      'date': date.toIso8601String()
    },
  ));
  if (response.statusCode == 200) {
    // print(jsonDecode(response.body))
    List<dynamic> studentPresent; // = jsonDecode(response.body);
    // print(studentPresent);
    try {
      // print("Raw response: ${response.body}");
      studentPresent = jsonDecode(response.body) as List<dynamic>;
    } catch (e) {
      print("Error decoding JSON: $e");
      throw Exception("Error parsing response");
    }

    if (studentPresent.isEmpty) {
      print("No student data available");
    }
    return studentPresent
        .map((studentMap) =>
            StudentPresent.fromJson(studentMap as Map<String, dynamic>))
        .toList();
  } else {
    print(response.body.toString());
    throw Exception(json.decode(response.body));
  }
}

Future<void> submitAttendanceData(
    ScheduleModel period, DateTime date, List<StudentPresent> students) async {
  // Prepare the request body
  final body = jsonEncode({
    // 'branch': branch,
    // 'year': year,
    // 'section': section,
    'fromTime': period.fromTime,
    'toTime': period.toTime,
    'fid': period.fid,
    'subid': period.subid,
    'date': DateFormat('yyyy-MM-dd').format(date),
    'subName': period.subName,
    'students': students
        .map((student) => {
              'rollNo': student.rollNo,
              'isPresent': student.isPresent,
            })
        .toList(),
  });

  try {
    final response = await http.post(
      Uri(
        scheme: _scheme,
        host: _host,
        port: _port,
        path: _studentmarkpath,
      ),
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print(responseData['message']);
      // print('Attendance submitted successfully');
    } else {
      print('Failed to submit attendance: ${response.body}');
      throw Exception(json.decode(response.body));
    }
  } catch (e) {
    print('Error submitting attendance: $e');
    throw Exception('error while connecting');
  }
}
