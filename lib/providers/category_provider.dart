import 'dart:convert';

import 'package:final_project_provider/providers/token.dart';
import 'package:final_project_provider/service/category_service.dart';
import 'package:flutter/cupertino.dart';
import '../models/category.dart';
import 'package:http/http.dart' as http;

class CategoryProvider extends Token with ChangeNotifier {
  final _service = CategoryServices();
  bool isLoading = false;

  List<Category> _category = [];
  List<Category> get category => _category;

  Future<void> getAllCategory() async {
    isLoading = true;
    notifyListeners();
    final response = await _service.getAll(token);

    _category = response;
    isLoading = false;
    notifyListeners();
  }

  Future submitForm({required String nameC}) async {
    // print(this.getToken());
    final response = await http.post(
      Uri.parse('https://api1.sib3.nurulfikri.com/api/admin/category'),
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      body: {'name': nameC},
    );
    if (response.statusCode == 200) {
      notifyListeners();
      return 'success';
    } else {
      return 'gagal';
    }
  }

  Future editForm({required String nameC, required String id}) async {
    // print(this.getToken());
    final response = await http.put(
      Uri.parse('https://api1.sib3.nurulfikri.com/api/admin/category/' + id),
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      body: {'name': nameC},
    );
    if (response.statusCode == 200) {
      notifyListeners();
      return 'success';
    } else {
      return 'gagal';
    }
  }

  Future deleteCategory({required String id}) async {
    try {
      String url = 'https://api1.sib3.nurulfikri.com/api/admin/category/' + id;
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

  // getToken() {
  //   return '3137|cu0xmH39LEFRQjDhyzldATTorgTlNRfcrwN22ncX';
  // }
}
