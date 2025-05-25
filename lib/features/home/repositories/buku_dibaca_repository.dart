import 'package:siputri_mobile/core/constants/api_constants.dart';
import 'package:siputri_mobile/core/services/dio_client.dart';
import 'package:siputri_mobile/features/home/models/buku_dibaca_model.dart';

class BukuDibacaRepository {
  final DioClient dioClient;

  BukuDibacaRepository(this.dioClient);

  Future<BukuDibacaModel> getBukuDibaca() async {
    final response = await dioClient.dio.get(ApiConstants.bukuDibacaEndpoint);

    if (response.statusCode == 200) {
      final data = response.data;
      return BukuDibacaModel.fromJson(data);
    } else {
      throw Exception('Gagal memuat data buku dibaca');
    }
  }
}
