import 'dart:io';
import 'package:dio/dio.dart';
import 'package:siputri_mobile/core/constants/api_constants.dart';
import 'package:siputri_mobile/core/helper/token_storage.dart';
import 'package:siputri_mobile/core/helper/user_model.dart';

class ProfileRepository {
  final Dio dio;

  ProfileRepository(this.dio);

  Future<User> updateProfile({
    required String nama,
    required String email,
    required String telepon,
    required String alamat,
    required String jenisKelamin,
    File? foto,
  }) async {
    final token = TokenStorage().token;
    if (token == null) throw Exception("Not authenticated");

    final formData = FormData.fromMap({
      "nama": nama,
      "email": email,
      "telepon": telepon,
      "alamat": alamat,
      "jenis_kelamin": jenisKelamin,
      if (foto != null)
        "foto": await MultipartFile.fromFile(
          foto.path,
          filename: foto.path.split('/').last,
        ),
    });

    final response = await dio.put(
      ApiConstants.updateProfileEndpoint, // misal '/user/update'
      data: formData,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      ),
    );

    // Parse response (misal: {"message": "...", "user": {...}})
    if (response.statusCode == 200) {
      final user = User.fromJson(response.data['user']);
      await TokenStorage().saveUser(user);
      return user;
    } else {
      throw Exception(response.data['message'] ?? "Gagal update profil");
    }
  }
}
