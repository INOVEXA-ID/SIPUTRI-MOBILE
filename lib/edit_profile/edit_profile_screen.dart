import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:siputri_mobile/core/constants/api_constants.dart';
import 'package:siputri_mobile/core/helper/token_storage.dart';
import 'package:siputri_mobile/core/helper/user_model.dart';
import 'package:siputri_mobile/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:siputri_mobile/edit_profile/bloc/edit_profile_event.dart';
import 'package:siputri_mobile/edit_profile/bloc/edit_profile_state.dart';
import 'package:siputri_mobile/core/config/app_router.dart'; // Tambahkan ini

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _teleponController;
  late final TextEditingController _alamatController;

  String? _jenisKelamin;
  File? _imageFile;
  String? _networkImageUrl;

  @override
  void initState() {
    super.initState();
    final user = TokenStorage().user;
    _nameController = TextEditingController(text: user?.nama ?? '');
    _teleponController = TextEditingController(text: user?.telepon ?? '');
    _alamatController = TextEditingController(text: user?.alamat ?? '');
    _jenisKelamin = user?.jenisKelamin;
    _networkImageUrl = user?.foto;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _teleponController.dispose();
    _alamatController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _networkImageUrl = null; // pakai gambar baru
      });
    }
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Pilih dari Galeri'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Ambil dari Kamera'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
    );
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      context.read<EditProfileBloc>().add(
        EditProfileSubmitted(
          nama: _nameController.text,
          telepon: _teleponController.text,
          alamat: _alamatController.text,
          jenisKelamin: _jenisKelamin ?? '',
          foto: _imageFile,
        ),
      );
    }
  }

  // Helper untuk memastikan url gambar network benar (http/https)
  String? _fullImageUrl(String? url) {
    if (url == null || url.isEmpty) return null;
    if (url.startsWith('http')) return url;
    // pastikan tidak ada double slash
    if (ApiConstants.baseUrlImage == null) return null;
    final base = ApiConstants.baseUrlImage!;
    if (url.startsWith('/')) {
      return '$base$url';
    } else {
      return '$base/$url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profil'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocConsumer<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          if (state is EditProfileSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profil berhasil diperbarui')),
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRouter.navigationBarPage,
              (route) => false,
            );
          } else if (state is EditProfileFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Gagal update profil: ${state.message}')),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  // Gambar Profil
                  Center(
                    child: GestureDetector(
                      onTap: _showImagePickerOptions,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                _imageFile != null
                                    ? FileImage(_imageFile!)
                                    : (_networkImageUrl != null &&
                                        _networkImageUrl!.isNotEmpty)
                                    ? NetworkImage(
                                      _fullImageUrl(_networkImageUrl!)!,
                                    )
                                    : const AssetImage('assets/images/4.jpeg')
                                        as ImageProvider,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 4,
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.camera_alt,
                                size: 20,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Field Nama
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Nama',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    validator:
                        (value) =>
                            value!.isEmpty ? 'Nama tidak boleh kosong' : null,
                  ),
                  const SizedBox(height: 16),
                  // Field Email
                  const SizedBox(height: 16),
                  // Field Telepon
                  TextFormField(
                    controller: _teleponController,
                    decoration: InputDecoration(
                      labelText: 'Nomor Telepon',
                      prefixIcon: const Icon(Icons.phone),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    keyboardType: TextInputType.phone,
                    validator:
                        (value) =>
                            value!.isEmpty
                                ? 'Nomor telepon tidak boleh kosong'
                                : null,
                  ),
                  const SizedBox(height: 16),
                  // Field Alamat
                  TextFormField(
                    controller: _alamatController,
                    decoration: InputDecoration(
                      labelText: 'Alamat',
                      prefixIcon: const Icon(Icons.location_on),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    validator:
                        (value) =>
                            value!.isEmpty ? 'Alamat tidak boleh kosong' : null,
                  ),
                  const SizedBox(height: 16),
                  // Field Jenis Kelamin
                  DropdownButtonFormField<String>(
                    value: _jenisKelamin,
                    decoration: InputDecoration(
                      labelText: 'Jenis Kelamin',
                      prefixIcon: const Icon(Icons.wc),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                    ),
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
                        _jenisKelamin = value;
                      });
                    },
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? 'Jenis kelamin tidak boleh kosong'
                                : null,
                  ),
                  const SizedBox(height: 32),
                  // Tombol Simpan
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: state is EditProfileLoading ? null : _onSave,
                      icon:
                          state is EditProfileLoading
                              ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                              : const Icon(Icons.save, color: Colors.white),
                      label: Text(
                        state is EditProfileLoading
                            ? 'Menyimpan...'
                            : 'Simpan Perubahan',
                        style: const TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[600],
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                  // Debug token (optional, hapus di production)
                  // TextFormField(initialValue: TokenStorage().token),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
