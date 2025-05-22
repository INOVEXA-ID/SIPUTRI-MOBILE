import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:siputri_mobile/core/constants/api_constants.dart';
import 'package:siputri_mobile/core/services/dio_client.dart';

class RegisterRepository {
  final DioClient dioClient;

  RegisterRepository(this.dioClient);

  Future<void> register({
    required String nim,
    required String nama,
    required String jenisKelamin,
    required String telepon,
    required String alamat,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await dioClient.dio.post(
        ApiConstants.registerEndpoint,
        data: {
          'nim': nim,
          'nama': nama,
          'jenis_kelamin': jenisKelamin,
          'telepon': telepon,
          'alamat': alamat,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );
      log(response.data.toString());
      if (response.statusCode != 200) {
        throw Exception('Gagal register');
      }
    } catch (e) {
      if (e is DioException) {
        log("Status: ${e.response?.statusCode}");
        log("Data: ${e.response?.data}");
        throw Exception(e.response?.data['message'] ?? 'Login gagal');
      }
      throw Exception('Terjadi kesalahan');
    }
  }
}
