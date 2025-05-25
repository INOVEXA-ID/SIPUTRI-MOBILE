import 'dart:developer';

import 'package:siputri_mobile/core/constants/api_constants.dart';
import 'package:siputri_mobile/core/services/dio_client.dart';
import 'package:siputri_mobile/features/detail_buku/models/ulasan_global_model.dart';

class UlasanGlobalRepository {
  final DioClient dioClient;

  UlasanGlobalRepository(this.dioClient);

  Future<UlasanGlobalModel> getUlasanGlobal({required String id}) async {
    final response = await dioClient.dio.get(
      "${ApiConstants.ulasanGlobalEndpoint}/$id",
    );

    if (response.statusCode == 200) {
      final data = response.data;
      log(data.toString());
      return UlasanGlobalModel.fromJson(data);
    } else {
      throw Exception('Gagal memuat data ulasan global');
    }
  }
}
