import 'package:flutter/material.dart';
import 'package:gcet_app/pages/semester/subject/subinfo_page.dart';

class SubjectPage extends StatefulWidget {
  const SubjectPage({super.key});

  @override
  State<SubjectPage> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _container(
              "Subject-info",
              Icons.info_outline,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubjectInfoPage()),
                );
              },
            ),
            _container(
              "Assignments",
              Icons.book_sharp,
              () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => SubjectAssignmentPage()),
                // );
              },
            ),
            _container(
              "Notes",
              Icons.read_more_outlined,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubjectInfoPage()),
                );
              },
            ),
            _container(
              "TextBooks",
              Icons.library_books_outlined,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubjectInfoPage()),
                );
              },
            ),
            _container(
              "Attendance",
              Icons.auto_graph_outlined,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubjectInfoPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _container(String s, IconData ic, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 80,
        //color: Colors.blue.withOpacity(0.3),
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(6),
          child: Card(
            surfaceTintColor: Colors.blue,
            elevation: 10,
            shadowColor: Colors.grey,
            child: Row(
              // textBaseline: TextBaseline.alphabetic,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    ic,
                    size: 30,
                    color: Colors.black.withOpacity(0.9),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  s,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w300,
                      color: Colors.black.withOpacity(0.9)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
