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
    required String telepon,
    required String alamat,
    required String jenisKelamin,
    File? foto,
  }) async {
    final token = TokenStorage().token;
    if (token == null) throw Exception("Not authenticated");

    final formData = FormData.fromMap({
      "nama": nama,
      "telepon": telepon,
      "alamat": alamat,
      "jenis_kelamin": jenisKelamin,
      if (foto != null)
        "foto": await MultipartFile.fromFile(
          foto.path,
          filename: foto.path.split('/').last,
        ),
    });

    // Gabungkan baseUrl + endpoint
    final url = "${ApiConstants.baseUrl}${ApiConstants.updateProfileEndpoint}";

    final response = await dio.post(
      url,
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
      final userJson = response.data['data'];
      if (userJson == null) {
        throw Exception(
          response.data['message'] ?? "Gagal update profil: data user kosong",
        );
      }
      final oldUser = TokenStorage().user;
      final user = User.fromJson(userJson);
      final mergedUser = User(
        idUser: user.idUser,
        nim: user.nim ?? oldUser?.nim,
        nama: user.nama,
        jenisKelamin: user.jenisKelamin,
        telepon: user.telepon,
        alamat: user.alamat,
        foto: user.foto,
        email: user.email ?? oldUser?.email,
      );
      await TokenStorage().saveUser(mergedUser);
      return mergedUser;
    } else {
      throw Exception(response.data['message'] ?? "Gagal update profil");
    }
  }
}
