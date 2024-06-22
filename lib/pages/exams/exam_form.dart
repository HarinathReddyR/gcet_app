import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcet_app/models/subjectmarks.dart';
import 'package:gcet_app/pages/exams/bloc/exam_bloc.dart';
import 'package:gcet_app/pages/exams/circlular.dart';
import 'package:gcet_app/pages/exams/grades/grades_page.dart';
import 'package:gcet_app/pages/exams/graph.dart';
import 'package:gcet_app/theme/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ExamForm extends StatefulWidget {
  final String rollNo;
  const ExamForm({super.key, required this.rollNo});

  @override
  State<ExamForm> createState() => _ExamFormState(rollNo: rollNo);
}

class _ExamFormState extends State<ExamForm> {
  final String rollNo;
  _ExamFormState({required this.rollNo});
  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appBar(),
      body: BlocBuilder<ExamBloc, ExamState>(builder: (context, state) {
        if (state is ExamLoaded) {
          final List<double> cgpas = [8.8, 9.1, 7.5, 8.0, 8.9, 10.0, 0, 1.2];
          return SingleChildScrollView(
            child: Container(
              //height: screensize.height,
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _upper(),
                    Container(
                      height: 220,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: CircularProgressWidget(cgpa: 8.8),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //SGPAChart(),
                    const Text(
                      "SGPA",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    BarChartSample3(cgpas: cgpas),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Semesters",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: cgpas.length,
                      itemBuilder: (context, index) {
                        return _semesterBox(
                          (index),
                          cgpas[index],
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GradePage(
                                        sem: index,
                                        rollNo: '21r11a05k0',
                                      )),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Container(
          height: 8,
          color: Colors.black,
        );
      }),
    );
  }

  _appBar() {
    return AppBar(
      //surfaceTintColor: Colors.blueAccent,
      title: const Text(
        'Results',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Themes.lightTheme.primaryColor,
      actions: const [
        Icon(
          Icons.person,
          size: 20,
          color: Colors.black,
        ),
        SizedBox(width: 20),
      ],
    );
  }

  _upper() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "hello",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          "Harinath Reddy",
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  _semesterBox(int s, double cgpa, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
            height: 50,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 27, 134, 221).withOpacity(0.7),
            ),
            child: Row(
              children: [
                SizedBox(width: 15),
                Text(
                  s.toString() + "st sem :",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Text(
                  cgpa.toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_right_alt_sharp,
                  color: Colors.white,
                  size: 30,
                ),
                SizedBox(
                  width: 10,
                )
              ],
            )),
      ),
    );
  }

  // _circular(double cgpa) {
  //   double percentage = cgpa / 10; // Convert CGPA to percentage
  //   Color getColor() {
  //     if (percentage >= 0.8) {
  //       return Colors.green;
  //     } else if (percentage >= 0.5) {
  //       return Colors.orange;
  //     } else {
  //       return Colors.red;
  //     }
  //   }

  //   String getText() {
  //     double percentage = cgpa / 10;
  //     if (percentage >= 0.8) {
  //       return "outstandin";
  //     } else if (percentage >= 0.5) {
  //       return "can do better";
  //     } else {
  //       return "improve";
  //     }
  //   }

  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Text(
  //         "cgpa",
  //         style: TextStyle(
  //           fontSize: 20,
  //           fontWeight: FontWeight.w500,
  //         ),
  //       ),
  //       SizedBox(height: 10.0),
  //       CircularPercentIndicator(
  //         radius: 65,
  //         lineWidth: 10,
  //         percent: percentage,
  //         center: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Text(
  //               "${(percentage * 10).toStringAsFixed(2)}",
  //               style: TextStyle(fontSize: 19, color: Colors.black),
  //             ),
  //           ],
  //         ),
  //         progressColor: getColor(),
  //         backgroundColor: Colors.grey[800]!,
  //         circularStrokeCap: CircularStrokeCap.round,
  //       ),
  //       SizedBox(height: 10.0),
  //       Text(
  //         "can do better",
  //         style: TextStyle(fontSize: 18.0, color: getColor()),
  //       ),
  //     ],
  //   );
  // }
}
