import 'package:siputri_mobile/core/constants/api_constants.dart';
import 'package:siputri_mobile/core/services/dio_client.dart';

class FavoritDetailBukuRepository {
  final DioClient dioClient;

  FavoritDetailBukuRepository(this.dioClient);

  Future<String> postFavorit({required String idBuku}) async {
    try {
      final response = await dioClient.dio.post(
        ApiConstants.favoritTambahEndpoint,
        data: {'id_buku': idBuku},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return data['message'];
      } else {
        throw Exception('Gagal nambah favorit');
      }
    } catch (e) {
      return e.toString();
    }
  }
}
