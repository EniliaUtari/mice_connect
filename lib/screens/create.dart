import 'package:mice_connect/services/data_service.dart';
import 'package:flutter/material.dart';

class InputApi extends StatefulWidget {
  const InputApi({Key? key}) : super(key: key);

  @override
  State<InputApi> createState() => _InputApiState();
}

class _InputApiState extends State<InputApi> {
  final _simpanDataTitle = TextEditingController();
  final _simpanDataBody = TextEditingController();

  bool _isFormFilled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Create'),
        backgroundColor: const Color.fromARGB(255, 56, 187, 231),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            TextField(
              controller: _simpanDataTitle,
              onChanged: (_) => _checkFormFilled(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Masukkan Title',
                hintText: 'Title',
                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _simpanDataBody,
              onChanged: (_) => _checkFormFilled(),
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Masukkan Body',
                hintText: 'Body',
                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isFormFilled ? _uploadData : null,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.cloud_upload),
                  SizedBox(width: 5),
                  Text('Upload'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _checkFormFilled() {
    setState(() {
      _isFormFilled = _simpanDataTitle.text.isNotEmpty && _simpanDataBody.text.isNotEmpty;
    });
  }

  void _uploadData() {
    DataService.postEvent(_simpanDataTitle.text, _simpanDataBody.text);
    _showUploadSuccess();
    Navigator.of(context).pop();
  }

  void _showUploadSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Berhasil Upload'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
