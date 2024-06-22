import 'package:flutter/material.dart';

class SubjectInfoPage extends StatefulWidget {
  SubjectInfoPage({super.key});

  @override
  State<SubjectInfoPage> createState() => _SubjectInfoPageState();
}

class _SubjectInfoPageState extends State<SubjectInfoPage> {
  bool _istopicsshow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Subject info",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "subject Name",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      color: Colors.black.withOpacity(0.9)),
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      "subcode :",
                      style: TextStyle(
                        color: Color.fromARGB(255, 77, 75, 75),
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      " 21cs302",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.9),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "About",
                  style: TextStyle(
                    color: Color.fromARGB(255, 77, 75, 75),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "The objective of this course is to learn app development using framework flutter and for backend i used express js",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.9),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Lessons",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                ExpansionTile(
                  title: const Text("Lesson 1"),
                  trailing: Icon(_istopicsshow
                      ? Icons.arrow_drop_up_rounded
                      : Icons.arrow_drop_down_rounded),
                  children: buildtopicsList(["t1", "t2"]),
                  onExpansionChanged: (bool expanded) {
                    setState(() {
                      _istopicsshow = expanded;
                    });
                  },
                ),
                // const SizedBox(
                //   height: 3,
                // ),
                ExpansionTile(
                  title: const Text("Lesson 2"),
                  trailing: Icon(_istopicsshow
                      ? Icons.arrow_drop_up_rounded
                      : Icons.arrow_drop_down_rounded),
                  children: buildtopicsList(["t1ajk", "t2"]),
                  onExpansionChanged: (bool expanded) {
                    setState(() {
                      _istopicsshow = expanded;
                    });
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Course Objectives",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "co 1 :The objective of this course is to learn app development",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.9),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "co 2 :The objective of this course is to learn app development",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.9),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "co 2 :The objective of this course is to learn app development",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.9),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Course Outcomes",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "co 1 :The objective of this course is to learn app development",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.9),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "co 2 :The objective of this course is to learn app development",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.9),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "co 2 :The objective of this course is to learn app development",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.9),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  List<Widget> buildtopicsList(List<String> topics) {
    return topics.map((topic) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: ListTile(
          tileColor: Colors.grey.shade200,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          title: Text(topic, style: TextStyle(fontWeight: FontWeight.bold)),
          // Divider(),
        ),
      );
    }).toList();
  }
}
