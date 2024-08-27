import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcet_app/models/attendance_model.dart';
import 'package:gcet_app/pages/attendance/attendance_barchart.dart';
import 'package:gcet_app/pages/attendance/bloc/atten_bloc.dart';
import 'package:gcet_app/pages/attendance/dailyAttendance.dart';
import 'package:gcet_app/theme/theme.dart';
import 'package:percent_indicator/percent_indicator.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final containerWidth = screenWidth - 26;

    return Scaffold(
      appBar: AppBar(
        title: const Text("GCET Attendance"),
      ),
      body: BlocProvider(
        create: (context) =>
            AttendanceBloc()..add(const FetchAttendance("21R11A05k0")),
        child: BlocBuilder<AttendanceBloc, AttendanceState>(
          builder: (context, state) {
            if (state is AttendanceLoadedState) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _totalAttendance(
                              containerWidth: containerWidth,
                              totalAttendance: state.totalAttendance,
                            ),
                            const SizedBox(height: 8),
                            Center(
                              child: subheading("Subject Wise"),
                            ),
                            const SizedBox(height: 12),
                            BarChartSample3(subjects: state.atten),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromARGB(255, 25, 90, 211),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DailyAttendanceList()),
                        );
                      },
                      child: const Text(
                        "Daily Attendance",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              );
            }
            if (state is AttendanceLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is AttendanceErrorState) {
              return Center(child: Text("Error: ${state.error}"));
            }
            return const Center(child: Text("An unknown error occurred"));
          },
        ),
      ),
    );
  }
}

class _totalAttendance extends StatelessWidget {
  const _totalAttendance({
    super.key,
    required this.containerWidth,
    required this.totalAttendance,
  });

  final double containerWidth;
  final TotalAttendance totalAttendance;

  @override
  Widget build(BuildContext context) {
    final percent = totalAttendance.total > 0
        ? totalAttendance.attended / totalAttendance.total
        : 0.0;

    return Container(
      width: containerWidth,
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 3,
            spreadRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 5,
          ),
          subheading("Overall Attendance"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 3,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Total: ${totalAttendance.total}",
                      style:
                          TextStyle(fontSize: 15, color: Colors.grey.shade600),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Attended: ${totalAttendance.attended}",
                      style:
                          TextStyle(fontSize: 15, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CircularPercentIndicator(
                  radius: 38.0,
                  lineWidth: 13.0,
                  animation: true,
                  percent: percent,
                  center: Text(
                    "${(percent * 100).toStringAsFixed(1)}%",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.purple,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5)
        ],
      ),
    );
  }
}
