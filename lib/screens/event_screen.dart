import 'package:flutter/material.dart';
import 'package:MICEconnect/screens/routes/SecondScreen/detail_event.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);  //constructor untuk eventscreen

  @override
  _EventScreenState createState() => _EventScreenState();  //override method createstate untuk mengembalikan eventscreenstate
}

class _EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Your Music Time'),
        ),
        body: SingleChildScrollView(  // membuat tampilan dapat di scroll
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                // memanggil method buildEventItem dengan parameter-widget yang diperlukan
                buildEventItem(
                  title: Text('Ubud Village Jazz Festival 2024'),
                  description: Text('The Best Jazz Festival in Bali'),
                  backgroundImage: AssetImage('assets/images/event1.jpg'),
                  date: Text('2-3 Agustus 2024'),
                  location: Text('ARMA Ubud'),
                  onTap: () => Navigator.push(  // Aksi yang terjadi ketika icon di klik
                    context,
                    MaterialPageRoute(
                      builder: (context) => const detail_event(),  // navigasi ke halaman kedua
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                buildEventItem(
                  title: Text('Youth Night Fest'),
                  description: Text('Lets Join Young Soul!'),
                  backgroundImage: AssetImage('assets/images/youthnight.jpg'),
                  date: Text('20 April 2024'),
                  location: Text('Mertasari Beach'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const detail_event(),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                buildEventItem(
                  title: Text('Festival Musik Bali Countdown 2023'),
                  description: Text('Create Your Exciting New Years Here!'),
                  backgroundImage: AssetImage('assets/images/event3.jpg'),
                  date: Text('31 Desember 2023'),
                  location: Text('GWK Culuture Park'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const detail_event(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEventItem({  // mthod untuk membantun item event
    required Widget title,
    required Widget description,
    required AssetImage backgroundImage,
    required Widget date,
    required Widget location,
    required VoidCallback onTap,
  }) {
    return InkWell( // menangani ketika item diklik
      onTap: onTap,  // aksi yang terjadi ketika item di klik
      child: Card(
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(4)),  // mengatur sudut container
                  // untuk menampilkan gambar
                  image: DecorationImage(
                    image: backgroundImage,
                    fit: BoxFit.cover,  // menyesuaikan ukuran gambar
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  title,
                  SizedBox(height: 8.0),
                  description,
                  SizedBox(height: 8.0),
                  Row(
                    children: <Widget>[
                      Icon(Icons.date_range, size: 16),
                      SizedBox(width: 4.0),
                      date,
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    children: <Widget>[
                      Icon(Icons.location_on, size: 16),
                      SizedBox(width: 4.0),
                      location,
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
