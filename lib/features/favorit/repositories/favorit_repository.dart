import 'package:siputri_mobile/core/constants/api_constants.dart';
import 'package:siputri_mobile/core/services/dio_client.dart';
import 'package:siputri_mobile/features/favorit/models/favorit_model.dart';
import 'package:siputri_mobile/core/helper/token_storage.dart'; // Tambahkan ini

class FavoritRepository {
  final DioClient dioClient;

  FavoritRepository({required this.dioClient});

  Future<FavoritModel> getFavorit() async {
    // Ambil id_user dari token
    final user = TokenStorage().user;
    if (user == null) {
      throw Exception('User belum login!');
    }
    final idUser = user.idUser;

    final response = await dioClient.dio.get(
      "${ApiConstants.favoritEndpoint}/$idUser",
    );
    if (response.statusCode == 200) {
      final data = response.data;
      return FavoritModel.fromJson(data);
    } else {
      throw Exception('Gagal memuat data favorit');
    }
  }
}
