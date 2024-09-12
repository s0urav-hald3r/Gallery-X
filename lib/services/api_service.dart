import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/image_model.dart';

class ApiService {
  static const String _pixabayApiKey = '29481127-2d760354235030d99ef6916eb';
  static const String _baseUrl = 'https://pixabay.com/api/';

  int imagePerPage = kIsWeb ? 50 : 20;

  Future<List<ImageModel>> fetchImages(String query, int page) async {
    final response = await http.get(Uri.parse(
        '$_baseUrl?key=$_pixabayApiKey&q=$query&image_type=photo&page=$page&per_page=$imagePerPage'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['hits'] as List)
          .map((imageData) => ImageModel.fromJson(imageData))
          .toList();
    } else {
      throw Exception('Failed to load images');
    }
  }
}
