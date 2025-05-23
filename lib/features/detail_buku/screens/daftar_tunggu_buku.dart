import 'package:flutter/material.dart';

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
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            leading:
                user['image']!.isNotEmpty
                    ? CircleAvatar(
                      backgroundImage: NetworkImage(user['image']!),
                      radius: 25,
                    )
                    : CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey.shade400,
                      child: Text(
                        user['name']![0],
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                    ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user['name']!,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
                Container(
                  margin: EdgeInsets.only(top: 4),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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
      ),
    );
  }
}
