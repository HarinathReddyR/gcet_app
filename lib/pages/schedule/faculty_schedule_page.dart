import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FacultySchedulePage extends StatefulWidget {
  const FacultySchedulePage({Key? key}) : super(key: key);

  @override
  _FacultySchedulePageState createState() => _FacultySchedulePageState();
}

class _FacultySchedulePageState extends State<FacultySchedulePage> {
  Color ncolor = Colors.blue;

  DateTime _selectedDate = DateTime.now();
  List<String> days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
  int selectedDayIndex = 0;

  @override
  void initState() {
    super.initState();
    // Set default selected day to the current day
    selectedDayIndex = (_selectedDate.weekday - 1) % 6; // Weekday ranges from 1 (Monday) to 7 (Sunday)
  }

  // Sample weekly schedule data for faculty
  Map<String, List<Map<String, String>>> weeklySchedule = {
    "Monday": [
      {
        "startTime": "09:00",
        "endTime": "10:00",
        "class": "CSE - A",
        "location": "Room 101"
      },
      {
        "startTime": "11:00",
        "endTime": "12:00",
        "class": "CSE - B",
        "location": "Room 102"
      },
      {
        "startTime": "14:00",
        "endTime": "15:00",
        "class": "CSE - C",
        "location": "Room 103"
      },
    ],
    "Tuesday": [
      {
        "startTime": "10:00",
        "endTime": "11:00",
        "class": "Math - A",
        "location": "Room 201"
      },
      // Add other days...
    ],
    // Continue adding for Wednesday to Saturday...
  };

  void markAttendance(String className, String timeRange) {
    print("Attendance marked for class: $className at $timeRange");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Attendance marked for class: $className')),
    );
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
    String dayOfWeek = days[selectedDayIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Schedule',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          _dayPicker(),
          const SizedBox(height: 15),
          Expanded(
            child: weeklySchedule.containsKey(dayOfWeek)
                ? ListView(
                    children: weeklySchedule[dayOfWeek]!.map((classItem) {
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
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      classItem["class"]!,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      classItem["location"]!,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
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
                  )
                : const Center(
                    child: Text("No classes scheduled for today"),
                  ),
          ),
        ],
      ),
    );
  }

  _dayPicker() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        itemBuilder: (context, index) {
          bool isSelected = index == selectedDayIndex;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDayIndex = index;
              });
            },
            child: Container(
              width: 100,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blue, width: 2),
              ),
              child: Center(
                child: Text(
                  days[index],
                  style: TextStyle(
                    fontSize: 16,
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
