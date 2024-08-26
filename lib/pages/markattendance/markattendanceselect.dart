import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gcet_app/pages/markattendance/markattendance.dart';
import 'package:gcet_app/theme/theme.dart';
import 'package:intl/intl.dart';

class MarkAttendanceSelectPage extends StatefulWidget {
  const MarkAttendanceSelectPage({super.key});

  @override
  State<MarkAttendanceSelectPage> createState() =>
      _MarkAttendanceSelectPageState();
}

class _MarkAttendanceSelectPageState extends State<MarkAttendanceSelectPage> {
  final List<String> batchlist = <String>['1', '2', '3', '4'];
  final List<String> branchlist = <String>[
    'CSE',
    'ECE',
    'CIV',
    'IOT',
    'EEE',
    'MECH',
    'AI',
  ];
  final List<String> sectionlist = <String>['A', 'B', 'C', 'D'];

  String batchdropdownValue = '1';
  String branchdropdownValue = 'CSE';
  String sectiondropdownValue = 'A';

  void _navigateToMarkAttendance() {
    if (batchdropdownValue.isEmpty ||
        branchdropdownValue.isEmpty ||
        sectiondropdownValue.isEmpty) {
      // Show error message if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
    } else {
      // Navigate to MarkAttendance page with parameters
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MarkAttendance(
            year: batchdropdownValue,
            branch: branchdropdownValue,
            section: sectiondropdownValue,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heading("Mark Attendance"),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildDropdown(
                          label: "Select Year",
                          value: batchdropdownValue,
                          items: batchlist,
                          onChanged: (String? newValue) {
                            setState(() {
                              batchdropdownValue = newValue!;
                            });
                          },
                        ),
                        const SizedBox(height: 8),
                        _buildDropdown(
                          label: "Branch",
                          value: branchdropdownValue,
                          items: branchlist,
                          onChanged: (String? newValue) {
                            setState(() {
                              branchdropdownValue = newValue!;
                            });
                          },
                        ),
                        const SizedBox(height: 8),
                        _buildDropdown(
                          label: "Section",
                          value: sectiondropdownValue,
                          items: sectionlist,
                          onChanged: (String? newValue) {
                            setState(() {
                              sectiondropdownValue = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
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
              onPressed: _navigateToMarkAttendance,
              child: const Text(
                "Daily Attendance",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
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

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // Grey shadow color
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 4), // Shadow position
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          subheading(label),
          DropdownButton<String>(
            value: value,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.blue),
            underline: Container(
              height: 2,
              color: Colors.blue,
            ),
            onChanged: onChanged,
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
