import 'package:flutter/material.dart';
import 'package:mice_connect/components/asset_image_widget.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  final introAboutUsScreen =
      "Find the excitement of your concert and explore your experience with MICEconnect";
  final detailDescription =
      "Hello! Welcome to the MICEconnect app. This mobile application facilitates you to easily find events in the form of music concerts and experiences from available jobs in the form of freelance, volunteer and daily work on the island of Bali, by providing detailed information about all events and jobs that are taking place.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MICEconnect',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 34,
              color: Colors.black),
        ),
        backgroundColor: const Color.fromARGB(255, 56, 187, 231),
        centerTitle: true,
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                      color: const Color.fromARGB(255, 56, 187, 231),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      )),
                  child: Center(
                    child: Text(
                      introAboutUsScreen,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 30.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AssetImageWidget(
                        imagePath: 'assets/images/logo1.jpg',
                        width: 500,
                        height: 259,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        detailDescription,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(color: Colors.black),
                      ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'About Company',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Alamat Perusahaan: Jalan Gatot Subroto Timur No.10, Denpasar, Bali, Indonesia',
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Contact: MICEconnectcompany@gmail.com',
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Website: www.miceconnect.com',
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
