import 'package:siputri_mobile/core/constants/api_constants.dart';
import 'package:siputri_mobile/core/services/dio_client.dart';
import 'package:siputri_mobile/features/detail_buku/models/detail_buku_model.dart';

class DetailBukuRepository {
  final DioClient dioClient;

  DetailBukuRepository(this.dioClient);

  Future<DetailBukuModel> getDetailBooks({required String id}) async {
    final response = await dioClient.dio.get(
      "${ApiConstants.detailBukuEndpoint}/$id",
    );

    if (response.statusCode == 200) {
      final data = response.data;
      return DetailBukuModel.fromJson(data);
    } else {
      throw Exception('Gagal memuat data detail buku');
    }
  }
}
