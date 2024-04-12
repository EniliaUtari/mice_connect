import 'package:flutter/material.dart';
import 'package:mice_connect/screens/routes/SecondScreen/detail_event.dart';

class EventScreen extends StatefulWidget {
  const EventScreen ({Key? key}) : super(key: key);  //constructor untuk eventscreen

  @override
  _EventScreenState createState() => _EventScreenState();  //override method createstate untuk mengembalikan eventscreenstate
}

class _EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Your Music Time'),
        ),
        body: SingleChildScrollView(  // membuat tampilan dapat di scroll
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                // memanggil method buildEventItem dengan parameter-widget yang diperlukan
                buildEventItem(
                  title: const Text('Ubud Village Jazz Festival 2024'),
                  description: const Text('The Best Jazz Festival in Bali'),
                  backgroundImage: const AssetImage('assets/images/event1.jpg'),
                  date: const Text('2-3 Agustus 2024'),
                  location: const Text('ARMA Ubud'),
                  onTap: () => Navigator.push(  // Aksi yang terjadi ketika icon di klik
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DetailEvent(),  // navigasi ke halaman kedua
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                buildEventItem(
                  title: const Text('Youth Night Fest'),
                  description: const Text('Lets Join Young Soul!'),
                  backgroundImage: const AssetImage('assets/images/youthnight.jpg'),
                  date: const Text('20 April 2024'),
                  location: const Text('Mertasari Beach'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DetailEvent(),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                buildEventItem(
                  title: const Text('Festival Musik Bali Countdown 2023'),
                  description: const Text('Create Your Exciting New Years Here!'),
                  backgroundImage: const AssetImage('assets/images/event3.jpg'),
                  date: const Text('31 Desember 2023'),
                  location: const Text('GWK Culuture Park'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DetailEvent(),
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
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),  // mengatur sudut container
                  // untuk menampilkan gambar
                  image: DecorationImage(
                    image: backgroundImage,
                    fit: BoxFit.cover,  // menyesuaikan ukuran gambar
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  title,
                  const SizedBox(height: 8.0),
                  description,
                  const SizedBox(height: 8.0),
                  Row(
                    children: <Widget>[
                      const Icon(Icons.date_range, size: 16),
                      const SizedBox(width: 4.0),
                      date,
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: <Widget>[
                      const Icon(Icons.location_on, size: 16),
                      const SizedBox(width: 4.0),
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
