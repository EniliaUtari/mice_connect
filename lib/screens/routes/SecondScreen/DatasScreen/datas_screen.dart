// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mice_connect/components/bottom_up_widget.dart';
import 'package:mice_connect/dto/datas.dart';
import 'package:mice_connect/endpoints/endpoints.dart';
import 'package:mice_connect/screens/routes/FormScreen/form_screen.dart';
import 'package:mice_connect/services/data_service.dart';

class DatasScreen extends StatefulWidget {
  const DatasScreen({Key? key}) : super(key: key);

  @override
  _DatasScreenState createState() => _DatasScreenState();
}

class _DatasScreenState extends State<DatasScreen> {
  Future<List<Datas>>? _datas;

  @override
  void initState() {
    super.initState();
    _datas = DataService.fetchDatas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data List'),
        leading: IconButton(
          icon: const Icon(Icons
              .arrow_back), // Customize icon (optional)// Customize color (optional)
          onPressed: () {
            // Your custom back button functionality here
            Navigator.pushReplacementNamed(
                context, '/'); // Default back button behavior
            // You can add additional actions here (e.g., show confirmation dialog)
          },
        ),
      ),
      body: FutureBuilder<List<Datas>>(
        future: _datas,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return ListTile(
                  title: item.imageUrl != null
                      ? Row(
                          children: [
                            Image.network(
                              fit: BoxFit.fitWidth,
                              width: 350,
                              Uri.parse(
                                      '${Endpoints.baseURLLive}/public/${item.imageUrl!}')
                                  .toString(),
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons
                                      .error), // Display error icon if image fails to load
                            ),
                          ],
                        )
                      : null,
                  subtitle: Column(children: [
                    Text('Name : ${item.name}',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 36, 31, 31),
                          fontWeight: FontWeight.normal,
                        )),
                        IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              // Panggil metode konfirmasi penghapusan saat tombol hapus ditekan
                              _confirmAndDelete(item);
                            },
                          ),
                    const Divider()
                  ]),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 54, 40, 176),
        tooltip: 'Increment',
        onPressed: () {
          // Navigator.pushNamed(context, '/form-screen');
          // BottomUpRoute(page: const FormScreen());
          Navigator.push(context, BottomUpRoute(page: const FormScreen()));
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  // Delete Latihan Datas
  Future<void> _confirmAndDelete(Datas datas) async {
    // Tampilkan dialog konfirmasi
    final bool confirmed = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Data'),
        content: Text('Are you sure you want to delete this data?'),
        actions: [
          TextButton(
            onPressed: () {
              // Tidak jadi menghapus, kembali dengan nilai false
              Navigator.of(context).pop(false);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Konfirmasi untuk menghapus, kembali dengan nilai true
              Navigator.of(context).pop(true);
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );

    // Jika pengguna mengonfirmasi penghapusan, lanjutkan penghapusan
    if (confirmed) {
      try {
        // Memanggil metode deleteDatas untuk menghapus data dengan ID tertentu
        await DataService.deleteDatas(datas.idDatas);
        // Refresh data setelah berhasil menghapus
        setState(() {
          _datas = DataService.fetchDatas();
        });
        // Tampilkan snackbar atau pesan berhasil dihapus
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Data deleted successfully'),
          ),
        );
      } catch (e) {
        // Tangani kesalahan jika gagal menghapus data
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete data: $e'),
          ),
        );
      }
    }
  }
}
