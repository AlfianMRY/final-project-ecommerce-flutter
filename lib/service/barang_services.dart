import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/barang.dart';

class BarangServices {
  Future<List<Barang>> getAll(token) async {
    Uri url = Uri.parse('https://api1.sib3.nurulfikri.com/api/admin/barang');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${token}',
    });
    print('data : ' + response.statusCode.toString());
    if (response.statusCode == 200) {
      final hasil = (json.decode(response.body))['data'] as List;
      final barang = hasil.map((e) {
        return Barang(
          id: e['id'],
          name: e['name'],
          categoryId: e['category_id'],
          image: e['image'],
          imagePath: e['image_path'],
          harga: e['harga'],
          deskripsi: e['deskripsi'],
          stock: e['stock'],
          createdAt: e['created_at'],
          updatedAt: e['updated_at'],
          deletedAt: e['deleted_at'],
        );
      }).toList();
      return barang;
    } else {
      return [];
    }
  }
}
