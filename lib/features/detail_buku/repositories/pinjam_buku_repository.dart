import 'package:siputri_mobile/core/constants/api_constants.dart';
import 'package:siputri_mobile/core/services/dio_client.dart';

class PinjamBukuRepository {
  final DioClient dioClient;

  PinjamBukuRepository(this.dioClient);

  Future<String> pinjamBuku({required String idBuku}) async {
    try {
      final response = await dioClient.dio.post(
        ApiConstants.pinjamBukuEndpoint,
        data: {'id_buku': idBuku},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return data['message'];
      } else {
        throw Exception('Gagal meminjam buku');
      }
    } catch (e) {
      return e.toString();
    }
  }
}
