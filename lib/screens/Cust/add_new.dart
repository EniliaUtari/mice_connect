import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mice_connect/endpoints/cust_endpoint.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mice_connect/screens/Cust/cust_screen.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _title = "";
  String _description = "";
  int _rating = 0;
  String _priority = 'high';

  List<Map<String, dynamic>> _checkboxData = [
    {"id": 1, "type": "Billing"},
    {"id": 2, "type": "Support"},
    {"id": 3, "type": "Teknis"},
  ];

  String? _selectedType;

  File? galleryFile;
  final picker = ImagePicker();

  _showPicker({
    required BuildContext context,
  }) {
    // show pilihan bottom library/camera
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future getImage(
    ImageSource img,
  ) async {
    final pickedFile = await picker.pickImage(source: img);
    setState(
      () {
        if (pickedFile != null) {
          galleryFile = File(pickedFile.path);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _postDataWithImage(BuildContext context) async {
    if (galleryFile == null) {
      return;
    }

    var request = MultipartRequest('POST', Uri.parse(Endpoints.newcs));
    request.fields['title_issues'] = _title;
    request.fields['description_issues'] = _description;
    request.fields['rating'] = _rating.toString();

    var multipartFile = await MultipartFile.fromPath(
      'image',
      galleryFile!.path,
    );
    request.files.add(multipartFile);

    request.send().then((response) {
      if (response.statusCode == 201) {
        debugPrint('Data and image posted successfully!');
        Navigator.pop(context); // balik ke tampilan sebelumnya/customer service
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => CustomerScreen()));
      } else {
        debugPrint('Error posting data: ${response.statusCode}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 56, 187, 231),
      appBar: AppBar(
        title: Text(
          'Customer Service',
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // DropdownButtonFormField<String>(
              //   value: _selectedDivision,
              //   decoration: InputDecoration(
              //     labelText: 'Division',
              //     labelStyle: GoogleFonts.poppins(
              //       color: Colors.black,
              //       fontWeight: FontWeight.bold,
              //       fontSize: 18,
              //     ),
              //     border: OutlineInputBorder(),
              //   ),
              //   onChanged: (String? newValue) {
              //     setState(() {
              //       _selectedDivision = newValue!;
              //     });
              //   },
              //   items: <String>['Dailing', 'Teknis', 'Support']
              //       .map<DropdownMenuItem<String>>((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value),
              //     );
               //   }).toList(),
              // ),
              DropdownButtonFormField<String>(
                                      value: _selectedType,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _selectedType = newValue;
                                        });
                                      },
                                      items: _checkboxData.map((data) {
                                        return DropdownMenuItem<String>(
                                          value: data['type'],
                                          child: Text(data['type']),
                                        );
                                      }).toList(),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Select Division Type',
                                      ),
                                    ),
              SizedBox(height: 20),
              Text(
                'Upload Image',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _showPicker(context: context);
                },
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: galleryFile == null
                      ? Center(
                          child: Icon(
                            Icons.add_a_photo,
                            size: 40,
                            color: const Color.fromARGB(255, 56, 187, 231),
                          ),
                        )
                      : Image.file(galleryFile!),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Title',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _title = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Enter title',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Description',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _description = value;
                  });
                },
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Enter description',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Rating',                   // RATING
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              // code rating
              Center(
                child: RatingBar.builder(
                  initialRating: _rating.toDouble(),
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemSize: 40,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating.toInt();
                    });
                  },
                ),
              ),
              // Slider(
              //   // priority
              //   value: _priority,
              //   onChanged: (newValue) {
              //     setState(() {
              //       _priority = newValue;
              //     });
              //   },
              //   min: 0,
              //   max: 10, // Set the maximum priority value
              //   divisions: 10, // Divide the slider into 10 divisions
              //   label: _priority.toString(),
              // ),
               SizedBox(height: 16.0),
                                Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 8),
                                      Text(
                                        'Select Priority:',
                                          style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      ToggleButtons(
                                        isSelected: [
                                          _priority == 'high',
                                          _priority == 'low'
                                        ],
                                        onPressed: (int newIndex) {
                                          setState(() {
                                            _priority =
                                                newIndex == 0 ? 'high' : 'low';
                                          });
                                        },
                                      borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderWidth: 2.0,
                                        borderColor: Colors.grey,
                                        selectedBorderColor: Colors
                                            .white, // ganti akses menjadi warna putih
                                        fillColor: Colors
                                            .white, // ganti akses menjadi warna putih
                                        selectedColor: Colors.black,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Text(
                                              'High',
                                              style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Text(
                                              'Low',
                                              style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          ),
                                        ],
                                      ),
              SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _postDataWithImage(context);
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Color.fromARGB(255, 0, 0, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
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
