import 'package:flutter/material.dart';
//import 'package:mice_connect/screens/experience.dart';
import 'package:mice_connect/screens/experience.dart';
import 'package:mice_connect/screens/news_feed.dart';
import 'package:mice_connect/screens/routes/SecondScreen/profile_screen.dart';
import 'package:mice_connect/screens/home_screen.dart';
import 'package:mice_connect/screens/event_screen.dart';
import 'package:mice_connect/screens/job_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MICEconnect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    EventScreen(),
    JobScreen(),
    ProfileScreen(),
    ExperienceScreen(),
  ];

  final List<String> _appBarTitles = const [
    'Home',
    'Events',
    'Job',
    'Profile',
    'Experience',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_appBarTitles[_selectedIndex]),
        ),
        body: _screens[_selectedIndex],
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 56, 187, 231),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/profile.jpg'),
                      radius: 30,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Enilia Utari',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'enilia@gmail.com',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),

              ListTile(
                title: const Text('Latihan API'),
                leading: const Icon(Icons.task),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NewsFeed()),
                  );
                },
              ),
              const Divider(),
              ListTile(
                title: const Text('My Experience'),
                leading: const Icon(Icons.work),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ExperienceScreen()),
                  );
                },
              ),
              const Divider(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit_calendar),
              label: 'Events',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.handshake),
              label: 'Job',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color.fromARGB(255, 56, 187, 231),
          unselectedItemColor: Colors.grey,
          iconSize: 24.0,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}