import 'dart:convert';
import 'package:final_project/providers/token.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import '../models/barang.dart';
import '../service/barang_services.dart';
// import 'dart:io';

class BarangProvider extends Token with ChangeNotifier {
  final _service = BarangServices();
  bool isLoading = false;
  bool fav = false;

  List<Barang> _barang = [];
  List<Barang> get barang => _barang;

  Future<void> getAllBarang() async {
    isLoading = true;
    notifyListeners();
    final response = await _service.getAll(token);
// print(response)
    _barang = response;
    isLoading = false;
    notifyListeners();
  }

  Future deleteBarang(String barangId) async {
    try {
      String url =
          'https://api1.sib3.nurulfikri.com/api/admin/barang/' + barangId;
      var response = await http.delete(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ' + token,
        },
      );
      notifyListeners();
      return jsonDecode(response.body);
    } catch (e) {
      print(e);
    }
  }

  Future submitForm({
    required name,
    required stock,
    required category,
    required deskripsi,
    required harga,
    required image,
  }) async {
    var url = Uri.parse('https://api1.sib3.nurulfikri.com/api/admin/barang');

    try {
      var request = new http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer ${token}';
      request.fields['name'] = name.text;
      request.fields['stock'] = stock.text;
      request.fields['category_id'] = category.toString();
      request.fields['deskripsi'] = deskripsi.text;
      request.fields['harga'] = harga.text;
      request.files.add(await http.MultipartFile.fromPath('image', image));

      var response = await request.send();
      notifyListeners();
      return response;
    } catch (e) {
      print(e);
    }
  }
}
