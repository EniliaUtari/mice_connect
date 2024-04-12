import 'package:flutter/material.dart';

class DetailEvent extends StatelessWidget {
  const DetailEvent ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Event'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/event1.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: Text(
                'Ubud Village Jazz Festival 2024',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(), // Garis pemisah
            Row(
              children: <Widget>[
                const Icon(Icons.date_range, size: 20),
                const SizedBox(width: 4.0),
                Text(
                  '2-3 Agustus 2024',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                const Icon(Icons.location_on, size: 20),
                const SizedBox(width: 4.0),
                Text(
                  'ARMA Ubud',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const Divider(), // Garis pemisah
            Text(
              'About Event',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'UBUD VILLAGE JAZZ FESTIVAL (UVJF) enters its second decade, expressing gratitude to the Ministry of Tourism and Creative Economy of The Republic of Indonesia for their support. Recognized as a prestigious national event, UVJF serves as a platform for diverse global jazz talents, endorsed by international embassies.',
            ),
            const Divider(), // Garis pemisah
            const Text(
              'About Company',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Alamat Perusahaan: Jalan A.A Gede Rai,Jl. Raya Mawang Kelod, Lodtunduh, Kecamatan Ubud, Gianyar, Bali',
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Contact: ubudvillagejazzfestival@gmail.com',
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Website: www.ubudvillagejazzfest.com',
            ),
          ],
        ),
      ),
    );
  }
}
