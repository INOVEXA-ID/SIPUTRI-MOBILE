import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/features/register/bloc/register_bloc.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nimController = TextEditingController();
  final _namaController = TextEditingController();
  final _noTelpController = TextEditingController();
  final _alamatController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();

  String? jenisKelamin;
  bool _passwordVisible = false;
  bool _passwordConfirmationVisible = false;

  @override
  void dispose() {
    _nimController.dispose();
    _namaController.dispose();
    _noTelpController.dispose();
    _alamatController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Registrasi berhasil! Silakan login."),
            ),
          );
          Navigator.pop(context);
        } else if (state is RegisterFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 430),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Logo/Title
                        Image.asset(
                          "assets/images/logo_fix.png",
                          width: 80,
                          height: 80,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Buat Akun SIPUTRI",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Lengkapi data berikut untuk mendaftar.",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 30),

                        // NIM
                        TextFormField(
                          controller: _nimController,
                          decoration: _inputDecoration(
                            label: 'NIM',
                            icon: Icons.portrait_rounded,
                            hint: 'Masukkan NIM (9 digit)',
                          ),
                          keyboardType: TextInputType.text,
                          maxLength: 9,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'NIM tidak boleh kosong';
                            }
                            if (value.length != 9) {
                              return 'NIM harus 9 karakter';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),

                        // Nama
                        TextFormField(
                          controller: _namaController,
                          decoration: _inputDecoration(
                            label: 'Nama Lengkap',
                            icon: Icons.person,
                            hint: 'Nama sesuai KTP',
                          ),
                          keyboardType: TextInputType.text,
                          validator:
                              (value) =>
                                  value!.isEmpty
                                      ? 'Nama tidak boleh kosong'
                                      : null,
                        ),
                        const SizedBox(height: 12),

                        // Jenis Kelamin
                        DropdownButtonFormField<String>(
                          decoration: _inputDecoration(
                            label: 'Jenis Kelamin',
                            icon: Icons.wc,
                            hint: 'Pilih salah satu',
                          ),
                          value: jenisKelamin,
                          items: const [
                            DropdownMenuItem(
                              value: 'laki laki',
                              child: Text('Laki-laki'),
                            ),
                            DropdownMenuItem(
                              value: 'perempuan',
                              child: Text('Perempuan'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              jenisKelamin = value;
                            });
                          },
                          validator:
                              (value) =>
                                  value == null
                                      ? 'Jenis Kelamin tidak boleh kosong'
                                      : null,
                        ),
                        const SizedBox(height: 12),

                        // Nomor Telepon
                        TextFormField(
                          controller: _noTelpController,
                          decoration: _inputDecoration(
                            label: 'Nomor Telepon',
                            icon: Icons.phone,
                            hint: '08xxxxxxxxxx',
                          ),
                          keyboardType: TextInputType.phone,
                          validator:
                              (value) =>
                                  value!.isEmpty
                                      ? 'Nomor Telepon tidak boleh kosong'
                                      : null,
                        ),
                        const SizedBox(height: 12),

                        // Alamat
                        TextFormField(
                          controller: _alamatController,
                          decoration: _inputDecoration(
                            label: 'Alamat',
                            icon: Icons.location_on,
                            hint: 'Alamat rumah sesuai KTP',
                          ),
                          keyboardType: TextInputType.text,
                          validator:
                              (value) =>
                                  value!.isEmpty
                                      ? 'Alamat tidak boleh kosong'
                                      : null,
                        ),
                        const SizedBox(height: 12),

                        // Email
                        TextFormField(
                          controller: _emailController,
                          decoration: _inputDecoration(
                            label: 'Email',
                            icon: Icons.email,
                            hint: 'contoh@email.com',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email tidak boleh kosong';
                            }
                            // Cek validasi format email
                            final emailRegex = RegExp(
                              r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
                            );
                            if (!emailRegex.hasMatch(value)) {
                              return 'Format email tidak valid';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),

                        // Password
                        TextFormField(
                          controller: _passwordController,
                          obscureText: !_passwordVisible,
                          decoration: _inputDecoration(
                            label: 'Password',
                            icon: Icons.lock,
                            hint: 'Minimal 8 karakter',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password tidak boleh kosong';
                            }
                            if (value.length < 6) {
                              return 'Password minimal 8 karakter';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),

                        // Konfirmasi Password
                        TextFormField(
                          controller: _passwordConfirmationController,
                          obscureText: !_passwordConfirmationVisible,
                          decoration: _inputDecoration(
                            label: 'Konfirmasi Password',
                            icon: Icons.lock_outline,
                            hint: 'Ulangi password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordConfirmationVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordConfirmationVisible =
                                      !_passwordConfirmationVisible;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Konfirmasi Password wajib diisi';
                            }
                            if (value != _passwordController.text) {
                              return 'Password tidak cocok';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 28),

                        BlocBuilder<RegisterBloc, RegisterState>(
                          builder: (context, state) {
                            return SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed:
                                    (state is RegisterLoading)
                                        ? null
                                        : () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            context.read<RegisterBloc>().add(
                                              RegisterSubmitted(
                                                nim: _nimController.text,
                                                nama: _namaController.text,
                                                jenisKelamin: jenisKelamin!,
                                                telepon: _noTelpController.text,
                                                alamat: _alamatController.text,
                                                email: _emailController.text,
                                                password:
                                                    _passwordController.text,
                                                passwordConfirmation:
                                                    _passwordConfirmationController
                                                        .text,
                                              ),
                                            );
                                          }
                                        },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[700],
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                  elevation: 3,
                                ),
                                child:
                                    (state is RegisterLoading)
                                        ? const SizedBox(
                                          width: 25,
                                          height: 25,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                        : const Text('Daftar'),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Sudah punya akun? Login di sini',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
    String? hint,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.blue[700]),
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(13)),
      filled: true,
      fillColor: Colors.grey[100],
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
    );
  }
}
