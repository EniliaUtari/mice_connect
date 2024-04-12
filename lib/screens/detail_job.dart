import 'package:flutter/material.dart';

class DetailJob extends StatelessWidget {
  const DetailJob ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Job'),
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
                    image: AssetImage('assets/images/PMGY.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: Text(
                'Bali Childcare Volunteers',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 8.0),
            const Divider(),
            Row(
              children: <Widget>[
                const Icon(Icons.date_range, size: 20),
                const SizedBox(width: 4.0),
                Text(
                  '4-8 Weeks',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            const Divider(),
            Text(
              'About Event',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'PMGY Childcare Programme in Bali offers volunteers a rewarding opportunity to teach and play with children aged 4-9 in Tabanan, enhancing their English skills and future prospects in a region where tourism has heightened the value of English proficiency. Volunteers, who should have a passion for working with children, will work in a public school kindergarten with about 15 young learners, employing playful, less structured teaching methods to foster language development. The programme emphasizes safety, with all locations vetted for security, ongoing monitoring of local conditions, and comprehensive support including emergency protocols. Volunteers are expected to arrive on the selected Sunday start date at Ngurah Rai International Airport in Denpasar and leave on the Saturday of their final week, with all necessary orientations and briefings provided to ensure a safe, enjoyable, and impactful volunteering experience. Services by PMGY (Accommodation, Meals(Breakfast, Lunch and Dinner), Airport Pick Up, In-Country Orientation, Private Transport To Project, Internet Access, 24 Hour Support and Also Certificate of Completion)',
            ),
            const SizedBox(height: 8.0),
            const Divider(),
            const Text(
              'About Company',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Alamat Perusahaan: Tabanan, Bali, Indonesia',
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Contact: pmgyvolunteerbali@gmail.com',
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Website: www.planmygapyear.com',
            ),
          ],
        ),
      ),
    );
  }
}
