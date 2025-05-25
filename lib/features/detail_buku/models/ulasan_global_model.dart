// To parse this JSON data, do
//
//     final ulasanGlobalModel = ulasanGlobalModelFromJson(jsonString);

import 'dart:convert';

UlasanGlobalModel ulasanGlobalModelFromJson(String str) =>
    UlasanGlobalModel.fromJson(json.decode(str));

String ulasanGlobalModelToJson(UlasanGlobalModel data) =>
    json.encode(data.toJson());

class UlasanGlobalModel {
  String bukuId;
  List<Ulasan> ulasan;
  int jumlahUlasan;
  bool bolehUlasan;

  UlasanGlobalModel({
    required this.bukuId,
    required this.ulasan,
    required this.jumlahUlasan,
    required this.bolehUlasan,
  });

  factory UlasanGlobalModel.fromJson(Map<String, dynamic> json) =>
      UlasanGlobalModel(
        bukuId: json["buku_id"],
        ulasan: List<Ulasan>.from(
          json["ulasan"].map((x) => Ulasan.fromJson(x)),
        ),
        jumlahUlasan: json["jumlah_ulasan"],
        bolehUlasan: json["boleh_ulasan"],
      );

  Map<String, dynamic> toJson() => {
    "buku_id": bukuId,
    "ulasan": List<dynamic>.from(ulasan.map((x) => x.toJson())),
    "jumlah_ulasan": jumlahUlasan,
    "boleh_ulasan": bolehUlasan,
  };
}

class Ulasan {
  int idUlasan;
  int idUser;
  String ulasan;
  String rating;
  DateTime createdAt;
  User user;

  Ulasan({
    required this.idUlasan,
    required this.idUser,
    required this.ulasan,
    required this.rating,
    required this.createdAt,
    required this.user,
  });

  factory Ulasan.fromJson(Map<String, dynamic> json) => Ulasan(
    idUlasan: json["id_ulasan"],
    idUser: json["id_user"],
    ulasan: json["ulasan"],
    rating: json["rating"],
    createdAt: DateTime.parse(json["created_at"]),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id_ulasan": idUlasan,
    "id_user": idUser,
    "ulasan": ulasan,
    "rating": rating,
    "created_at": createdAt.toIso8601String(),
    "user": user.toJson(),
  };
}

class User {
  int idUser;
  String nim;
  String nama;
  String? foto;

  User({
    required this.idUser,
    required this.nim,
    required this.nama,
    required this.foto,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    idUser: json["id_user"],
    nim: json["nim"],
    nama: json["nama"],
    foto: json["foto"],
  );

  Map<String, dynamic> toJson() => {
    "id_user": idUser,
    "nim": nim,
    "nama": nama,
    "foto": foto,
  };
}
