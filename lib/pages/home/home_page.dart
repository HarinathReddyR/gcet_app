import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcet_app/bloc/auth_bloc.dart';
import 'package:gcet_app/pages/attendance/attendance_page.dart';
import 'package:gcet_app/pages/blog_page.dart';
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
  bool logedIn = false;
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text('Home Page')),
    SemPage(),
    NoticePage(),
    ProfilePage(
      rollNo: '21r11a05k0',
    ),
  ];

  _logout() {
    BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black54,
        selectedItemColor: Colors.black,
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
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
            label: "profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: "Logout",
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text("Home"),
              onTap: () {},
            ),
            ListTile(
              title: const Text("Blogs"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BlogPage()),
                );
              },
            ),
            ListTile(
              title: const Text("schedule"),
              onTap: () {
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
              title: const Text("Attendance"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AttendancePage()),
                );
              },
            ),
            ListTile(
              title: const Text("Logout"),
              onTap: () {
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor:
            Colors.blue, // Theme.of(context).colorScheme.inversePrimary,
        title: const Row(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              // child: Image.asset(
              //   "lib/assets/logo.png",
              //   scale: ,
              // ),
              // child: Icon(Icons.g_mobiledata, size: 37,),
            ),
            Text("GCET")
          ],
        ),
      ),
      body: _pages[_currentIndex],
    );
  }
}
