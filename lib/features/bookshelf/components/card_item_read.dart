import '../export/index.dart';
import 'package:siputri_mobile/features/bookshelf/models/peminjaman_model.dart';
import 'package:siputri_mobile/core/constants/api_constants.dart';
import 'package:intl/intl.dart';

// Fungsi util untuk menghasilkan full URL image
String? getFullImageUrl(String? path) {
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

class CardItemRead extends StatelessWidget {
  final PeminjamanModel peminjaman;
  const CardItemRead({super.key, required this.peminjaman});

  @override
  Widget build(BuildContext context) {
    final buku = peminjaman.buku;
    final thumbnailUrl = getFullImageUrl(buku.thumbnail);
    debugPrint("URL gambar : $thumbnailUrl");

    // Format tanggal
    String formatTanggal(String tanggal) {
      try {
        return DateFormat(
          'd MMMM yyyy',
          'id_ID',
        ).format(DateTime.parse(tanggal));
      } catch (e) {
        return tanggal;
      }
    }

    // Hitung sisa waktu
    String getSisaHari() {
      try {
        final akhir = DateTime.parse(peminjaman.tanggalPengembalian);
        final sekarang = DateTime.now();
        final selisih = akhir.difference(sekarang).inDays;
        if (selisih < 0) {
          return "(Lewat waktu)";
        } else if (selisih == 0) {
          return "(Hari ini)";
        }
        return "($selisih Hari lagi)";
      } catch (e) {
        return "";
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
                                  child: Icon(Icons.broken_image, size: 40),
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
                Gap(X: 12),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        title: buku.judul,
                        fontSize: 12,
                        maxLine: 2,
                        fontWeight: FontWeight.w600,
                      ),
                      MyText(
                        title: buku.penulis,
                        fontSize: 11,
                        maxLine: 2,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                      Gap(Y: 4),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.grey, size: 15),
                          Icon(Icons.star, color: Colors.grey, size: 15),
                          Icon(Icons.star, color: Colors.grey, size: 15),
                          Icon(Icons.star, color: Colors.grey, size: 15),
                          Icon(Icons.star, color: Colors.grey, size: 15),
                          Gap(X: 5),
                          MyText(
                            title: "0.0",
                            fontSize: 11,
                            maxLine: 2,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      Gap(Y: 4),
                      MyText(
                        title: buku.penerbit,
                        fontSize: 10,
                        maxLine: 5,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Gap(Y: 6),
            Divider(thickness: 2, color: Colors.white),
            Gap(Y: 3),
            MyText(
              title: formatTanggal(peminjaman.tanggalPeminjaman),
              fontSize: 10,
              maxLine: 5,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
            Row(
              children: [
                MyText(
                  title:
                      "Berlaku sampai ${formatTanggal(peminjaman.tanggalPengembalian)} 23:59",
                  fontSize: 10,
                  maxLine: 5,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
                Gap(X: 5),
                MyText(
                  title: getSisaHari(),
                  fontSize: 10,
                  maxLine: 5,
                  color: ColorConstants.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            Gap(Y: 3),
            Divider(thickness: 2, color: Colors.white),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  title:
                      peminjaman.status == "dipinjam"
                          ? "Belum di baca"
                          : peminjaman.status,
                  fontSize: 10,
                  maxLine: 5,
                  color: Colors.amber.shade800,
                  fontWeight: FontWeight.w600,
                ),
                Material(
                  borderOnForeground: true,
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      debugPrint("Baca ${buku.judul}");
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 7,
                        ),
                        child: Center(
                          child: MyText(
                            title: "Baca",
                            fontSize: 10,
                            maxLine: 5,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
