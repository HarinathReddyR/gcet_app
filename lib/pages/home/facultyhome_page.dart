import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FacultyHomePage extends StatefulWidget {
  const FacultyHomePage({Key? key}) : super(key: key);

  @override
  _FacultyHomePageState createState() => _FacultyHomePageState();
}

class _FacultyHomePageState extends State<FacultyHomePage> {
  EdgeInsetsGeometry padding = const EdgeInsets.fromLTRB(12.0, 25.0, 12.0, 25.0);
  Color textColor = Colors.white;
  Color ncolor = Colors.blue;

  // Sample schedule data for faculty
  List<Map<String, String>> facultySchedule = [
    {
      "startTime": "09:00",
      "endTime": "10:00",
      "branch": "CSE - A",
      "location": "Room 101"
    },
    {
      "startTime": "11:00",
      "endTime": "12:00",
      "branch": "CSE - B",
      "location": "Room 102"
    },
    {
      "startTime": "14:00",
      "endTime": "15:00",
      "branch": "CSE - C",
      "location": "Room 103"
    },
  ];

  void markAttendance(String className, String timeRange) {
    print("Attendance marked for class: $className at $timeRange");
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text('Attendance marked for class: $className')),
    // );
  }

  DateTime _parseTime(String timeString) {
    final format = DateFormat('HH:mm');
    return format.parse(timeString);
  }

  DateTime _normalizeToDate(DateTime date, DateTime time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  bool _currentSchedule(String fromTime, String toTime) {
    final now = DateTime.now();
    final startTime = _normalizeToDate(now, _parseTime(fromTime));
    final endTime = _normalizeToDate(now, _parseTime(toTime));
    return now.isAfter(startTime) && now.isBefore(endTime);
  }

  @override
  Widget build(BuildContext context) {
    // String currentDate = DateFormat.yMMMMd().format(DateTime.now());

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10.0),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Today's Schedule",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: facultySchedule.map((classItem) {
                  bool current = _currentSchedule(
                    classItem['startTime']!,
                    classItem['endTime']!,
                  );
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: ncolor,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.class_, color: Colors.white),
                            ),
                            Container(
                              height: 100,
                              width: 2,
                              color: Colors.grey[300],
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: current ? Colors.blue : ncolor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "${classItem["startTime"]} - ${classItem["endTime"]}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  classItem["branch"]!,
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  classItem["location"]!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      markAttendance(
                                        classItem["branch"]!,
                                        "${classItem["startTime"]} - ${classItem["endTime"]}",
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                    ),
                                    child: Text(
                                      'Mark Attendance',
                                      style: TextStyle(color: ncolor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
