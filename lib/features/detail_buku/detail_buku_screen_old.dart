import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/features/detail_buku/bloc/ulasan_global_bloc.dart';
import 'package:siputri_mobile/features/home/models/buku_model.dart';
import 'package:siputri_mobile/core/helper/image_helper.dart'; // <--- helper getFullImageUrl

class BookDetailScreen extends StatefulWidget {
  final Datum book;

  const BookDetailScreen({super.key, required this.book});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  bool isBorrowed = false;
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final book = widget.book;
    final thumbnailUrl = getFullImageUrl(book.thumbnailUrl);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 100),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.shade200,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child:
                            thumbnailUrl != null
                                ? Image.network(
                                  thumbnailUrl,
                                  height: 260,
                                  width: 180,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stackTrace) => Container(
                                        height: 260,
                                        width: 180,
                                        color: Colors.grey[300],
                                        child: const Icon(
                                          Icons.broken_image,
                                          size: 60,
                                        ),
                                      ),
                                )
                                : Image.asset(
                                  'assets/images/4.jpeg',
                                  height: 260,
                                  width: 180,
                                  fit: BoxFit.cover,
                                ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          book.judul ?? '-',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          book.penulis ?? '-',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Rating dan ketersediaan
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: List.generate(
                                    5,
                                    (index) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  '4.5 Rating',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      (book.jumlahBuku ?? 0).toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(
                                      Icons.book,
                                      color: Colors.black87,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${book.jumlahBuku ?? 0} Buku Tersedia',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Tombol Pinjam Buku
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed:
                                isBorrowed
                                    ? null
                                    : () {
                                      // TODO: Trigger Bloc event untuk pinjam buku di sini jika perlu
                                      setState(() {
                                        isBorrowed = true;
                                      });
                                    },
                            icon: Icon(
                              isBorrowed
                                  ? Icons.check_circle
                                  : Icons.amp_stories_outlined,
                              color: Colors.white,
                            ),
                            label: Text(
                              isBorrowed ? 'Dipinjam' : 'Pinjam Buku',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              backgroundColor:
                                  isBorrowed ? Colors.green : Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Statistik cepat
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildStatItem(
                              Icons.chat_bubble_outline,
                              '0',
                              Colors.orange,
                            ),
                            _verticalDivider(),
                            _buildStatItem(Icons.description, '0', Colors.blue),
                            _verticalDivider(),
                            _buildStatItem(Icons.copy, '1', Colors.black87),
                            _verticalDivider(),
                            Row(
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.teal,
                                  size: 18,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${book.jumlahBuku ?? 0} Tersedia',
                                  style: const TextStyle(color: Colors.teal),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Deskripsi expandable
                        GestureDetector(
                          onTap:
                              () => setState(() => _isExpanded = !_isExpanded),
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Deskripsi',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Klik untuk membaca lebih lanjut',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  AnimatedCrossFade(
                                    duration: const Duration(milliseconds: 300),
                                    crossFadeState:
                                        _isExpanded
                                            ? CrossFadeState.showSecond
                                            : CrossFadeState.showFirst,
                                    firstChild: Text(
                                      '${(book.deskripsi ?? '-').split('.').first}.',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    secondChild: Text(
                                      book.deskripsi ?? '-',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Info Book
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _buildInfoColumn(
                                title: 'Penulis',
                                icon: Icons.person,
                                content: book.penulis ?? '-',
                              ),
                              _verticalDivider(),
                              _buildInfoColumn(
                                title: 'Penerbit',
                                icon: Icons.business,
                                content: book.penerbit ?? '-',
                              ),
                              _verticalDivider(),
                              _buildInfoColumn(
                                title: 'ISBN',
                                icon: Icons.qr_code,
                                content: book.isbn ?? '-',
                              ),
                              _verticalDivider(),
                              _buildInfoColumn(
                                title: 'Tahun',
                                icon: Icons.calendar_today,
                                content: book.tahunTerbit ?? '-',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Ulasan
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Apa yang orang lain katakan 11111',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              BlocBuilder<UlasanGlobalBloc, UlasanGlobalState>(
                                builder: (context, state) {
                                  if (state is UlasanGlobalLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (state is UlasanGlobalLoaded) {
                                    final ulasanG =
                                        state.ulasanGlobalModel.ulasan;
                                    return ListView.builder(
                                      itemCount: ulasanG.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return _buildUlasanSection(
                                          image: ulasanG[index].user.foto,
                                          name: ulasanG[index].user.nama,
                                          review: ulasanG[index].ulasan,
                                          rating: ulasanG[index].rating,
                                        );
                                      },
                                    );
                                  } else if (state is UlasanGlobalFailed) {
                                    return Center(child: Text(state.message));
                                  }
                                  return Text("terjadi kesalahan");
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Floating Action Buttons (Back, Share, Favorite)
            Positioned(
              top: 20,
              left: 16,
              child: FloatingActionButton(
                mini: true,
                backgroundColor: Colors.black.withOpacity(0.6),
                heroTag: 'back',
                onPressed: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
            Positioned(
              top: 20,
              right: 70,
              child: FloatingActionButton(
                mini: true,
                backgroundColor: Colors.black.withOpacity(0.6),
                heroTag: 'share',
                onPressed: () {
                  // TODO: Implement share
                },
                child: const Icon(Icons.share, color: Colors.white),
              ),
            ),
            Positioned(
              top: 20,
              right: 16,
              child: FloatingActionButton(
                mini: true,
                backgroundColor: Colors.black.withOpacity(0.6),
                heroTag: 'favorite',
                onPressed: () {
                  // TODO: Implement favorite
                },
                child: const Icon(Icons.favorite_border, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper widgets
Widget _verticalDivider() {
  return Container(
    height: 30,
    width: 1,
    color: Colors.grey.shade300,
    margin: const EdgeInsets.symmetric(horizontal: 8),
  );
}

Widget _buildStatItem(IconData icon, String value, Color iconColor) {
  return Row(
    children: [
      Icon(icon, color: iconColor, size: 20),
      const SizedBox(width: 4),
      Text(value),
    ],
  );
}

Widget _buildInfoColumn({
  required String title,
  required IconData icon,
  required String content,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        Icon(icon, size: 20, color: Colors.black87),
        const SizedBox(height: 6),
        Text(
          content,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ],
    ),
  );
}

Widget _buildUlasanSection({
  required String? image,
  required String name,
  required String review,
  required String rating,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text("HOOOOTYYYYYy", style: const TextStyle(fontSize: 14)),
    ),
  );
}
