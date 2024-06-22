import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcet_app/pages/notice/bloc/notice_bloc.dart';
import 'package:gcet_app/pages/notice/notice_box.dart';
import 'package:gcet_app/theme/theme.dart';

class NoticeForm extends StatefulWidget {
  const NoticeForm({super.key});

  @override
  State<NoticeForm> createState() => _NoticeFormState();
}

class _NoticeFormState extends State<NoticeForm> {
  String query = '';
  final TextEditingController _controller = TextEditingController();
  List<String> selectedTags = [];

  void onQueryChanged(String newQuery) {
    setState(() {
      query = newQuery;
    });
  }

  void toggleTag(String tag) {
    setState(() {
      if (selectedTags.contains(tag)) {
        selectedTags.remove(tag);
      } else {
        selectedTags.add(tag);
      }
    });
  }

  List<String> searchTags = [
    "urgent",
    "CSE",
    "error",
    "ECE",
    "EEE",
    'CIVIL',
    "CLUB",
    "PLACEMENTS"
  ];

  List<Map<String, dynamic>> notices = [
    {
      "from": "CSE",
      "fromImg": "lib/assets/test.png",
      "date": "12-02-2024",
      "time": "9:00am",
      "title": "Error",
      "img": "lib/assets/test.png",
      "description":
          "This is the data which is a description of our notice data. The [overflow] property's behavior is affected by the [softWrap] argument.",
      "tags": ["urgent", "CSE", "error"]
    },
    {
      "from": "ECE",
      "fromImg": "lib/assets/test.png",
      "date": "12-02-2024",
      "time": "9:00am",
      "title": "Meeting",
      "img": "lib/assets/test.png",
      "description":
          "This is the data which is a description of our notice data. The [overflow] property's behavior is affected by the [softWrap] argument.",
      "tags": ["meeting", "ECE"],
    },
    {
      "from": "Coding-club",
      "fromImg": "lib/assets/test.png",
      "date": "12-02-2024",
      "time": "9:00am",
      "title": "Coding Challenge",
      "img": "",
      "description": "This ",
      "tags": ["coding", "club"],
    }
  ];

  List<Map<String, dynamic>> get filteredNotices {
    return notices.where((notice) {
      final matchesTags = selectedTags.isEmpty ||
          notice['tags']!.any((tag) => selectedTags.contains(tag));
      final matchesQuery = matchesTags &&
          (query.isEmpty ||
              notice['title']!.toLowerCase().contains(query.toLowerCase()));
      return matchesQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: BlocBuilder<NoticeBloc, NoticeState>(builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5,
                                    spreadRadius: 3)
                              ]),
                          padding: EdgeInsets.all(16),
                          child: TextField(
                            controller: _controller,
                            onChanged: onQueryChanged,
                            decoration: const InputDecoration(
                              labelText: 'Search',
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      searchTags.length,
                      (index) => GestureDetector(
                        onTap: () => toggleTag(searchTags[index]),
                        child: Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: selectedTags.contains(searchTags[index])
                                  ? Colors.blue
                                  : const Color.fromARGB(255, 249, 236, 236),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 3,
                                  spreadRadius: 1,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            child: Text(
                              searchTags[index],
                              style: TextStyle(
                                color: selectedTags.contains(searchTags[index])
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ...filteredNotices.map((notice) => NoticeBox(
                      from: notice['from']!,
                      fromImg: notice['fromImg']!,
                      date: notice['date']!,
                      time: notice['time']!,
                      img: notice['img']!,
                      title: notice['title']!,
                      description: notice['description']!,
                      tags: notice['tags']!,
                    )),
              ],
            ),
          ),
        );
      }),
    );
  }

  AppBar _appbar() {
    return AppBar(
      title: const Text(
        'Notices',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Themes.lightTheme.primaryColor,
      actions: const [
        Icon(
          Icons.person,
          size: 20,
          color: Colors.black,
        ),
        SizedBox(width: 20),
      ],
    );
  }
}



                // Container(
                //   height: MediaQuery.of(context).size.height *
                //       0.645, // Adjust height as needed
                //   child: ListView.builder(
                //     padding: const EdgeInsets.all(8),
                //     itemCount: notices.length,
                //     itemBuilder: (BuildContext context, int i) {
                //       return NoticeBox(
                //         from: notices[i]['from']!,
                //         fromImg: notices[i]['fromImg']!,
                //         date: notices[i]['date']!,
                //         time: notices[i]['time']!,
                //         img: notices[i]['img']!,
                //         title: notices[i]['title']!,
                //         description: notices[i]['description']!,
                //       );
                //     },
                //   ),
                // ),
                // ),

//  Expanded(
//                         child: Container(
//                           height: 50,
//                           padding: EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(50),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey,
//                                 blurRadius: 10,
//                                 spreadRadius: 5,
//                                 offset: Offset(5, 6),
//                               ),
//                             ],
//                           ),
//                           child: TextField(
//                             controller: _controller,
//                             onChanged: onQueryChanged,
//                             decoration: InputDecoration(
//                               labelText: 'Search',
//                               border: InputBorder.none,
//                               prefixIcon: Icon(Icons.search),
//                               contentPadding:
//                                   EdgeInsets.symmetric(vertical: 15),
//                             ),
//                             maxLines: 1,
//                             keyboardType: TextInputType.text,
//                             textInputAction: TextInputAction.search,
//                             scrollPadding: EdgeInsets.all(0),
//                             textAlignVertical: TextAlignVertical.center,
//                             style: TextStyle(
//                               overflow: TextOverflow.visible,
//                             ),
//                           ),
//                         ),
//                       ),
