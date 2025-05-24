import 'dart:convert';

DetailBukuModel detailBukuModelFromJson(String str) =>
    DetailBukuModel.fromJson(json.decode(str));

String detailBukuModelToJson(DetailBukuModel data) =>
    json.encode(data.toJson());

class DetailBukuModel {
  String message;
  Data data;

  DetailBukuModel({required this.message, required this.data});

  factory DetailBukuModel.fromJson(Map<String, dynamic> json) =>
      DetailBukuModel(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"message": message, "data": data.toJson()};
}

class Data {
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
  String ulasanAvgRating;
  bool favorit;
  bool statusDipinjam;
  bool statusSelesai;
  List<Ulasan> ulasan;
  Peminjaman? peminjaman;

  Data({
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
    required this.ulasanAvgRating,
    required this.favorit,
    required this.statusDipinjam,
    required this.statusSelesai,
    required this.ulasan,
    required this.peminjaman,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
    ulasanAvgRating: json["ulasan_avg_rating"],
    favorit: json["favorit"],
    statusDipinjam: json["status_dipinjam"],
    statusSelesai: json["status_selesai"],
    ulasan: List<Ulasan>.from(json["ulasan"].map((x) => Ulasan.fromJson(x))),
    peminjaman:
        json["peminjaman"] == null
            ? null
            : Peminjaman.fromJson(json["peminjaman"]),
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
    "ulasan_avg_rating": ulasanAvgRating,
    "favorit": favorit,
    "status_dipinjam": statusDipinjam,
    "status_selesai": statusSelesai,
    "ulasan": List<dynamic>.from(ulasan.map((x) => x.toJson())),
    "peminjaman": peminjaman?.toJson(),
  };
}

class Peminjaman {
  int idPeminjaman;
  DateTime tanggalPeminjaman;
  DateTime tanggalPengembalian;
  String status;
  int antreanKe;
  int idBuku;
  int idUser;
  DateTime createdAt;
  DateTime updatedAt;

  Peminjaman({
    required this.idPeminjaman,
    required this.tanggalPeminjaman,
    required this.tanggalPengembalian,
    required this.status,
    required this.antreanKe,
    required this.idBuku,
    required this.idUser,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Peminjaman.fromJson(Map<String, dynamic> json) => Peminjaman(
    idPeminjaman: json["id_peminjaman"],
    tanggalPeminjaman: DateTime.parse(json["tanggal_peminjaman"]),
    tanggalPengembalian: DateTime.parse(json["tanggal_pengembalian"]),
    status: json["status"],
    antreanKe: json["antrean_ke"],
    idBuku: json["id_buku"],
    idUser: json["id_user"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
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
  };
}

class Ulasan {
  int idUlasan;
  String ulasan;
  String rating;
  int idBuku;
  int idUser;
  DateTime createdAt;
  DateTime updatedAt;

  Ulasan({
    required this.idUlasan,
    required this.ulasan,
    required this.rating,
    required this.idBuku,
    required this.idUser,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Ulasan.fromJson(Map<String, dynamic> json) => Ulasan(
    idUlasan: json["id_ulasan"],
    ulasan: json["ulasan"],
    rating: json["rating"],
    idBuku: json["id_buku"],
    idUser: json["id_user"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id_ulasan": idUlasan,
    "ulasan": ulasan,
    "rating": rating,
    "id_buku": idBuku,
    "id_user": idUser,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
