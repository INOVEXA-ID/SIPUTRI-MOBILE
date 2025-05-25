import 'package:siputri_mobile/core/constants/api_constants.dart';
import 'package:siputri_mobile/core/services/dio_client.dart';
import 'package:siputri_mobile/features/bookshelf/models/peminjaman_model.dart';

class PeminjamanBukuRepository {
  final DioClient dioClient;

  PeminjamanBukuRepository(this.dioClient);

  Future<List<PeminjamanModel>> getSedangDibacaList() async {
    final response = await dioClient.dio.get(ApiConstants.sedangDibacaEndpoint);

    if (response.statusCode == 200) {
      final data = response.data['data'] as List;
      return data.map((e) => PeminjamanModel.fromJson(e)).toList();
    } else {
      throw Exception('Gagal memuat daftar peminjaman');
    }
  }

  Future<List<PeminjamanModel>> getRiwayatPeminjamanList() async {
    final response = await dioClient.dio.get(
      ApiConstants.riwayatPeminjamanEndpoint,
    );

    if (response.statusCode == 200) {
      final data = response.data['data'] as List;
      return data.map((e) => PeminjamanModel.fromJson(e)).toList();
    } else {
      throw Exception('Gagal memuat riwayat peminjaman');
    }
  }
}
