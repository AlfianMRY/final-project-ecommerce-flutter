// import 'package:final_project_provider/providers/review_provider.dart';
import 'package:http/http.dart' as http;
import '../models/review.dart';
import 'dart:convert';

class ReviewServices {
  Future<List<Review>> getAll(token, id) async {
    Uri url = Uri.parse('https://api1.sib3.nurulfikri.com/api/review/' + id);
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
    print('data : ' + response.statusCode.toString());
    if (response.statusCode == 200) {
      final hasil = (json.decode(response.body))['data'] as List;
      final review = hasil.map((e) {
        return Review(
          id: e['id'],
          productId: e['product_id'],
          userId: e['user_id'],
          star: e['star'],
          review: e['review'],
          image: e['image'],
          imagePath: e['image_path'],
          createdAt: e['created_at'],
          updatedAt: e['updated_at'],
          user: User(
            id: e['user']['id'],
            name: e['user']['name'],
            email: e['user']['email'],
            handphone: e['user']['handphone'],
            createdAt: e['user']['created_at'],
            updatedAt: e['user']['updated_at'],
            role: e['user']['role'],
          ),
        );
      }).toList();
      return review;
    } else {
      return [];
    }
  }
}
