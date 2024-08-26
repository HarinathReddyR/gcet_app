import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gcet_app/db/user_dao.dart';
import 'package:gcet_app/pages/postevents/regusers_page.dart';
import 'package:http/http.dart' as http;
import 'package:readmore/readmore.dart';

class MyEventsPage extends StatefulWidget {
  const MyEventsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyEventsPage> createState() => _MyEventsPage();
}

class _MyEventsPage extends State<MyEventsPage> {
  List<dynamic> events = [];
  late String user;

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    String token = await UserDao().getPersistToken(0);
    String user = await UserDao().getUser(0);
    final response = await http.get(
      Uri.parse('http://localhost:3000/api/events/display/$user'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        events = json.decode(response.body);
      });
    } else {
      // Handle error
      print('Failed to load events');
      Navigator.pop(context);
    }
  }

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
      ],
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
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
                        commonTextStyle(event['usr'], 16),
                      ],
                    ),
                    GestureDetector(
                      onTap: () =>
                          _showFullScreenImage(context, event['img_url']),
                      child: Image.network(event['img_url']),
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
                              commonFieldsText("Date: ", event['date']),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on_outlined),
                              SizedBox(width: 5),
                              commonFieldsText("Venue: ", event['venue']),
                            ],
                          ),
                          SizedBox(height: 5),
                          ReadMoreText(
                            event['description'],
                            trimMode: TrimMode.Line,
                            trimLines: 2,
                            colorClickableText:
                                const Color.fromRGBO(78, 24, 217, 1),
                            trimCollapsedText: 'Read more',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    (event['reg'] == 1)
                        ? Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EventRegUsers(
                                            eventId: event['id'],
                                          )),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(78, 24, 217, 1),
                              ),
                              child: Text(
                                'Registered Users: ${event['registrations']}',
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1)),
                              ),
                            ),
                          )
                        : Container(),
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
