class User {
  final int idUser;
  final String nim;
  final String nama;
  final String jenisKelamin;
  final String telepon;
  final String alamat;
  final String? foto;
  final String email;

  User({
    required this.idUser,
    required this.nim,
    required this.nama,
    required this.jenisKelamin,
    required this.telepon,
    required this.alamat,
    this.foto,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      idUser: json['id_user'],
      nim: json['nim'],
      nama: json['nama'],
      jenisKelamin: json['jenis_kelamin'],
      telepon: json['telepon'],
      alamat: json['alamat'],
      foto: json['foto'],
      email: json['email'],
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
