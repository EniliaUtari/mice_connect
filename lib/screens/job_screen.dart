import 'package:MICEconnect/screens/detail_job.dart';
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
          title: Text('Create Your More Experience'),
        ),
        body: SingleChildScrollView(  // membuat tampilan dapat di scroll
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                // memanggil method buildEventItem dengan parameter-widget yang diperlukan
                buildEventItem(
                  title: Text('Bali Childcare Volunteers'),
                  description: Text('Volunteer by Plan My Gap Year Organixation'),
                  backgroundImage: AssetImage('assets/images/PMGY.jpg'),
                  date: Text('4-8 Weeks'),
                  location: Text('Tabanan, Bali, Indonesia'),
                  onTap: () => Navigator.push(  // Aksi yang terjadi ketika icon di klik
                    context,
                    MaterialPageRoute(
                      builder: (context) => const detail_job(),  // navigasi ke halaman kedua
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                buildEventItem(
                  title: Text('Nusa Dua Light Festival'),
                  description: Text('Daily Work'),
                  backgroundImage: AssetImage('assets/images/jobnusdu.jpeg'),
                  date: Text('22 April-23 Juli 2024'),
                  location: Text('Jl. By Pass Ngurah Rai Jimbaran, Bali'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const detail_job(),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                buildEventItem(
                  title: Text('Environtmental Education and Cleand Up'),
                  description: Text('Volunteer by Involvment Volunteers IVI'),
                  backgroundImage: AssetImage('assets/images/ubud.jpg'),
                  date: Text('4-20 Weeks'),
                  location: Text('Ubud, Bali, Indonesia'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const detail_job(),
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
