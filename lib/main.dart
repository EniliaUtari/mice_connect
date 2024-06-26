import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mice_connect/cubit/counter_cubit.dart';
import 'package:mice_connect/screens/Cust/cust_screen.dart';
import 'package:mice_connect/screens/aboutus_screen.dart';
import 'package:mice_connect/screens/counter/CounterScreen/counter_screen.dart';
import 'package:mice_connect/screens/counter/WelcomeScreen/welcome_screen.dart';
//import 'package:mice_connect/screens/experience.dart';
import 'package:mice_connect/screens/experience.dart';
import 'package:mice_connect/screens/news_feed.dart';
import 'package:mice_connect/screens/routes/SecondScreen/DatasScreen/datas_screen.dart';
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
    return MultiBlocProvider(providers: [BlocProvider<CounterCubit>(create: (context) => CounterCubit())], child: MaterialApp(
      title: 'MICEconnect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Home'),
      routes: {
        '/datas-screen': (context) => const DatasScreen(),
        '/aboutus-screen': (context) => const AboutUsScreen(),
        '/customer-service-screen': (context) => const CustomerScreen(),
        '/counter-screen': (context) => const CounterScreen(),
        '/welcome-screen': (context) => const WelcomeScreen()
      }
    ));
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

              ListTile(
                title: const Text('About Us'),
                leading: const Icon(Icons.people_outline),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutUsScreen()),
                  );
                },
              ),
              
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

              ListTile(
                title: const Text('Latihan Datas'),
                leading: const Icon(Icons.add_a_photo),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/datas-screen');
                },
              ),

              ListTile(
                title: const Text('Customer Service'),
                leading: const Icon(Icons.report),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CustomerScreen()),
                  );
                },
              ),
              
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

              ListTile(
                title: const Text('Counter Screen'),
                leading: const Icon(Icons.countertops_outlined),
                onTap: () {
                  //Navigator.pop(context);
                  Navigator.pushNamed(context, '/counter-screen');
                },
              ),

            ListTile(
                title: const Text('Welcome Screen'),
                leading: const Icon(Icons.countertops_rounded),
                onTap: () {
                  //Navigator.pop(context);
                  Navigator.pushNamed(context, '/welcome-screen');
                },
              ),
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