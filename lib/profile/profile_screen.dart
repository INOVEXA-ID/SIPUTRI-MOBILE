import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/core/helper/token_storage.dart';
import 'package:siputri_mobile/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:siputri_mobile/edit_profile/edit_profile_screen.dart';
import 'package:siputri_mobile/edit_profile/repositories/profile_repository.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = TokenStorage().user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya', textAlign: TextAlign.center),
        centerTitle: true,
        backgroundColor: Colors.blue[600],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 24),

              // Gambar profil
              CircleAvatar(
                radius: 50,
                backgroundImage:
                    user!.foto != null
                        ? NetworkImage(user.foto!) as ImageProvider
                        : const AssetImage(
                          'assets/images/4.jpeg',
                        ), // Ganti dengan gambar profil asli
              ),

              const SizedBox(height: 16),

              // Nama dan Email
              Text(
                user.nama,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                user.email,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),

              const SizedBox(height: 16),

              // Tombol Edit Profil
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => BlocProvider(
                            create:
                                (context) => EditProfileBloc(
                                  ProfileRepository(Dio()),
                                ), // Tambahkan bloc yang diperlukan
                            child: EditProfileScreen(),
                          ),
                    ),
                  );
                },
                icon: const Icon(Icons.edit, color: Colors.white),
                label: const Text(
                  'Edit Profil',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Pengaturan Aplikasi
              const Divider(),
              _buildSettingItem(Icons.lock, 'Ganti Password'),
              _buildSettingItem(Icons.notifications, 'Notifikasi'),
              _buildSettingItem(Icons.language, 'Bahasa'),
              _buildSettingItem(Icons.info, 'Tentang Aplikasi'),
              _buildSettingItem(
                Icons.logout,
                'Keluar',
                isDestructive: true,
                onTap: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          title: const Text('Konfirmasi'),
                          content: const Text('Yakin ingin keluar?'),
                          actions: [
                            TextButton(
                              child: const Text('Batal'),
                              onPressed: () => Navigator.pop(context, false),
                            ),
                            TextButton(
                              child: const Text('Keluar'),
                              onPressed: () => Navigator.pop(context, true),
                            ),
                          ],
                        ),
                  );
                  if (confirm == true) {
                    // Hapus token
                    await TokenStorage().clearToken();
                    // Navigasi ke halaman login, ganti sesuai route kamu
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/login',
                      (r) => false,
                    );
                    // Atau pakai Navigator.of(context).pushReplacementNamed('/login');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget reusable untuk item pengaturan
  Widget _buildSettingItem(
    IconData icon,
    String title, {
    bool isDestructive = false,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: isDestructive ? Colors.red : Colors.black54),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.red : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}
