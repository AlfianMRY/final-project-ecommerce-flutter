import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:final_project_provider/models/category.dart';

class CategoryServices {
  Future<List<Category>> getAll(token) async {
    Uri url = Uri.parse('https://api1.sib3.nurulfikri.com/api/admin/category');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${token}',
    });
    print('data : ' + response.statusCode.toString());
    if (response.statusCode == 200) {
      final hasil = (json.decode(response.body))['data'] as List;
      final category = hasil.map((e) {
        return Category(
          id: e['id'],
          name: e['name'],
          createdAt: e['created_at'],
          updatedAt: e['updated_at'],
          deletedAt: e['deleted_at'],
        );
      }).toList();
      return category;
    } else {
      return [];
    }
  }
}
