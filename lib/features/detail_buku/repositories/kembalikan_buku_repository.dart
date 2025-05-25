import 'package:siputri_mobile/core/constants/api_constants.dart';
import 'package:siputri_mobile/core/services/dio_client.dart';

class KembalikanBukuRepository {
  final DioClient dioClient;

  KembalikanBukuRepository(this.dioClient);

  Future<String> kembalikanBuku({required String idBuku}) async {
    try {
      final response = await dioClient.dio.put(
        ApiConstants.kembalikanBukuEndpoint,
        data: {'id_buku': idBuku},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return data['message'];
      } else {
        throw Exception('Gagal kembalikan buku');
      }
    } catch (e) {
      return e.toString();
    }
  }
}
