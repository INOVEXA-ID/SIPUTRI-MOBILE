class PeminjamanModel {
  final int idPeminjaman;
  final String tanggalPeminjaman;
  final String tanggalPengembalian;
  final String status;
  final int antreanKe;
  final int idBuku;
  final int idUser;
  final BukuModel buku;

  PeminjamanModel({
    required this.idPeminjaman,
    required this.tanggalPeminjaman,
    required this.tanggalPengembalian,
    required this.status,
    required this.antreanKe,
    required this.idBuku,
    required this.idUser,
    required this.buku,
  });

  factory PeminjamanModel.fromJson(Map<String, dynamic> json) {
    return PeminjamanModel(
      idPeminjaman: json['id_peminjaman'],
      tanggalPeminjaman: json['tanggal_peminjaman'],
      tanggalPengembalian: json['tanggal_pengembalian'],
      status: json['status'],
      antreanKe: json['antrean_ke'],
      idBuku: json['id_buku'],
      idUser: json['id_user'],
      buku: BukuModel.fromJson(json['buku']),
    );
  }
}

class BukuModel {
  final int idBuku;
  final String judul;
  final String penulis;
  final String penerbit;
  final String thumbnail;

  BukuModel({
    required this.idBuku,
    required this.judul,
    required this.penulis,
    required this.penerbit,
    required this.thumbnail,
  });

  factory BukuModel.fromJson(Map<String, dynamic> json) {
    return BukuModel(
      idBuku: json['id_buku'],
      judul: json['judul'],
      penulis: json['penulis'],
      penerbit: json['penerbit'],
      thumbnail: json['thumbnail'],
    );
  }
}
