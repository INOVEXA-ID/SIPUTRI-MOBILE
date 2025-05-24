import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/features/detail_buku/bloc/daftar_antrian_bloc.dart';

class DaftarTungguBukuScreen extends StatelessWidget {
  final List<Map<String, String>> users = [
    {
      'name': 'Khoriya Dwi Islami Kurniawan',
      'image': '', // Kosong artinya pakai inisial
    },
    {
      'name': 'Kristopher Yohannes Immanuel Tambunan',
      'image': 'https://i.pravatar.cc/300', // Contoh URL gambar
    },
  ];

  DaftarTungguBukuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Tunggu Buku'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: BlocBuilder<DaftarAntrianBloc, DaftarAntrianState>(
        builder: (context, state) {
          if (state is DaftarAntrianLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is DaftarAntrianFailed) {
            return Center(child: Text(state.message));
          } else if (state is DaftarAntrianLoaded) {
            final data = state.daftarAntrianModel.daftarAntrean;
            if (data.isNotEmpty) {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final user = data[index];
                  return ListTile(
                    leading:
                        user.user.foto != null
                            ? CircleAvatar(
                              backgroundImage: NetworkImage(user.user.foto!),
                              radius: 25,
                            )
                            : CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.grey.shade400,
                              child: Text(
                                user.user.nama[0].toUpperCase(),
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.user.nama,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Newbie',
                            style: TextStyle(
                              color: Colors.green.shade700,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text("Belum ada antrian"));
            }
          } else {
            return Text("Terjadi Kesalahan");
          }
        },
      ),
    );
  }
}
