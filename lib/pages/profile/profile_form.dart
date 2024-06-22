import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcet_app/pages/exams/exam_page.dart';
import 'package:gcet_app/pages/profile/bloc/profile_bloc.dart';
import 'package:gcet_app/theme/theme.dart';

class ProfileForm extends StatefulWidget {
  final String rollNo;
  const ProfileForm({super.key, required this.rollNo});
  @override
  State<ProfileForm> createState() => _ProfileFormState(rollNo: rollNo);
}

class _ProfileFormState extends State<ProfileForm> {
  final String rollNo;
  _ProfileFormState({required this.rollNo});
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Profile Page'),
      // ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoaded) {
            return Container(
              height: screensize.height,
              width: double.infinity,
              color: Colors.white,
              child: Column(children: [
                Expanded(
                  child: Container(
                    width: screensize.width,
                    height: 180,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.black12,
                      //     blurStyle: BlurStyle.outer,
                      //     blurRadius: 10,
                      //   ),
                      // ],
                    ),
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      children: [
                        const SizedBox(width: 30),
                        const CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('lib/assets/logo.png'),
                        ),
                        const SizedBox(width: 30),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                              Text(
                                '${rollNo}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 21,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                ' ${state.batch} | ${state.branch} | ${state.section}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //const Divider(),
                Expanded(
                  child: Container(
                    //height: screensize.height,
                    width: double.infinity,
                    // color: Colors.white,
                    // widt:double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            profileOptions(
                              "Attendance",
                              Icons.person_2_outlined,
                              Icons.arrow_right_alt_sharp,
                              () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => ProfilePage()),
                                // );
                              },
                            ),
                            SizedBox(height: 10),
                            profileOptions(
                              "Results",
                              Icons.person_2_outlined,
                              Icons.arrow_right_alt_sharp,
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ExamPage(
                                            rollNo: '21r11a05k0',
                                          )),
                                );
                              },
                            ),
                            SizedBox(height: 10),
                            profileOptions(
                                "my Achievements",
                                Icons.person_2_outlined,
                                Icons.arrow_right_alt_sharp,
                                () {}),
                            SizedBox(height: 10),
                            profileOptions("settings", Icons.settings,
                                Icons.arrow_right_alt_sharp, () {}),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => AttendancePage()));
                              },
                              child: const Text("Attendance"),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                //Navigator.push(context, MaterialPageRoute(builder: (context) => ResultsPage()));
                              },
                              child: const Text('Results'),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                //Navigator.push(context, MaterialPageRoute(builder: (context) => AchievementsPage()));
                              },
                              child: const Text("Attendance"),
                            ),
                          ]),
                    ),
                  ),
                )
              ]),
            );
          }
          return Column();
        },
      ),
    );
  }

  Widget profileOptions(
      String s, IconData ic, IconData ic2, VoidCallback onTap) {
    final screensize = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
          height: 50,
          width: screensize.width,
          margin: const EdgeInsets.symmetric(
            horizontal: 25,
          ),
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.blue.withOpacity(0.1),
          ),
          child: Row(
            children: [
              Icon(
                ic,
                size: 30,
                color: Colors.blueGrey,
              ),
              const SizedBox(width: 10),
              Text(
                s,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 21,
                    fontWeight: FontWeight.w400),
              ),
              Spacer(),
              Icon(
                ic2,
                size: 30,
              )
            ],
          )),
    );
  }
}
// return ListTile(
//       leading: Container(
//         width: 40,
//         height: 40,
//         decoration: BoxDecoration(
//             color: Color.fromARGB(255, 99, 146, 182).withOpacity(0.1),
//             borderRadius: BorderRadius.circular(20)),
//         child: Icon(Icons.settings),
//       ),
//       title: Text("academics", style: SubHeadingStyle),
//       trailing: Container(
//           width: 30,
//           height: 30,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(100),
//             color: Colors.grey.withOpacity(0.1),
//           ),
//           child: Icon(Icons.arrow_circle_right_outlined)),
//     );
