// import 'package:provider/provider.dart';

import 'package:final_project_provider/providers/token.dart';
import 'package:final_project_provider/service/review_services.dart';
import 'package:flutter/cupertino.dart';
import '../models/review.dart';

class ReviewProvider extends Token with ChangeNotifier {
  final _service = ReviewServices();
  bool isLoading = false;

  List<Review> _review = [];
  List<Review> get review => _review;

  Future<void> getAllReview(String id) async {
    isLoading = true;
    notifyListeners();
    final response = await _service.getAll(token, id);

    _review = response;
    isLoading = false;
    notifyListeners();
  }
}
