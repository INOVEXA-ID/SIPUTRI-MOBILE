import 'package:flutter/material.dart';
import 'package:siputri_mobile/edit_profile/edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                backgroundImage: AssetImage(
                  'lib/assets/foto_kristo.JPG',
                ), // Ganti dengan gambar profil asli
              ),

              const SizedBox(height: 16),

              // Nama dan Email
              const Text(
                'Kristopir',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Kristopir@example.com',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),

              const SizedBox(height: 16),

              // Tombol Edit Profil
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const EditProfileScreen(),
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
              _buildSettingItem(Icons.logout, 'Keluar', isDestructive: true),
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
      onTap: () {
        // Aksi saat item diklik
      },
    );
  }
}
