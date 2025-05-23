import 'package:siputri_mobile/core/constants/api_constants.dart';
import 'package:siputri_mobile/core/services/dio_client.dart';
import 'package:siputri_mobile/features/favorit/models/favorit_model.dart';

class FavoritRepository {
  final DioClient dioClient;

  FavoritRepository({required this.dioClient});

  Future<FavoritModel> getFavorit() async {
    final response = await dioClient.dio.get(
      "${ApiConstants.favoritEndpoint}/2",
    );
    if (response.statusCode == 200) {
      final data = response.data;
      return FavoritModel.fromJson(data);
    } else {
      throw Exception('Gagal memuat data favorit');
    }
  }
}
