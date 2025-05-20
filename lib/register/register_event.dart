abstract class RegisterEvent {}

class NimChanged extends RegisterEvent {
  final String nim;
  NimChanged(this.nim);
}

class NamaChanged extends RegisterEvent {
  final String nama;
  NamaChanged(this.nama);
}

class JenisKelaminChanged extends RegisterEvent {
  final String jenisKelamin;
  JenisKelaminChanged(this.jenisKelamin);
}

class TeleponChanged extends RegisterEvent {
  final String telepon;
  TeleponChanged(this.telepon);
}

class AlamatChanged extends RegisterEvent {
  final String alamat;
  AlamatChanged(this.alamat);
}

class EmailChanged extends RegisterEvent {
  final String email;
  EmailChanged(this.email);
}

class PasswordChanged extends RegisterEvent {
  final String password;
  PasswordChanged(this.password);
}

class RegisterSubmitted extends RegisterEvent {}
