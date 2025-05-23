import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:siputri_mobile/core/constants/api_constants.dart';
import 'package:siputri_mobile/core/helper/token_storage.dart';
import 'package:siputri_mobile/core/helper/user_model.dart';
import 'package:siputri_mobile/core/services/dio_client.dart';

class AuthRepository {
  final DioClient dioClient;

  AuthRepository(this.dioClient);

  Future<void> login({required String email, required String password}) async {
    try {
      final response = await dioClient.dio.post(
        ApiConstants.loginEndpoint,
        data: {'email': email, 'password': password},
      );
      log(response.data.toString());
      if (response.statusCode == 200) {
        final token = response.data['token'];
        final user = User.fromJson(response.data['user']);
        await TokenStorage().saveToken(token); // simpan token
        await TokenStorage().saveUser(user); // simpan token
      } else {
        throw Exception('Login gagal');
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
