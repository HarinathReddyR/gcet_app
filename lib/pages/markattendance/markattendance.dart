import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gcet_app/api/api_connection.dart';
import 'package:gcet_app/models/schedule_model.dart';
import 'package:gcet_app/models/stu_present_model.dart';
import 'package:intl/intl.dart';

class MarkAttendance extends StatefulWidget {
  final String year;
  final String branch;
  final String section;

  const MarkAttendance({
    super.key,
    required this.year,
    required this.branch,
    required this.section,
  });

  @override
  State<MarkAttendance> createState() => _MarkAttendanceState();
}

class _MarkAttendanceState extends State<MarkAttendance> {
  String selectedPeriodName = 'Period 1';
  DateTime _selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();

  List<ScheduleModel> periods = [];
  List<StudentPresent> students = [];
  late ScheduleModel selectedPeriod;

  bool isDateSelected = false;
  bool isPeriodSelected = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime today = DateTime.now();
    DateTime oneYearBack = today.subtract(Duration(days: 365));
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: oneYearBack,
      lastDate: today, // Restrict to current day only
    );

    if (newSelectedDate != null) {
      setState(() {
        _selectedDate = DateTime(
          newSelectedDate.year,
          newSelectedDate.month,
          newSelectedDate.day,
        );

        dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
        isDateSelected = true;
        isPeriodSelected = false;
        students = [];
        _fetchPeriods(); // Fetch periods after selecting the date
      });
    }
  }

  Future<void> _fetchPeriods() async {
    try {
      final fetchedPeriods = await getSchedule("21r11a05k0", _selectedDate,
          widget.branch, widget.year, widget.section);
      setState(() {
        periods = fetchedPeriods;
        if (periods.isNotEmpty) {
          selectedPeriodName = periods.first.subName;
          selectedPeriod = periods.first;
          isPeriodSelected = true;
          _fetchStudents(); // Fetch students after fetching periods
        }
      });
    } catch (e) {
      // Handle exceptions (e.g., show an error message)
      print('Error fetching periods: $e');
    }
  }

  Future<void> _fetchStudents() async {
    if (isPeriodSelected) {
      try {
        final fetchedStudents = await fetchStudentPresent(_selectedDate,
            selectedPeriod, widget.branch, widget.year, widget.section);
        setState(() {
          students = fetchedStudents;
        });
      } catch (e) {
        // Handle exceptions (e.g., show an error message)
        print('Error fetching students: $e');
      }
    }
  }

  void _onPeriodChanged(ScheduleModel? newPeriod) {
    if (newPeriod != null) {
      setState(() {
        selectedPeriodName = newPeriod.subName;
        selectedPeriod = newPeriod;
        isPeriodSelected = true;
        _fetchStudents(); // Fetch students when period changes
      });
    }
  }

  void _showConfirmationDialog() {
    int presentCount = students.where((s) => s.isPresent ?? false).length;
    int absentCount = students.length - presentCount;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Submission'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Total Students: ${students.length}'),
              Text('Present: $presentCount'),
              Text('Absent: $absentCount'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cancel action
              },
              child: Text('Cancel', style: TextStyle(color: Colors.blue)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Confirm action
                _submitAttendance(); // Implement your submission logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button color
                elevation: 5, // Button elevation
              ),
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _submitAttendance() async {
    // Implement your submission logic here
    // For example:
    try {
      // Submit the attendance data to the backend
      await submitAttendanceData(selectedPeriod, _selectedDate, students);
      // Show a success message or navigate to another screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Attendance submitted successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      // Handle exceptions (e.g., show an error message)
      print('Error submitting attendance: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Attendance not submitted!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: TextField(
                controller: dateController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Select Date',
                ),
                readOnly: true, // Make the TextField read-only
                onTap: () {
                  _selectDate(context);
                },
              ),
            ),
            SizedBox(height: 10),
            if (isDateSelected) ...[
              _buildPeriodSelector(),
              const SizedBox(height: 10),
            ],
            Expanded(
              child: students.isNotEmpty
                  ? ListView.builder(
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        return _buildStudentCard(students[index]);
                      },
                    )
                  : Center(
                      child: isDateSelected
                          ? CircularProgressIndicator() // Loading indicator if date is selected
                          : SizedBox
                              .shrink(), // No content if date is not selected
                    ),
            ),
            if (isDateSelected && isPeriodSelected) ...[
              SizedBox(height: 10),
              Container(
                height: 40,
                width: MediaQuery.of(context)
                    .size
                    .width, // Set the width to the screen width
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor:
                        Color.fromARGB(255, 25, 90, 211), // Button color
                    elevation: 5, // Button elevation
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Circular edges
                    ),
                  ),
                  onPressed:
                      _showConfirmationDialog, // Show the confirmation dialog
                  child: const Text(
                    "Submit",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  AppBar _appbar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(CupertinoIcons.back, color: Colors.black),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const Text(
        "Mark Attendance",
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
      ),
      actions: [
        _buildSearchIcon(), // Assuming you have implemented this
      ],
      elevation: 0,
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<ScheduleModel>(
        value: periods.isNotEmpty
            ? periods.firstWhere((p) => p.subName == selectedPeriodName,
                orElse: () => periods.first)
            : null,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.black),
        underline: Container(
          height: 2,
          color: Colors.grey,
        ),
        onChanged: _onPeriodChanged,
        items: periods
            .map<DropdownMenuItem<ScheduleModel>>((ScheduleModel period) {
          return DropdownMenuItem<ScheduleModel>(
            value: period,
            child: Text(period.subName),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStudentCard(StudentPresent student) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text('Roll No: "${student.rollNo ?? "N/A"}"'),
        trailing: Switch(
          value: student.isPresent ?? false,
          onChanged: (bool value) {
            setState(() {
              student.isPresent = value;
            });
            // Optionally, send this change to the backend
          },
          activeColor: Colors.green,
          inactiveThumbColor: Colors.red,
          inactiveTrackColor: Colors.red.withOpacity(0.3),
        ),
      ),
    );
  }

  Widget _buildSearchIcon() {
    // Your search icon implementation
    return IconButton(
      icon: const Icon(Icons.search, color: Colors.black),
      onPressed: () {
        // Handle search action
      },
    );
  }
}
