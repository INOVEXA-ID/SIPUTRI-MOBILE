import 'dart:developer';

import 'package:siputri_mobile/core/constants/api_constants.dart';
import 'package:siputri_mobile/core/services/dio_client.dart';
import 'package:siputri_mobile/features/detail_buku/models/daftar_antrian.dart';

class DaftarAntrianRepository {
  final DioClient dioClient;

  DaftarAntrianRepository(this.dioClient);

  Future<DaftarAntrianModel> getDetailBooks({required String idBuku}) async {
    final response = await dioClient.dio.get(
      "${ApiConstants.daftarAntrianEndpoint}/$idBuku",
    );

    if (response.statusCode == 200) {
      final data = response.data;
      log(data.toString());
      return DaftarAntrianModel.fromJson(data);
    } else {
      throw Exception('Gagal memuat data detail buku');
    }
  }
}
