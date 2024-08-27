import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoticeBox extends StatelessWidget {
  final String from;
  final String fromImg;
  final String date;
  final String time;
  final String img;
  final String title;
  final String description;
  final List<String> tags;
  const NoticeBox({
    super.key,
    required this.from,
    required this.fromImg,
    required this.img,
    required this.title,
    required this.date,
    required this.time,
    required this.description,
    required this.tags,
  });
  void _showFullScreenImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Center(
            child: Image.network(imageUrl),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // return Text("abhi");
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          surfaceTintColor: Colors.white,
          color: Colors.white,
          shadowColor: Colors.grey,
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    //Padding(padding: EdgeInsets.all(5)),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(fromImg),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            from,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                          ),
                          Text(
                            date + " " + time,
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            title,
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                    if (img.isNotEmpty)
                      GestureDetector(
                        onTap: () => _showFullScreenImage(context, img),
                        child: Image.asset(img),
                      ),
                    Column(
                      children: [
                        Text(description,
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: tags.map((tag) {
                        return Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            tag,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
