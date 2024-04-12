import 'package:mice_connect/screens/login.dart';
import 'package:mice_connect/screens/news_feed.dart';
import 'package:mice_connect/screens/routes/SecondScreen/profile_screen.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:mice_connect/screens/home_screen.dart';
import 'package:mice_connect/screens/event_screen.dart';
import 'package:mice_connect/screens/job_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MICEconnect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;  // judul halaman

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

// list berisi widget" setiap layar
  final List<Widget> _screens = [
    const HomeScreen(),
    const EventScreen(),
    const JobScreen(),
    const ProfileScreen()
  ];

  // list berisi judul setiap layar
  final List<String> _appBarTitles = const [
    'Home',
    'Events',
    'Job',
    'Profile',
  ]; // List of titles corresponding to each screen

  // method untuk menangani ketika item pada bottom bar diklik
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitles[_selectedIndex]),
      ),
      body: _screens[_selectedIndex],  // isi body sesuai dengan halaman yang dipilih
      drawer: Drawer(
        // side-bar
        child: Column(
          children: [
            // Bagian atas sidebar
            Container(
              color:
                  const Color.fromARGB(255, 56, 187, 231), // Warna latar belakang light brown
              padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 10),
              child: const Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/profile.jpg'),
                    radius: 30,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Enilia Utari',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                        ),
                      ),
                      Text('enilia@gmail.com', 
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.black
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          const ListTile(
              title: Text('Putu Enilia Utari'),
              leading: Icon(Icons.person),
            ),
            const ListTile(
              title: Text('4C/Sistem Informasi'),
              leading: Icon(Icons.class_outlined),
            ),
            const ListTile(
              title: Text('Universitas Pendidikan Ganesha'),
              leading: Icon(Icons.school),
            ),
            const Divider(),
            ListTile(
              title: const Text('Enilia_4C'),
              leading: const Icon(Icons.emoji_people),
              onTap: () {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) =>  const NewsFeed()),
                );
              },
            ),
          ],
            ),
        ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // tipe bottom navigator bar yang fixed
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
    unselectedItemColor: Colors.grey, // Atur warna untuk item yang tidak terpilih
    iconSize: 24.0, // Atur ukuran ikon jika perlu
    onTap: _onItemTapped,
    ),
  );
  }
}
