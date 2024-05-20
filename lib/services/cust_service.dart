import 'package:http/http.dart' as http;
import 'package:mice_connect/dto/cust.dart';
import 'dart:convert';
import 'package:mice_connect/endpoints/cust_endpoint.dart';

class DataService {
  //memanggil dan menampilkan seluruh data customer yang udah diinput
  static Future<List<CustomerService>> fetchCustomerService() async {
    final response = await http.get(Uri.parse(Endpoints.newcs));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>)
          .map((item) => CustomerService.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      // Ketika data gagal diinput
      throw Exception('Failed to load data');
    }
  }

// Delete data yang sudah diinput
static Future<void> deleteDatas(
    int idCustomerService,
  ) async {
    final url =
        '${Endpoints.newcs}/$idCustomerService'; // URL untuk menghapus data dengan ID tertentu

    final response = await http.delete(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete Data');
    }
  }
}