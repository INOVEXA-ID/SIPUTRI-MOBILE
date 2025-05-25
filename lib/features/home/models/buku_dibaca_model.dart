// To parse this JSON data, do
//
//     final bukuDibacaModel = bukuDibacaModelFromJson(jsonString);

import 'dart:convert';

BukuDibacaModel bukuDibacaModelFromJson(String str) =>
    BukuDibacaModel.fromJson(json.decode(str));

String bukuDibacaModelToJson(BukuDibacaModel data) =>
    json.encode(data.toJson());

class BukuDibacaModel {
  String message;
  Data? data;

  BukuDibacaModel({required this.message, required this.data});

  factory BukuDibacaModel.fromJson(Map<String, dynamic> json) =>
      BukuDibacaModel(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"message": message, "data": data?.toJson()};
}

class Data {
  int idPeminjaman;
  DateTime tanggalPeminjaman;
  DateTime tanggalPengembalian;
  String status;
  int antreanKe;
  int idBuku;
  int idUser;
  DateTime createdAt;
  DateTime updatedAt;
  Buku buku;

  Data({
    required this.idPeminjaman,
    required this.tanggalPeminjaman,
    required this.tanggalPengembalian,
    required this.status,
    required this.antreanKe,
    required this.idBuku,
    required this.idUser,
    required this.createdAt,
    required this.updatedAt,
    required this.buku,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    idPeminjaman: json["id_peminjaman"],
    tanggalPeminjaman: DateTime.parse(json["tanggal_peminjaman"]),
    tanggalPengembalian: DateTime.parse(json["tanggal_pengembalian"]),
    status: json["status"],
    antreanKe: json["antrean_ke"],
    idBuku: json["id_buku"],
    idUser: json["id_user"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    buku: Buku.fromJson(json["buku"]),
  );

  Map<String, dynamic> toJson() => {
    "id_peminjaman": idPeminjaman,
    "tanggal_peminjaman": tanggalPeminjaman.toIso8601String(),
    "tanggal_pengembalian": tanggalPengembalian.toIso8601String(),
    "status": status,
    "antrean_ke": antreanKe,
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
