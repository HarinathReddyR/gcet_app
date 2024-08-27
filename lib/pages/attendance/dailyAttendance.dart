import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gcet_app/api/api_connection.dart';
import 'package:gcet_app/models/monthattendance_model.dart';
import 'package:gcet_app/models/period_nodel.dart';
import 'package:table_calendar/table_calendar.dart';

class DailyAttendanceList extends StatefulWidget {
  const DailyAttendanceList({super.key});

  @override
  State<DailyAttendanceList> createState() => _DailyAttendanceListState();
}

class _DailyAttendanceListState extends State<DailyAttendanceList> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  Map<DateTime, List<MonthAttendanceModel>> _attendanceData = {};
  List<PeriodModel> _periodsForSelectedDay = [];

  @override
  void initState() {
    super.initState();
    _fetchMonthData(_focusedDay);
    _fetchDayData(_focusedDay);
  }

  Future<void> _fetchMonthData(DateTime month) async {
    try {
      final data = await fetchMonthdata(month);
      setState(() {
        _attendanceData = data;
      });
    } catch (e) {
      print('Error fetching month data: $e');
    }
  }

  Future<void> _fetchDayData(DateTime selectedDay) async {
    try {
      final periods = await fetchPeriodsForDay(selectedDay);
      setState(() {
        _periodsForSelectedDay = periods;
      });
    } catch (e) {
      print('Error fetching day data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appbar(),
        body: LayoutBuilder(builder: (context, constraints) {
          double calendarWidth = constraints.maxWidth;
          double calendarHeight = calendarWidth * 0.5;
          return Column(
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                calendarFormat: CalendarFormat.month,
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;

                    final attendance = _attendanceData[selectedDay];
                    if (attendance != null && attendance.isNotEmpty) {
                      final isHoliday =
                          attendance.any((item) => item.isHoliday);
                      if (isHoliday) {
                        // Display holiday message
                        setState(() {
                          _periodsForSelectedDay = [];
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Selected day is a holiday.'),
                          ),
                        );
                        return;
                      }
                    }

                    _fetchDayData(
                        selectedDay); // Fetch periods for the selected day
                  });
                },
                onPageChanged: (focusedDay) {
                  setState(() {
                    _focusedDay = focusedDay;
                    _fetchMonthData(
                        focusedDay); // Fetch attendance data for the month
                  });
                },
                enabledDayPredicate: (day) {
                  // Disable Sundays
                  return day.weekday != DateTime.sunday;
                },
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, focusedDay) {
                    final attendance = _attendanceData[day];

                    if (attendance != null && attendance.isNotEmpty) {
                      final isHoliday =
                          attendance.any((item) => item.isHoliday);

                      if (isHoliday) {
                        return Center(
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${day.day}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        final totalAttended = attendance.fold<int>(
                            0, (sum, item) => sum + item.attended);
                        final totalClasses = attendance.fold<int>(
                            0, (sum, item) => sum + item.total);
                        final percentage = totalClasses > 0
                            ? (totalAttended / totalClasses)
                            : 0.0;

                        final indicatorColor = Colors.green;
                        final backgroundColor = Colors.red;

                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularProgressIndicator(
                                value: 1.0, // Full circle for background color
                                backgroundColor: backgroundColor,
                                strokeWidth: 5,
                              ),
                              CircularProgressIndicator(
                                value:
                                    percentage, // Percentage of attended classes
                                backgroundColor:
                                    backgroundColor, // Transparent background for percentage
                                color: indicatorColor,
                                strokeWidth: 5,
                              ),
                              Center(
                                child: Text(
                                  '${day.day}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    } else {
                      return Center(child: Text(day.day.toString()));
                    }
                  },
                ),
                headerStyle: const HeaderStyle(formatButtonVisible: false),
              ),
              Expanded(
                child: _buildPeriodDetails(),
              ),
            ],
          );
        }));
  }

  _appbar() {
    return AppBar(
      backgroundColor: Colors.white, // Set AppBar background color to white
      leading: IconButton(
        icon: const Icon(CupertinoIcons.back, color: Colors.black),
        onPressed: () {
          Navigator.pop(context); // Navigate back to the previous page
        },
      ),
      title: Text('Daily Attendance'), // Adjust this as per your theme
      actions: [
        Stack(
          children: [
            IconButton(
              icon: Icon(Icons.more_vert_sharp, color: Colors.black),
              onPressed: () {
                //_showMenu(context);
              },
            ),
          ],
        ),
      ],
      elevation: 0, // Remove AppBar shadow
    );
  }

  Widget _buildPeriodDetails() {
    if (_periodsForSelectedDay.isEmpty) {
      return Center(
          child: Text('No periods for the selected day or it is a holiday.'));
    }

    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Periods for ${_selectedDay.toLocal()}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: _periodsForSelectedDay.length,
              itemBuilder: (context, index) {
                final period = _periodsForSelectedDay[index];
                return ListTile(
                  title: Text(period.subjectName),
                  subtitle: Text('Faculty: ${period.facultyName}'),
                  trailing: Icon(
                    period.isPresent ? Icons.check_circle : Icons.cancel,
                    color: period.isPresent ? Colors.green : Colors.red,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
