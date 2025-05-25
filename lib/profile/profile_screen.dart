import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/core/constants/api_constants.dart';
import 'package:siputri_mobile/core/helper/image_helper.dart';
import 'package:siputri_mobile/core/helper/token_storage.dart';
import 'package:siputri_mobile/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:siputri_mobile/edit_profile/edit_profile_screen.dart';
import 'package:siputri_mobile/edit_profile/repositories/profile_repository.dart';
import 'package:siputri_mobile/features/bookshelf/export/index.dart';
import 'package:siputri_mobile/profile/bloc/profile_bloc.dart'; // pastikan path-nya benar

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _networkImageUrl;
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(LoadProfile());
  }

  // Helper untuk memastikan URL gambar lengkap
  String? getFullImageUrl(String? path) {
    if (path == null || path.isEmpty) return null;
    if (path.startsWith('http')) return path;
    final base = ApiConstants.baseURLFoto;
    if (base == null) return null;
    if (path.startsWith('/')) {
      return '$base$path';
    } else {
      return '$base/$path';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya', textAlign: TextAlign.center),
        centerTitle: true,
        backgroundColor: Colors.blue[600],
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          // Bisa loading indicator kalau data kosong
          if (state.nama.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  // Gambar profil
                  state.fotoUrl == null
                      ? CircleAvatar(
                        radius: 50,
                        backgroundColor: ColorConstants.primaryColor,
                        child: MyText(
                          title: state.nama[0],
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                      : CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          getFullFotoUrl(state.fotoUrl)!,
                        ),
                      ),
                  const SizedBox(height: 10),
                  // Nama dan Email
                  Text(
                    state.nama,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    state.email,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),

                  // Tombol Edit Profil
                  ElevatedButton.icon(
                    onPressed: () async {
                      final userBaru = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => BlocProvider(
                                create:
                                    (context) => EditProfileBloc(
                                      ProfileRepository(Dio()),
                                    ),
                                child: const EditProfileScreen(),
                              ),
                        ),
                      );
                      // Setelah update profile, trigger event
                      if (userBaru != null) {
                        context.read<ProfileBloc>().add(
                          ProfileUpdated(userBaru),
                        );
                      }
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
                  // _buildSettingItem(Icons.lock, 'Ganti Password'),
                  // _buildSettingItem(Icons.notifications, 'Notifikasi'),
                  // _buildSettingItem(Icons.language, 'Bahasa'),
                  // _buildSettingItem(Icons.info, 'Tentang Aplikasi'),
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
                                  onPressed:
                                      () => Navigator.pop(context, false),
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
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
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
