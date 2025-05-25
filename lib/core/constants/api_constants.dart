import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String? baseUrl = dotenv.env['HOST'];
  static String? baseUrlImage = dotenv.env['URL'];
  static String? baseURLFoto = dotenv.env['URLIMAGE'];

  static String loginEndpoint = '/login';
  static String registerEndpoint = '/register';
  static String bukuEndpoint = '/cariBuku?search=';
  static String updateProfileEndpoint = '/user/updateProfile';
  static String favoritEndpoint = '/favorit';
  static String detailBukuEndpoint = '/buku';
  static String ulasanKamuEndpoint = '/daftar-ulasan-by-user';
  static String updateUlasanEndpoint = '/updateUlasan';
  static String postUlasanEndpoint = '/ulasan';
  static String pinjamBukuEndpoint = '/pinjam';
  static String kembalikanBukuEndpoint = '/kembalikan';
  static String antrianBukuEndpoint = '/antri';
  static String daftarAntrianEndpoint = '/daftarAntrean';
  static String batalAntrianEndpoint = '/batal-antrean';
  static String bukuDibacaEndpoint = '/statusBuku-byUser';
  static String sedangDibacaEndpoint = '/peminjaman/dipinjam';
  static String riwayatPeminjamanEndpoint = '/peminjaman/selesai';
  static String ulasanGlobalEndpoint = '/daftarUlasan';

  static String favoritTambahEndpoint = '/favorit/tambah';
  static String favoritHapusEndpoint = '/favorit/hapus';
}
