import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: 90,
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
            SizedBox(height: 20),
            Text(
              '@eniliautari',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Project Manager',
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 194, 191, 191),
              ),
            ),
            Divider(height: 40),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Enilia Utari',
              style: TextStyle(fontSize: 16)),
            ),
            //const Divider(),
            ListTile(
              leading: Icon(Icons.school),
              title: Text('S1 Sistem Informasi',
              style: TextStyle(fontSize: 16)),
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Bali Indonesia',
              style: TextStyle(fontSize: 16)),
            ),
            Divider(height: 80),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}