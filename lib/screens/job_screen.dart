import 'package:mice_connect/screens/detail_job.dart';
import 'package:flutter/material.dart';
//import 'package:MICEconnect/screens/routes/JobScreen/job_screen.dart';

class JobScreen extends StatefulWidget {
  const JobScreen ({Key? key}) : super(key: key);  //constructor untuk eventscreen

  @override
  _EventScreenState createState() => _EventScreenState();  //override method createstate untuk mengembalikan eventscreenstate
}

class _EventScreenState extends State<JobScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Create Your More Experience'),
        ),
        body: SingleChildScrollView(  // membuat tampilan dapat di scroll
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                // memanggil method buildEventItem dengan parameter-widget yang diperlukan
                buildEventItem(
                  title: const Text('Bali Childcare Volunteers'),
                  description: const Text('Volunteer by Plan My Gap Year Organixation'),
                  backgroundImage: const AssetImage('assets/images/PMGY.jpg'),
                  date: const Text('4-8 Weeks'),
                  location: const Text('Tabanan, Bali, Indonesia'),
                  onTap: () => Navigator.push(  // Aksi yang terjadi ketika icon di klik
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DetailJob(),  // navigasi ke halaman kedua
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                buildEventItem(
                  title: const Text('Nusa Dua Light Festival'),
                  description: const Text('Daily Work'),
                  backgroundImage: const AssetImage('assets/images/jobnusdu.jpeg'),
                  date: const Text('22 April-23 Juli 2024'),
                  location: const Text('Jl. By Pass Ngurah Rai Jimbaran, Bali'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DetailJob(),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                buildEventItem(
                  title: const Text('Environtmental Education and Cleand Up'),
                  description: const Text('Volunteer by Involvment Volunteers IVI'),
                  backgroundImage: const AssetImage('assets/images/ubud.jpg'),
                  date: const Text('4-20 Weeks'),
                  location: const Text('Ubud, Bali, Indonesia'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DetailJob(),
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
