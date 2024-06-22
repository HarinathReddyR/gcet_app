import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleItem extends StatelessWidget {
  final String fromTime;
  final String toTime;
  final String subName;
  final String location;
  final IconData icon;
  final Color color;

  ScheduleItem({
    required this.fromTime,
    required this.toTime,
    required this.subName,
    required this.location,
    required this.icon,
    required this.color,
  });

  DateTime _parseTime(String timeString) {
    final format = DateFormat('HH:mm');
    return format.parse(timeString);
  }

  DateTime _normalizeToDate(DateTime date, DateTime time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  bool _isTimePassed(String timeString) {
    final now = DateTime.now();
    final scheduleTime = _normalizeToDate(now, _parseTime(timeString));
    print(scheduleTime);
    bool b = now.isAfter(scheduleTime);
    print(b);
    return now.isAfter(scheduleTime);
  }

  bool _currentSchedule(String fromTime, String toTime) {
    final now = DateTime.now();
    final startTime = _normalizeToDate(now, _parseTime(fromTime));
    final endTime = _normalizeToDate(now, _parseTime(toTime));
    // print(startTime);
    //print(endTime);
    bool b = now.isAfter(startTime) && now.isBefore(endTime);
    // print(b);
    return b;
  }

  @override
  Widget build(BuildContext context) {
    bool isPassed = _isTimePassed(toTime);
    bool current = _currentSchedule(fromTime, toTime);
    //return padding();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white),
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
                color: isPassed
                    ? Colors.green[400]
                    : (current
                        ? Colors.blue
                        : Color.fromARGB(255, 194, 114, 28)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "$fromTime - $toTime",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subName,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    location,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
