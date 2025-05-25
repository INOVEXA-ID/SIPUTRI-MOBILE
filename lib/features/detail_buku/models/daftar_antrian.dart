// To parse this JSON data, do
//
//     final daftarAntrianModel = daftarAntrianModelFromJson(jsonString);

import 'dart:convert';

DaftarAntrianModel daftarAntrianModelFromJson(String str) =>
    DaftarAntrianModel.fromJson(json.decode(str));

String daftarAntrianModelToJson(DaftarAntrianModel data) =>
    json.encode(data.toJson());

class DaftarAntrianModel {
  String bukuId;
  List<DaftarAntrean> daftarAntrean;
  int jumlahAntrean;

  DaftarAntrianModel({
    required this.bukuId,
    required this.daftarAntrean,
    required this.jumlahAntrean,
  });

  factory DaftarAntrianModel.fromJson(Map<String, dynamic> json) =>
      DaftarAntrianModel(
        bukuId: json["buku_id"],
        daftarAntrean: List<DaftarAntrean>.from(
          json["daftar_antrean"].map((x) => DaftarAntrean.fromJson(x)),
        ),
        jumlahAntrean: json["jumlah_antrean"],
      );

  Map<String, dynamic> toJson() => {
    "buku_id": bukuId,
    "daftar_antrean": List<dynamic>.from(daftarAntrean.map((x) => x.toJson())),
    "jumlah_antrean": jumlahAntrean,
  };
}

class DaftarAntrean {
  int idPeminjaman;
  int idUser;
  int antreanKe;
  DateTime tanggalPeminjaman;
  User user;

  DaftarAntrean({
    required this.idPeminjaman,
    required this.idUser,
    required this.antreanKe,
    required this.tanggalPeminjaman,
    required this.user,
  });

  factory DaftarAntrean.fromJson(Map<String, dynamic> json) => DaftarAntrean(
    idPeminjaman: json["id_peminjaman"],
    idUser: json["id_user"],
    antreanKe: json["antrean_ke"],
    tanggalPeminjaman: DateTime.parse(json["tanggal_peminjaman"]),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id_peminjaman": idPeminjaman,
    "id_user": idUser,
    "antrean_ke": antreanKe,
    "tanggal_peminjaman": tanggalPeminjaman.toIso8601String(),
    "user": user.toJson(),
  };
}

class User {
  int idUser;
  String nim;
  String nama;
  String jenisKelamin;
  String telepon;
  String alamat;
  String? foto;
  String email;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    required this.idUser,
    required this.nim,
    required this.nama,
    required this.jenisKelamin,
    required this.telepon,
    required this.alamat,
    required this.foto,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    idUser: json["id_user"],
    nim: json["nim"],
    nama: json["nama"],
    jenisKelamin: json["jenis_kelamin"],
    telepon: json["telepon"],
    alamat: json["alamat"],
    foto: json["foto"],
    email: json["email"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id_user": idUser,
    "nim": nim,
    "nama": nama,
    "jenis_kelamin": jenisKelamin,
    "telepon": telepon,
    "alamat": alamat,
    "foto": foto,
    "email": email,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
