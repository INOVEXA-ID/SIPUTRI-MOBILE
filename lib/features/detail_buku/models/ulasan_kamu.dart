import 'dart:convert';

UlasanKamuModel ulasanKamuModelFromJson(String str) =>
    UlasanKamuModel.fromJson(json.decode(str));

String ulasanKamuModelToJson(UlasanKamuModel data) =>
    json.encode(data.toJson());

class UlasanKamuModel {
  String message;
  Data? data;

  UlasanKamuModel({required this.message, required this.data});

  factory UlasanKamuModel.fromJson(Map<String, dynamic> json) =>
      UlasanKamuModel(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"message": message, "data": data?.toJson()};
}

class Data {
  int idUlasan;
  String ulasan;
  String rating;
  int idBuku;
  int idUser;
  DateTime createdAt;
  DateTime updatedAt;
  User user;

  Data({
    required this.idUlasan,
    required this.ulasan,
    required this.rating,
    required this.idBuku,
    required this.idUser,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    idUlasan: json["id_ulasan"],
    ulasan: json["ulasan"],
    rating: json["rating"],
    idBuku: json["id_buku"],
    idUser: json["id_user"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id_ulasan": idUlasan,
    "ulasan": ulasan,
    "rating": rating,
    "id_buku": idBuku,
    "id_user": idUser,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
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
