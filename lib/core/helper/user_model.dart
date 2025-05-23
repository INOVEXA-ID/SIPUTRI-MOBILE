class User {
  final int idUser;
  final String? nim;
  final String nama;
  final String jenisKelamin;
  final String telepon;
  final String alamat;
  final String? foto;
  final String? email;

  User({
    required this.idUser,
    this.nim,
    required this.nama,
    required this.jenisKelamin,
    required this.telepon,
    required this.alamat,
    this.foto,
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      idUser: json['id_user'],
      nim: json['nim'], // Bisa saja null
      nama: json['nama'],
      jenisKelamin: json['jenis_kelamin'],
      telepon: json['telepon'],
      alamat: json['alamat'],
      foto: json['foto_url'] ?? json['foto'], // Ambil dari foto_url jika ada
      email: json['email'], // Bisa saja null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_user': idUser,
      'nim': nim,
      'nama': nama,
      'jenis_kelamin': jenisKelamin,
      'telepon': telepon,
      'alamat': alamat,
      'foto': foto,
      'email': email,
    };
  }
}
