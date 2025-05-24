import 'package:siputri_mobile/core/constants/api_constants.dart';
import 'package:siputri_mobile/core/services/dio_client.dart';

class AntrianBukuRepository {
  final DioClient dioClient;

  AntrianBukuRepository(this.dioClient);

  Future<String> antriBuku({required String idBuku}) async {
    try {
      final response = await dioClient.dio.post(
        ApiConstants.antrianBukuEndpoint,
        data: {'id_buku': idBuku},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return data['message'];
      } else {
        throw Exception('Gagal antri buku');
      }
    } catch (e) {
      return e.toString();
    }
  }
}
