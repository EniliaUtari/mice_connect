import 'package:mice_connect/services/data_service.dart';
//import 'package:MICEconnect/services/data_service.dart';
import 'package:flutter/material.dart';
//import 'create.dart';

class InputApi extends StatefulWidget {
  const InputApi({super.key});

  @override
  State<InputApi> createState() => _InputApiState();
}

class _InputApiState extends State<InputApi> {
  final _simpanDataTitle = TextEditingController();
  final _simpanDataBody = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Create'),
        backgroundColor: const Color.fromARGB(255, 56, 187, 231),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          TextField(
            controller: _simpanDataTitle,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('masukan title'),
                hintText: 'title'),
          ),
          const SizedBox(
            height: 30,
          ),
          TextField(
            controller: _simpanDataBody,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('masukan title'),
                hintText: 'title'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                DataService.postEvent(
                    _simpanDataTitle.text, _simpanDataBody.text);
                Navigator.of(context).pop();
              });
            },
            child: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}