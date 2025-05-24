import 'package:siputri_mobile/core/constants/api_constants.dart';
import 'package:siputri_mobile/core/services/dio_client.dart';

class BatalAntrianRepository {
  final DioClient dioClient;

  BatalAntrianRepository(this.dioClient);

  Future<String> antriBuku({required String idBuku}) async {
    try {
      final response = await dioClient.dio.delete(
        ApiConstants.batalAntrianEndpoint,
        data: {'id_buku': idBuku},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return data['message'];
      } else {
        throw Exception('Gagal batal buku');
      }
    } catch (e) {
      return e.toString();
    }
  }
}
