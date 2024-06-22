import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcet_app/pages/semester/bloc/sem_bloc.dart';
import 'package:gcet_app/pages/semester/subject/sub_page.dart';
import 'package:google_fonts/google_fonts.dart';

class SemForm extends StatefulWidget {
  const SemForm({super.key});

  @override
  State<SemForm> createState() => _SemFormState();
}

class _SemFormState extends State<SemForm> {
  List<String> subjects = [
    "ppl",
    "CNS",
    "SML",
    "IOT",
    "GB",
    "IOTLAB",
    "SMLLAB"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _appbar(),
      body: BlocBuilder<SemBloc, SemState>(builder: (context, state) {
        if (state is SemLoading)
          return CircularProgressIndicator();
        else if (state is SemError)
          return Center(
            child: Text("Sem Error"),
          );
        else if (state is SemLoaded) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Subjects",
                        style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: subjects.length,
                    itemBuilder: (context, index) {
                      return _subjectBox(
                        subjects[index],
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SubjectPage()),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }
        return Container(
          color: Colors.black,
        );
      }),
    );
  }

  _subjectBox(String sub, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
            height: 50,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 27, 134, 221).withOpacity(0.7),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  //const SizedBox(width: 15),
                  Text(
                    sub,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_right_alt_sharp,
                    color: Colors.white,
                    size: 30,
                  ),
                  // const SizedBox(
                  //   width: 10,
                  // )
                ],
              ),
            )),
      ),
    );
  }
}
