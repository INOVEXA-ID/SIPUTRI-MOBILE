class RegisterState {
  final String nim;
  final String nama;
  final String jenisKelamin;
  final String telepon;
  final String alamat;
  final String email;
  final String password;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  RegisterState({
    required this.nim,
    required this.nama,
    required this.jenisKelamin,
    required this.telepon,
    required this.alamat,
    required this.email,
    required this.password,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
  });

  factory RegisterState.initial() {
    return RegisterState(
      nim: '',
      nama: '',
      jenisKelamin: '',
      telepon: '',
      alamat: '',
      email: '',
      password: '',
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  RegisterState copyWith({
    String? nim,
    String? nama,
    String? jenisKelamin,
    String? telepon,
    String? alamat,
    String? email,
    String? password,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return RegisterState(
      nim: nim ?? this.nim,
      nama: nama ?? this.nama,
      jenisKelamin: jenisKelamin ?? this.jenisKelamin,
      telepon: telepon ?? this.telepon,
      alamat: alamat ?? this.alamat,
      email: email ?? this.email,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }
}
