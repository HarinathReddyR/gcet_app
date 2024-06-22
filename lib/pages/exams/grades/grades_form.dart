import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcet_app/common/loading_indicator.dart';
import 'package:gcet_app/models/subjectmarks.dart';
import 'package:gcet_app/pages/exams/grades/bloc/grades_bloc.dart';
import 'package:gcet_app/pages/exams/grades/datatable.dart';

class GradeForm extends StatefulWidget {
  final String rollNo;
  const GradeForm({super.key, required this.rollNo});

  @override
  State<GradeForm> createState() => _GradeFormState(rollNo: rollNo);
}

class _GradeFormState extends State<GradeForm> {
  final String rollNo;
  bool _ismidshow = false;
  bool _iscbtshow = false;
  List<List<String>> mid = [
    ["iot", "25"],
    ["sml", "25"]
  ];
  final List<Subject> subjects = [
    Subject(name: 'COA', score: '10.0/20.0', assignments: [
      Assignment(name: 'Assignment 1', marks: '9/10'),
      Assignment(name: 'Assignment 2', marks: '7/10'),
    ]),
    Subject(name: 'DAA', score: '17.0/20.0', assignments: [
      Assignment(name: 'Assignment 1', marks: '9/10'),
      Assignment(name: 'Assignment 2', marks: '7/10'),
    ]),
    Subject(name: 'P&S', score: '18.0/20.0', assignments: [
      Assignment(name: 'Assignment 1', marks: '9/10'),
      Assignment(name: 'Assignment 2', marks: '7/10'),
    ]),
    Subject(name: 'DBMS', score: '18.0/20.0', assignments: [
      Assignment(name: 'Assignment 1', marks: '10/10'),
      Assignment(name: 'Assignment 2', marks: '10/10'),
    ]),
  ];
  _GradeFormState({required this.rollNo});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GradeBloc, GradeState>(builder: (context, state) {
      if (state is GradeLoaded) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Grades"),
          ),
          body: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _gradesTable(),
                    const SizedBox(
                      height: 15,
                    ),
                    ExpansionTile(
                      title: const Text("Mid"),
                      trailing: Icon(_ismidshow
                          ? Icons.arrow_drop_up_rounded
                          : Icons.arrow_drop_down_rounded),
                      children: buildSubjectMidMarksList(subjects),
                      onExpansionChanged: (bool expanded) {
                        setState(() {
                          _ismidshow = expanded;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ExpansionTile(
                      title: const Text("cbt"),
                      trailing: Icon(_iscbtshow
                          ? Icons.arrow_drop_up_rounded
                          : Icons.arrow_drop_down_rounded),
                      children: buildSubjectMidMarksList(subjects),
                      onExpansionChanged: (bool expanded) {
                        setState(() {
                          _iscbtshow = expanded;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Assignments",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),

                      //)
                    ),
                    Padding(
                        padding: EdgeInsets.all(4),
                        child: Column(
                          children: buildSubjectList(subjects),
                        )),
                  ],
                ),
              ),
            ),
          ),
        );
      } else if (state is GradeLoading) {
        return const LoadingIndicator();
      }
      return Container(
        height: 21,
        color: Colors.red,
        child: Text("error"),
      );
    });
  }

  _gradesTable() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(
              label: Expanded(
                child: Text(
                  'Subject',
                  style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Grade',
                  style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'credits',
                  style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
          rows: const <DataRow>[
            DataRow(
              cells: <DataCell>[
                DataCell(Text('DAA')),
                DataCell(Text('9.8')),
                DataCell(Text('4')),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('DAA')),
                DataCell(Text('9.8')),
                DataCell(Text('4')),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('DAA')),
                DataCell(Text('9.8')),
                DataCell(Text('4')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildSubjectMidMarksList(List<Subject> subjects) {
    return subjects.map((subject) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: ListTile(
          tileColor: Colors.grey.shade200,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          title:
              Text(subject.name, style: TextStyle(fontWeight: FontWeight.bold)),
          trailing: Text(subject.score,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          // Divider(),
        ),
      );
    }).toList();
  }

  List<Widget> buildAssignmentList(List<Assignment> assignments) {
    return assignments.map((assignment) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: ListTile(
          tileColor: Colors.grey.shade200,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          title: Text(assignment.name,
              style: TextStyle(fontWeight: FontWeight.bold)),
          trailing: Text(assignment.marks,
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      );
    }).toList();
  }

  List<Widget> buildSubjectList(List<Subject> subjects) {
    return subjects.map((subject) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          title:
              Text(subject.name, style: TextStyle(fontWeight: FontWeight.bold)),
          children: buildAssignmentList(subject.assignments),
        ),
      );
    }).toList();
  }
}
