import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:siputri_mobile/features/bookshelf/models/peminjaman_model.dart';
import 'package:siputri_mobile/core/constants/api_constants.dart';

class BookshelfApi {
  static Future<List<PeminjamanModel>> getReadingList() async {
    final url = Uri.parse(
      '${ApiConstants.baseUrl}${ApiConstants.sedangDibacaEndpoint}',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List data = jsonData['data'];
      return data.map((e) => PeminjamanModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load reading list');
    }
  }
}
