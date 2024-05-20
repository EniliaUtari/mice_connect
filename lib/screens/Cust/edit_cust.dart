import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mice_connect/dto/cust.dart';
import 'package:mice_connect/endpoints/cust_endpoint.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mice_connect/screens/Cust/cust_screen.dart';

class EditDatas extends StatefulWidget {
  final CustomerService customerService;
  const EditDatas(this.customerService, {Key? key}) : super(key: key);

  @override
  _EditDatasState createState() => _EditDatasState();
}

class _EditDatasState extends State<EditDatas> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  File? galleryFile;
  final picker = ImagePicker();
  String _priority = 'high';

  // inisialisasi untuk dropdown division
  List<Map<String, dynamic>> _checkboxData = [
    {"id": 1, "type": "Billing"},
    {"id": 2, "type": "Support"},
    {"id": 3, "type": "Teknis"},
  ];

  String? _selectedType;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.customerService.titleIssues;
    _ratingController.text = widget.customerService.rating.toString();
    _descriptionController.text = widget.customerService.descriptionIssues;

    if (widget.customerService.imageUrl != null) {
      setState(() {
        galleryFile = null;
      });
    } else {
      setState(() {
        galleryFile = null;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _ratingController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _showPicker({required BuildContext context}) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Library'),
                    onTap: () {
                      _getImage(ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      _getImage(ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _getImage(ImageSource img) async {
    final pickedFile = await picker.pickImage(source: img);
    if (pickedFile != null) {
      setState(() {
        galleryFile = File(pickedFile.path);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nothing is selected')),
      );
    }
  }

  Future<void> _editDatas(BuildContext context, int idCustomerService) async {
    final String title = _titleController.text;
    final String description = _descriptionController.text;
    final int rating = int.tryParse(_ratingController.text) ?? 0;

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide a title'),
        ),
      );
      return;
    }

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${Endpoints.newcs}/$idCustomerService'),
    );

    request.fields['title_issues'] = title;
    request.fields['description_issues'] = description;
    request.fields['rating'] = rating.toString();

    if (galleryFile != null) {
      var multipartFile = await http.MultipartFile.fromPath(
        'image',
        galleryFile!.path,
      );
      request.files.add(multipartFile);
    }

    var streamedResponse = await request.send();
    if (streamedResponse.statusCode == 200) {
      debugPrint('Data edited successfully!');
      Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CustomerScreen()));
    } else {
      debugPrint('Error editing data: ${streamedResponse.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 56, 187, 231),
      appBar: AppBar(
        title: Text(
          'Update Customer Service',
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
                      ? widget.customerService.imageUrl != null
                          ? Image.network(
                              '${Endpoints.baseURL}/public/${widget.customerService.imageUrl!}',
                              width: 100,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.error),
                            )
                          : Center(
                              child: Text(
                                'Pick your Image here',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color:
                                      const Color.fromARGB(255, 124, 122, 122),
                                  fontWeight: FontWeight.w500,
                                ),
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
                controller: _titleController,
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
                controller: _descriptionController,
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
                'Rating',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Center(
                child: RatingBar.builder(
                  initialRating: double.parse(_ratingController.text),
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
                      _ratingController.text = rating.toInt().toString();
                    });
                  },
                ),
              ),
              // Slider(
              //   value: _priority,
              //   onChanged: (newValue) {
              //     setState(() {
              //       _priority = newValue;
              //     });
              //   },
              //   min: 0,
              //   max: 5,
              //   divisions: 5,
              //   label: _priority.toString(),
              // ),
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
                                            .white, // Ganti dengan warna aksen putih
                                        fillColor: Colors
                                            .white, // Ganti dengan warna aksen putih
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
                    _editDatas(
                        context, widget.customerService.idCustomerService);
                  },
                  child: Text('Submit'),
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
    //         ],
    //   ),
    // ),
    // ),
    // );
  }
}



