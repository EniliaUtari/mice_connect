import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mice_connect/screens/Cust/edit_cust.dart';
import 'package:mice_connect/screens/Cust/add_new.dart';
import 'package:mice_connect/dto/cust.dart';
import 'package:mice_connect/endpoints/cust_endpoint.dart';
import 'package:mice_connect/services/cust_service.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart'; // import package

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  Future<List<CustomerService>>? newcs;

  @override
  void initState() {
    super.initState();
    newcs = DataService.fetchCustomerService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Service"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 56, 187, 231),
        tooltip: 'Add New Customer Service',
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const FormScreen()));
        },
        child: const Icon(Icons.add, color: Colors.black),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: FutureBuilder<List<CustomerService>>(
          future: newcs,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data!;
              return ListView.builder(
                shrinkWrap: true, // Wrap listview content
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final item = data[index];
                  return ListTile(
                    title: item.imageUrl != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                Uri.parse(
                                  '${Endpoints.baseURL}/public/${item.imageUrl!}',
                                ).toString(),
                                width: 100,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.error),
                              ),
                            ],
                          )
                        : null,
                    subtitle: Column(
                      children: [
                        SizedBox(height: 10),
                        Text(
                          'Title : ${item.titleIssues}',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: const Color.fromARGB(255, 36, 31, 31),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          'Deskripsi : ${item.descriptionIssues}',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: const Color.fromARGB(255, 36, 31, 31),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Rating: ',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: const Color.fromARGB(255, 36, 31, 31),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            RatingBarIndicator(
                              rating:
                                  item.rating.toDouble(), // set rating value
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5, // total stars
                              itemSize: 20.0,
                              direction: Axis.horizontal,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditDatas(
                                        item), //proses edit connect ke editdata
                                  ),
                                );
                              },
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () async {
                                try {
                                  await DataService.deleteDatas(item.idCustomerService);
                                  // Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text('Data berhasil dihapus!'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                  setState(() {
                                    newcs =
                                        DataService.fetchCustomerService();
                                  });
                                } catch (error) {
                                  debugPrint('Gagal menghapus data: $error');
                                }
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                        const Divider(),
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
