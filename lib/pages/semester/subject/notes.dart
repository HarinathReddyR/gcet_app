import 'package:flutter/material.dart';
import 'package:gcet_app/common/pdfViewer.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notes",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                _container(
                  "unit-1",
                  Icons.picture_as_pdf,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PdfViewer(pdfPath: 'lib/assets/vig.pdf')),
                    );
                  },
                ),
                _container(
                  "Unit-2",
                  Icons.picture_as_pdf,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PdfViewer(pdfPath: 'lib/assets/cns.pdf')),
                    );
                  },
                ),
              ],
            )),
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
