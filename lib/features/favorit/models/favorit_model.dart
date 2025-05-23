import 'dart:convert';

FavoritModel favoritModelFromJson(String str) =>
    FavoritModel.fromJson(json.decode(str));

String favoritModelToJson(FavoritModel data) => json.encode(data.toJson());

class FavoritModel {
  String message;
  List<Datum> data;

  FavoritModel({required this.message, required this.data});

  factory FavoritModel.fromJson(Map<String, dynamic> json) => FavoritModel(
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int idFavorit;
  int idBuku;
  int idUser;
  DateTime createdAt;
  DateTime updatedAt;
  Buku buku;

  Datum({
    required this.idFavorit,
    required this.idBuku,
    required this.idUser,
    required this.createdAt,
    required this.updatedAt,
    required this.buku,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idFavorit: json["id_favorit"],
    idBuku: json["id_buku"],
    idUser: json["id_user"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    buku: Buku.fromJson(json["buku"]),
  );

  Map<String, dynamic> toJson() => {
    "id_favorit": idFavorit,
    "id_buku": idBuku,
    "id_user": idUser,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "buku": buku.toJson(),
  };
}

class Buku {
  int idBuku;
  String judul;
  String deskripsi;
  String penulis;
  String penerbit;
  String isbn;
  String tahunTerbit;
  int jumlahBuku;
  int jumlahHalaman;
  String path;
  String thumbnail;
  DateTime createdAt;
  DateTime updatedAt;

  Buku({
    required this.idBuku,
    required this.judul,
    required this.deskripsi,
    required this.penulis,
    required this.penerbit,
    required this.isbn,
    required this.tahunTerbit,
    required this.jumlahBuku,
    required this.jumlahHalaman,
    required this.path,
    required this.thumbnail,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Buku.fromJson(Map<String, dynamic> json) => Buku(
    idBuku: json["id_buku"],
    judul: json["judul"],
    deskripsi: json["deskripsi"],
    penulis: json["penulis"],
    penerbit: json["penerbit"],
    isbn: json["isbn"],
    tahunTerbit: json["tahun_terbit"],
    jumlahBuku: json["jumlah_buku"],
    jumlahHalaman: json["jumlah_halaman"],
    path: json["path"],
    thumbnail: json["thumbnail"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id_buku": idBuku,
    "judul": judul,
    "deskripsi": deskripsi,
    "penulis": penulis,
    "penerbit": penerbit,
    "isbn": isbn,
    "tahun_terbit": tahunTerbit,
    "jumlah_buku": jumlahBuku,
    "jumlah_halaman": jumlahHalaman,
    "path": path,
    "thumbnail": thumbnail,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
