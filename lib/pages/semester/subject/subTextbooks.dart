import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gcet_app/common/pdfViewer.dart';

class TextBooks extends StatefulWidget {
  const TextBooks({super.key});

  @override
  State<TextBooks> createState() => _TextBooksState();
}

class _TextBooksState extends State<TextBooks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TextBooks",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TextBookContainer("computer networks", "Harinath"),
              _TextBookContainer(
                  "design and analysis of algorithms", "vignessh")
            ],
          ),
        ),
      ),
    );
  }

  _TextBookContainer(String textbooktitle, String author) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 4,
        shadowColor: Colors.black,
        surfaceTintColor: Colors.white,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).primaryColor,
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: Offset(2, 2),
                      )
                    ]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "lib/assets/test.png",
                        width: 120,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        textbooktitle,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        author,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Available in library",
                        selectionColor: Colors.green,
                        style: TextStyle(color: Colors.green),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.grey,
                          ),
                          Text(
                            "4.3",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 16),
                          ),
                          SizedBox(width: 2),
                          Text(
                            "(143 ratings)",
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w300,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      // Container(
                      //   height: 50,
                      //   padding: EdgeInsets.all(8),
                      //   decoration: BoxDecoration(
                      //     color: Colors.blue.withOpacity(0.4),
                      //     borderRadius: BorderRadius.circular(20),
                      //   ),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       Icon(
                      //         Icons.book,
                      //         color: Colors.white,
                      //       ),
                      //       Row(
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Text(
                      //             "Read",
                      //             style: TextStyle(
                      //               color: Colors.white,
                      //               fontSize: 18,
                      //               fontWeight: FontWeight.w400,
                      //             ),
                      //           ),
                      //         ],
                      //       )
                      //     ],
                      //   ),
                      // )
                      OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PdfViewer(pdfPath: 'lib/assets/cns.pdf')),
                            );
                          },
                          child: const Text('Read')),
                    ],
                  ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
