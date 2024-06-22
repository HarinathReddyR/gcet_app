// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class EventsPage extends StatefulWidget {
  @override
  State<EventsPage> createState() => _EventsPage();
}

class _EventsPage extends State<EventsPage> {
  commonTextStyle(String text, double size) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: size,
      ),
    );
  }

  commonFieldsText(String text1, String text2) {
    return Row(
      children: [
        commonTextStyle("$text1 ", 15),
        commonTextStyle(text2, 15),
      ]
    );
  }

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
    List<Map<String, String>> events = [
      {
        "date": "31 May, 2024",
        "venue": "Near Block-1",
        "description": "This is a sample description for event 1. It may contain a long text which should be truncated.",
      },
      {
        "date": "1 June, 2024",
        "venue": "Near Block-2",
        "description": "This is a sample description for event 2. It may contain a long text which should be truncated.",
      },
      {
        "date": "2 June, 2024",
        "venue": "Near Block-3",
        "description": "This is a sample description for event 3. It may contain a long text which should be truncated.",
      },
      {
        "date": "3 June, 2024",
        "venue": "Near Block-4",
        "description": "This is a sample description for event 4. It may contain a long text which should be truncated.",
      },
      {
        "date": "4 June, 2024",
        "venue": "Near Block-5",
        "description": "This is a sample description for event 5. It may contain a long text which should be truncated.",
      },
      {
        "date": "5 June, 2024",
        "venue": "Near Block-6",
        "description": "This is a sample description for event 6. It may contain a long text which should be truncated.",
      },
      {
        "date": "6 June, 2024",
        "venue": "Near Block-7",
        "description": "This is a sample description for event 7. It may contain a long text which should be truncated.",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
        
        // backgroundColor: Color.fromRGBO(78, 24, 217, 1),
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return Container(
            width: double.infinity,
            child: Card(
              surfaceTintColor: Colors.white,
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(backgroundColor: Colors.grey),
                        ),
                        commonTextStyle("Admin", 16),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => _showFullScreenImage(context, "lib/assets/sunrise.jpg"), 
                      child: Image.network("lib/assets/sunrise.jpg"),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.date_range),
                              SizedBox(width: 5),
                              commonFieldsText("Date: ", event['date']!),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on_outlined),
                              SizedBox(width: 5),
                              commonFieldsText("Venue: ", event['venue']!),
                            ],
                          ),
                          SizedBox(height: 5),
                          ReadMoreText(
                            event['description']!,
                            trimMode: TrimMode.Line,
                            trimLines: 1,
                            colorClickableText: const Color.fromRGBO(78, 24, 217, 1),
                            trimCollapsedText: 'Read more',
                            // trimExpandedText: 'Show less',
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


