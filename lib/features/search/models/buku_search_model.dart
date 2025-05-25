import 'dart:convert';

BukuSearchModel bukuSearchModelFromJson(String str) =>
    BukuSearchModel.fromJson(json.decode(str));

String bukuSearchModelToJson(BukuSearchModel data) =>
    json.encode(data.toJson());

class BukuSearchModel {
  String message;
  List<Datum> data;

  BukuSearchModel({required this.message, required this.data});

  factory BukuSearchModel.fromJson(Map<String, dynamic> json) =>
      BukuSearchModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
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
  String thumbnailUrl;
  String rating;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
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
    required this.thumbnailUrl,
    required this.rating,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
    thumbnailUrl: json["thumbnail_url"],
    rating: json["rating"],
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
    "thumbnail_url": thumbnailUrl,
    "rating": rating,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
