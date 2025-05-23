import 'package:flutter/material.dart';
import 'package:siputri_mobile/features/bookshelf/models/peminjaman_model.dart';
import 'package:siputri_mobile/core/constants/api_constants.dart';

class CardItemRead extends StatelessWidget {
  final PeminjamanModel peminjaman;

  const CardItemRead({Key? key, required this.peminjaman}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buku = peminjaman.buku;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            buku.thumbnail.startsWith('http')
                ? buku.thumbnail
                : '${ApiConstants.baseUrlImage}/${buku.thumbnail}',
            width: 50,
            height: 70,
            fit: BoxFit.cover,
            errorBuilder:
                (context, error, stackTrace) => Container(
                  width: 50,
                  height: 70,
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image),
                ),
          ),
        ),
        title: Text(
          buku.judul,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Penulis: ${buku.penulis}'),
            Text('Penerbit: ${buku.penerbit}'),
            Text('Pinjam: ${peminjaman.tanggalPeminjaman}'),
            Text('Kembali: ${peminjaman.tanggalPengembalian}'),
            Text('Status: ${peminjaman.status}'),
            if (peminjaman.antreanKe > 0)
              Text('Antrean ke-${peminjaman.antreanKe}'),
          ],
        ),
        trailing:
            peminjaman.status == "dipinjam"
                ? const Icon(Icons.book, color: Colors.green)
                : null,
        onTap: () {
          // Navigasi ke detail atau aksi lain
        },
      ),
    );
  }
}
