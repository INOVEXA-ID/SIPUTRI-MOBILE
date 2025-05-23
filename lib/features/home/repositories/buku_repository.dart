import 'package:siputri_mobile/core/constants/api_constants.dart';
import 'package:siputri_mobile/core/services/dio_client.dart';
import 'package:siputri_mobile/features/home/models/buku_model.dart';

class BukuRepository {
  final DioClient dioClient;

  BukuRepository(this.dioClient);

  Future<BukuModel> getBooks() async {
    final response = await dioClient.dio.get(ApiConstants.bukuEndpoint);

    if (response.statusCode == 200) {
      final data = response.data;
      return BukuModel.fromJson(data);
    } else {
      throw Exception('Gagal memuat data buku');
    }
  }
}
