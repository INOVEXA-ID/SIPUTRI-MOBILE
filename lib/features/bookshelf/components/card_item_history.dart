import 'package:flutter/material.dart';
import 'package:siputri_mobile/features/bookshelf/models/peminjaman_model.dart';
import 'package:siputri_mobile/core/constants/api_constants.dart';
import 'package:intl/intl.dart';

// Util untuk membangun full url thumbnail
String? getFullImageUrl2(String? path) {
  if (path == null || path.isEmpty) return null;
  if (path.startsWith('http')) return path;
  final base = ApiConstants.baseUrlImage;
  if (base == null) return null;
  if (path.startsWith('/')) {
    return '$base$path';
  } else {
    return '$base/$path';
  }
}

class CardItemHistory extends StatelessWidget {
  final PeminjamanModel peminjaman;
  const CardItemHistory({super.key, required this.peminjaman});

  @override
  Widget build(BuildContext context) {
    final buku = peminjaman.buku;
    final thumbnailUrl = getFullImageUrl2(buku.thumbnail);
    debugPrint("URL gambar : $thumbnailUrl");

    // Format tanggal
    String formatTanggal(String? tanggal) {
      if (tanggal == null) return "-";
      try {
        return DateFormat(
          'd MMMM yyyy',
          'id_ID',
        ).format(DateTime.parse(tanggal));
      } catch (e) {
        return tanggal;
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child:
                        thumbnailUrl != null
                            ? Image.network(
                              thumbnailUrl,
                              fit: BoxFit.cover,
                              height: 140,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 140,
                                  color: Colors.grey.shade300,
                                  child: const Icon(
                                    Icons.broken_image,
                                    size: 40,
                                  ),
                                );
                              },
                            )
                            : Image.asset(
                              'assets/images/4.jpeg',
                              fit: BoxFit.cover,
                              height: 140,
                              width: double.infinity,
                            ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        buku.judul ?? "-",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        buku.penulis ?? "-",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          for (int i = 0; i < 5; i++)
                            const Icon(
                              Icons.star,
                              color: Colors.grey,
                              size: 15,
                            ),
                          const SizedBox(width: 5),
                          Text(
                            "0.0",
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        buku.penerbit ?? "-",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            const Divider(thickness: 2, color: Colors.white),
            const SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Material(
                      borderOnForeground: true,
                      child: InkWell(
                        onTap: () {
                          debugPrint("Pinjam ulang ${buku.judul}");
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.greenAccent.shade700,
                              width: 1,
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 7,
                            ),
                            child: Center(
                              child: Text(
                                "Pinjam",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      formatTanggal(peminjaman.tanggalPeminjaman),
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Material(
                      borderOnForeground: true,
                      child: InkWell(
                        onTap: () {
                          debugPrint("Kembali ${buku.judul}");
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey, width: 1),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 7,
                            ),
                            child: Center(
                              child: Text(
                                "Kembali",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      formatTanggal(peminjaman.tanggalPengembalian),
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
