import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcet_app/bloc/auth_bloc.dart';
import 'package:gcet_app/db/user_dao.dart';
import 'package:gcet_app/pages/attendance/attendance_page.dart';
import 'package:gcet_app/pages/blog_page.dart';
import 'package:gcet_app/pages/home/homestate_page.dart';
import 'package:gcet_app/pages/postevents/events_page.dart';
import 'package:gcet_app/pages/postevents/formgenerator.dart';
import 'package:gcet_app/pages/postevents/postevents_page.dart';
import 'package:gcet_app/pages/postevents/userevents_page.dart';
import 'package:gcet_app/pages/profile/profile_page.dart';
import 'package:gcet_app/pages/schedule/schedule_page.dart';
import 'package:gcet_app/pages/notice/notice_page.dart';
import 'package:gcet_app/pages/semester/sem_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color color = Color.fromRGBO(78, 24, 217, 1);
  Color drawColor = Color.fromRGBO(134, 104, 210, 1);
  int _currentIndex = 0;
  String? user;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _pages = [
    HomePage(),
    SemPage(),
    NoticePage(),
    ProfilePage(
      rollNo: '21r11a05k0',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    String fetchedUser = await UserDao().getUser(0);
    setState(() {
      user = fetchedUser;
    });
  }

  _logout() {
    BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.69,
        child: Container(
          color: drawColor,
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: drawColor,
                ),
                accountName:
                    Text(user ?? 'User', style: TextStyle(color: Colors.white)),
                accountEmail: Text('$user@gcet.edu.in',
                    style: TextStyle(color: Colors.white)),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    user?.substring(0, 1).toUpperCase() ?? '',
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ListTile(
                      leading: Icon(Icons.home, color: Colors.white),
                      title: Text("Home", style: TextStyle(color: Colors.white)),
                      onTap: () {
                        setState(() {
                          _currentIndex = 0;
                        });
                        Navigator.pop(context); // Close the drawer
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.post_add, color: Colors.white),
                      title: Text("Blogs", style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Navigator.pop(context); // Close the drawer
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BlogPage()),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.schedule, color: Colors.white),
                      title: Text("Schedule", style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Navigator.pop(context); // Close the drawer
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SchedulePage(
                                    rollNo: '21r1a05k0',
                                  )),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.check_circle_outline, color: Colors.white),
                      title: Text("Attendance", style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Navigator.pop(context); // Close the drawer
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AttendancePage()),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.event, color: Colors.white),
                      title: Text("Post Events", style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Navigator.pop(context); // Close the drawer
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PostEvents()),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.event_note, color: Colors.white),
                      title: Text("Events", style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Navigator.pop(context); // Close the drawer
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EventsPage(otherPage: true)),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.event_available, color: Colors.white),
                      title: Text("My Events", style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Navigator.pop(context); // Close the drawer
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyEventsPage()),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.assignment, color: Colors.white),
                      title: Text("Generate Form", style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Navigator.pop(context); // Close the drawer
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CustomFormPage(
                                    title: '',
                                    desc: '',
                                    questions: [],
                                  )),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.logout, color: Colors.white),
                      title: Text("Logout", style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Navigator.pop(context); // Close the drawer
                        _logout();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Row(
              children: [
                Text(
                  "Hello $user",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _pages[_currentIndex],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: BottomNavigationBar(
                elevation: 0,
                selectedIconTheme: IconThemeData(size: 30),
                unselectedIconTheme: IconThemeData(size: 20),
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: Colors.white.withOpacity(0.7),
                selectedItemColor: Colors.white,
                backgroundColor: Colors.transparent,
                currentIndex: _currentIndex,
                onTap: (index) {
                  if (index == 4) {
                    _logout();
                  } else {
                    setState(() {
                      _currentIndex = index;
                    });
                  }
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.post_add),
                    label: "Blogs",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_add_alt_rounded),
                    label: "Attendance",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: "Profile",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.logout),
                    label: "Logout",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
