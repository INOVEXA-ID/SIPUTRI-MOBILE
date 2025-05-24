import 'dart:developer';

import 'package:siputri_mobile/core/constants/api_constants.dart';
import 'package:siputri_mobile/core/services/dio_client.dart';
import 'package:siputri_mobile/features/detail_buku/models/ulasan_kamu.dart';

class UlasanKamuRepository {
  final DioClient dioClient;

  UlasanKamuRepository(this.dioClient);

  Future<UlasanKamuModel> getUlasanKamu({required String id}) async {
    final response = await dioClient.dio.get(
      "${ApiConstants.ulasanKamuEndpoint}/$id",
    );

    if (response.statusCode == 200) {
      final data = response.data;
      log(data.toString());
      return UlasanKamuModel.fromJson(data);
    } else {
      throw Exception('Gagal memuat data ulasan kamu');
    }
  }

  Future<UlasanKamuModel> postUlasanKamu({
    required idUser,
    required idBuku,
    required ulasan,
    required rating,
  }) async {
    final response = await dioClient.dio.post(
      ApiConstants.postUlasanEndpoint,
      data: {
        'id_user': idUser,
        'id_buku': idBuku,
        'ulasan': ulasan,
        'rating': rating,
      },
    );

    if (response.statusCode == 200) {
      final data = response.data;
      log(data.toString());
      return UlasanKamuModel.fromJson(data);
    } else {
      throw Exception('Gagal menambah data ulasan kamu');
    }
  }

  Future<UlasanKamuModel> updateUlasanKamu({
    required idUser,
    required idBuku,
    required ulasan,
    required rating,
  }) async {
    final response = await dioClient.dio.put(
      ApiConstants.updateUlasanEndpoint,
      data: {
        'id_user': idUser,
        'id_buku': idBuku,
        'ulasan': ulasan,
        'rating': rating,
      },
    );

    if (response.statusCode == 200) {
      final data = response.data;
      log(data.toString());
      return UlasanKamuModel.fromJson(data);
    } else {
      throw Exception('Gagal merubah data ulasan kamu');
    }
  }
}
