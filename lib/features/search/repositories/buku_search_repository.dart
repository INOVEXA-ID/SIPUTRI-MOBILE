import 'package:siputri_mobile/core/constants/api_constants.dart';
import 'package:siputri_mobile/core/services/dio_client.dart';
import 'package:siputri_mobile/features/search/models/buku_search_model.dart';

class BukuSearchRepository {
  final DioClient dioClient;

  BukuSearchRepository(this.dioClient);

  Future<BukuSearchModel> getBooks({required String search}) async {
    final response = await dioClient.dio.get(
      "${ApiConstants.bukuEndpoint}$search",
    );

    if (response.statusCode == 200) {
      final data = response.data;
      return BukuSearchModel.fromJson(data);
    } else {
      throw Exception('Gagal memuat data buku');
    }
  }
}
