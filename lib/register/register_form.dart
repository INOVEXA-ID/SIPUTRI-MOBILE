import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'register_bloc.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Logo atau Ilustrasi Register
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.blue.shade100,
                    child: Icon(
                      Icons.person_add_alt_1_rounded,
                      size: 48,
                      color: Colors.blue[600],
                    ),
                  ),
                ),
                const Text(
                  "Buat Akun Baru",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Silakan isi data di bawah untuk mendaftar.",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 24),

                // --- FORM FIELDS ---
                _buildField(
                  label: 'NIM',
                  icon: Icons.portrait_rounded,
                  keyboardType: TextInputType.text,
                  onChanged:
                      (value) =>
                          context.read<RegisterBloc>().add(NimChanged(value)),
                  validator:
                      (value) =>
                          value!.isEmpty ? 'NIM tidak boleh kosong' : null,
                ),
                const SizedBox(height: 14),
                _buildField(
                  label: 'Nama',
                  icon: Icons.person,
                  keyboardType: TextInputType.text,
                  onChanged:
                      (value) =>
                          context.read<RegisterBloc>().add(NamaChanged(value)),
                  validator:
                      (value) =>
                          value!.isEmpty ? 'Nama tidak boleh kosong' : null,
                ),
                const SizedBox(height: 14),
                DropdownButtonFormField<String>(
                  decoration: _inputDecoration(
                    label: 'Jenis Kelamin',
                    icon: Icons.wc,
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Laki-laki',
                      child: Text('Laki-laki'),
                    ),
                    DropdownMenuItem(
                      value: 'Perempuan',
                      child: Text('Perempuan'),
                    ),
                  ],
                  onChanged:
                      (value) => context.read<RegisterBloc>().add(
                        JenisKelaminChanged(value!),
                      ),
                  validator:
                      (value) =>
                          value == null
                              ? 'Jenis Kelamin tidak boleh kosong'
                              : null,
                ),
                const SizedBox(height: 14),
                _buildField(
                  label: 'Nomor Telepon',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  onChanged:
                      (value) => context.read<RegisterBloc>().add(
                        TeleponChanged(value),
                      ),
                  validator:
                      (value) =>
                          value!.isEmpty
                              ? 'Nomor Telepon tidak boleh kosong'
                              : null,
                ),
                const SizedBox(height: 14),
                _buildField(
                  label: 'Alamat',
                  icon: Icons.location_on,
                  keyboardType: TextInputType.text,
                  onChanged:
                      (value) => context.read<RegisterBloc>().add(
                        AlamatChanged(value),
                      ),
                  validator:
                      (value) =>
                          value!.isEmpty ? 'Alamat tidak boleh kosong' : null,
                  maxLines: 2,
                ),
                const SizedBox(height: 14),
                _buildField(
                  label: 'Email',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  onChanged:
                      (value) =>
                          context.read<RegisterBloc>().add(EmailChanged(value)),
                  validator:
                      (value) =>
                          value!.isEmpty ? 'Email tidak boleh kosong' : null,
                ),
                const SizedBox(height: 14),
                _buildField(
                  label: 'Password',
                  icon: Icons.lock,
                  obscureText: true,
                  onChanged: (value) {
                    _password = value;
                    context.read<RegisterBloc>().add(PasswordChanged(value));
                  },
                  validator:
                      (value) =>
                          value!.isEmpty ? 'Password tidak boleh kosong' : null,
                ),
                const SizedBox(height: 14),
                _buildField(
                  label: 'Konfirmasi Password',
                  icon: Icons.lock_outline,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Konfirmasi Password wajib diisi';
                    if (value != _password) return 'Password tidak cocok';
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // --- BUTTON ---
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        state.isSubmitting
                            ? null
                            : () {
                              if (_formKey.currentState!.validate()) {
                                context.read<RegisterBloc>().add(
                                  RegisterSubmitted(),
                                );
                              }
                            },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      backgroundColor: Colors.blue[600],
                      elevation: 4,
                      shadowColor: Colors.blue.shade200,
                    ),
                    child:
                        state.isSubmitting
                            ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                            : const Text(
                              'Daftar',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                  ),
                ),

                // --- FEEDBACK ---
                const SizedBox(height: 20),
                if (state.isSuccess)
                  _animatedStatus("Registrasi Berhasil!", Colors.green),
                if (state.isFailure)
                  _animatedStatus("Registrasi Gagal!", Colors.red),

                // --- LINK TO LOGIN ---
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Sudah punya akun?",
                      style: TextStyle(fontSize: 14),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        "Masuk",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Field builder for DRYness
  Widget _buildField({
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
    bool obscureText = false,
    int maxLines = 1,
  }) {
    return TextFormField(
      decoration: _inputDecoration(label: label, icon: icon),
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
      maxLines: maxLines,
    );
  }

  // Input Decoration
  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.blue[600]),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
      ),
      filled: true,
      fillColor: Colors.blueGrey[50],
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    );
  }

  // Animated feedback
  Widget _animatedStatus(String text, Color color) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeIn,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            color == Colors.green ? Icons.check_circle : Icons.error,
            color: color,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
