import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_ujicoba/components/size_config.dart';
// import 'package:flutter_ujicoba/screens/Home.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 70,
            backgroundImage: AssetImage('assets/images/profile.jpg'),
          ),
          const SizedBox(height: 20),
          itemProfile('Nama', 'Putu Eniia Utari', CupertinoIcons.person_fill),
          const SizedBox(height: 20),
          itemProfile('Pendidikan Terakhir', 'S1 Sistem Informasi', CupertinoIcons.book_fill),
          const SizedBox(height: 20),
          itemProfile('Alamat', 'Klungkung, Bali', CupertinoIcons.map_fill),
           const SizedBox(height: 20),
          itemProfile('Experience', 'Your Experience', CupertinoIcons.bag_fill),
        ],
      ),
    );
  }

  itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 5),
                color: Colors.black.withOpacity(.1),
                spreadRadius: 2,
                blurRadius: 5)
          ]),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        trailing: Icon(
          Icons.edit,
          color: Colors.grey,
        ),
        tileColor: Colors.white,
      ),
    );
  }
}