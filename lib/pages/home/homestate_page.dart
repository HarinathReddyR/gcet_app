import 'package:flutter/material.dart';
import 'package:gcet_app/pages/postevents/events_page.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  EdgeInsetsGeometry padding = EdgeInsets.fromLTRB(12.0, 25.0, 12.0, 25.0);
  Color textColor = Colors.white;
  Color ncolor = Color.fromRGBO(78, 24, 217, 1);
  double totClasses = 200, attdClasses = 90;
  double cgpa = 8.5;
  int backlogs = 0;

  List<Map<String, String>> schedule = [
    {
      "startTime": "12:00",
      "endTime": "13:00",
      "subject": "Mathematics",
      "location": "Room 101"
    },
    {
      "startTime": "11:00",
      "endTime": "12:00",
      "subject": "Physics",
      "location": "Room 102"
    },
    {
      "startTime": "14:00",
      "endTime": "15:00",
      "subject": "Chemistry",
      "location": "Room 103"
    },
  ];

  @override
  Widget build(BuildContext context) {
    String currentTime = DateFormat.Hm().format(DateTime.now());

    // Filter the schedule to show only the current class
    Map<String, String>? currentSchedule = schedule.firstWhereOrNull(
      (classItem) {
        DateTime currentDateTime = DateFormat.Hm().parse(currentTime);
        DateTime startTime = DateFormat.Hm().parse(classItem['startTime']!);
        DateTime endTime = DateFormat.Hm().parse(classItem['endTime']!);
        return currentDateTime.isAfter(startTime) &&
            currentDateTime.isBefore(endTime);
      },
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10.0),
          width: double.infinity,
          child: Column(
            children: [
              // Attendance Card
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 10,
                  color:
                      (attdClasses / totClasses >= 0.75) ? ncolor : Colors.red,
                  child: Padding(
                    padding: padding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (attdClasses / totClasses >= 0.75)
                              ? 'Your Attendance is Good So far!!'
                              : 'Improve Your Attendance!!',
                          style: TextStyle(
                              fontSize: 16,
                              color: textColor,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            CircularPercentIndicator(
                              radius: 50.0,
                              lineWidth: 9.0,
                              percent: attdClasses / totClasses,
                              center: Text(
                                "${(attdClasses * 100 / totClasses).toStringAsFixed(1)}%",
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              progressColor: textColor,
                            ),
                            SizedBox(width: 10.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),
                                Text(
                                  'Total Classes Attended: $attdClasses',
                                  style:
                                      TextStyle(fontSize: 13, color: textColor),
                                ),
                                Text('Total Classes: $totClasses',
                                    style: TextStyle(
                                        fontSize: 13, color: textColor)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Schedule Card - Display only if there's a current class
              if (currentSchedule != null)
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    color: ncolor,
                    child: Padding(
                      padding: padding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Current Schedule',
                            style: TextStyle(
                                fontSize: 18,
                                color: textColor,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    currentSchedule['startTime']! +
                                        " - " +
                                        currentSchedule['endTime']!,
                                    style: TextStyle(
                                        color: textColor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    currentSchedule['subject']!,
                                    style: TextStyle(
                                        color: textColor.withOpacity(0.8),
                                        fontSize: 14.0),
                                  ),
                                ],
                              ),
                              Text(
                                currentSchedule['location']!,
                                style: TextStyle(
                                    color: textColor.withOpacity(0.8),
                                    fontSize: 14.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              else
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    color: ncolor,
                    child: Padding(
                      padding: padding,
                      child: Text(
                        'No ongoing classes at this time.',
                        style: TextStyle(
                            fontSize: 18,
                            color: textColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),

              // CGPA & Backlogs Card
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 10,
                  color: (backlogs == 0) ? ncolor : Colors.red,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (backlogs == 0)
                              ? 'Your CGPA is Good So far!!'
                              : 'Clear your Backlogs',
                          style: TextStyle(
                              fontSize: 16,
                              color: textColor,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            CircularPercentIndicator(
                              radius: 50.0,
                              lineWidth: 9.0,
                              percent: cgpa * 0.1,
                              center: Text(
                                cgpa.toString(),
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              progressColor: textColor,
                            ),
                            SizedBox(width: 30.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),
                                Text(
                                  'Backlogs: $backlogs',
                                  style:
                                      TextStyle(fontSize: 15, color: textColor),
                                ),
                                Text('CGPA: $cgpa',
                                    style: TextStyle(
                                        fontSize: 15, color: textColor)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              // Tab Bar and Tab View
              DefaultTabController(
                length: 3, // Number of tabs
                child: Column(
                  children: [
                    Container(
                      child: TabBar(
                        isScrollable: true, // Allow scrolling for better layout
                        unselectedLabelColor: ncolor,
                        labelColor: textColor, // Color for selected tab text
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorColor: Colors.transparent,
                        indicatorWeight: 0,
                        dividerColor: Colors.transparent,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: ncolor,
                        ),
                        tabs: [
                          Tab(
                            child: Container(
                              width: 100, // Set width here
                              height: 40, // Set height here
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: ncolor, width: 1),
                              ),
                              child: Center(
                                child: Text("Time Table"),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              width: 100, // Set width here
                              height: 40, // Set height here
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: ncolor, width: 1),
                              ),
                              child: Center(
                                child: Text("Attendance"),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              width: 150, // Set width here
                              height: 40, // Set height here
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: ncolor, width: 1),
                              ),
                              child: Center(
                                child: Text("Upcoming Events"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    SizedBox(
                      height: 300, // Adjust the height as per your needs
                      child: TabBarView(
                        children: [
                          Center(child: Text("Time Table View")),
                          Center(child: Text("Attendance View")),
                          EventsPage(otherPage: false,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
