import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/core/config/app_router.dart';
import 'package:siputri_mobile/core/constants/api_constants.dart';
import 'package:siputri_mobile/core/constants/color_constants.dart';
import 'package:siputri_mobile/core/utils/date_format.dart';
import 'package:siputri_mobile/core/widgets/gap.dart';
import 'package:siputri_mobile/core/widgets/my_text.dart';
import 'package:siputri_mobile/features/detail_buku/bloc/antrian_buku_bloc.dart';
import 'package:siputri_mobile/features/detail_buku/bloc/batal_antrian_bloc.dart';
import 'package:siputri_mobile/features/detail_buku/bloc/daftar_antrian_bloc.dart';
import 'package:siputri_mobile/features/detail_buku/bloc/detail_buku_bloc.dart';
import 'package:siputri_mobile/features/detail_buku/bloc/kembalikan_buku_bloc.dart';
import 'package:siputri_mobile/features/detail_buku/bloc/pinjam_buku_bloc.dart';
import 'package:siputri_mobile/features/detail_buku/bloc/ulasan_kamu_bloc.dart';
import 'package:siputri_mobile/features/detail_buku/components/first_btn.dart';
import 'package:siputri_mobile/features/detail_buku/components/ulasan_global.dart';
import 'package:siputri_mobile/features/detail_buku/components/ulasan_kamu.dart';
import 'package:siputri_mobile/features/detail_buku/components/write_review.dart';
import 'package:siputri_mobile/features/detail_buku/models/detail_buku_model.dart';
import 'package:siputri_mobile/features/pdf_render/index.dart';

class BookDetailScreen extends StatefulWidget {
  const BookDetailScreen({super.key});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  bool _isExpanded = false;

  void dialogPinjamBuku(BuildContext context, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Pinjam Buku'),
            content: Text('Apakah anda ingin meminjam buku?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context), // Batal
                child: Text('Tidak'),
              ),
              ElevatedButton(
                onPressed: onConfirm,
                child: Text(
                  'Ya',
                  style: TextStyle(color: ColorConstants.primaryColor),
                ),
              ),
            ],
          ),
    );
  }

  void showReturnBookDialog(BuildContext context, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Konfirmasi'),
            content: Text('Apakah buku mau dikembalikan sekarang?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context), // Batal
                child: Text('Tidak'),
              ),
              ElevatedButton(onPressed: onConfirm, child: Text('Ya')),
            ],
          ),
    );
  }

  void dialogDaftarTunggu(BuildContext context, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Join Waiting List'),
            content: Text('Apakah ingin mengantri buku ini?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context), // Batal
                child: Text('Tidak'),
              ),
              ElevatedButton(onPressed: onConfirm, child: Text('Ya')),
            ],
          ),
    );
  }

  void dialogBatalDaftarTunggu(BuildContext context, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Warning!'),
            content: Text('Apakah anda ingin membatalkan daftar tunggu ?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context), // Batal
                child: Text('Tidak'),
              ),
              ElevatedButton(onPressed: onConfirm, child: Text('Ya')),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<DetailBukuBloc, DetailBukuState>(
        builder: (context, state) {
          if (state is DetailBukuLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DetailBukuFailed) {
            return Center(child: Text(state.message));
          } else if (state is DetailBukuLoaded) {
            final book = state.detailBukuModel.data;
            return SafeArea(
              child: Stack(
                children: [
                  RefreshIndicator(
                    onRefresh: () {
                      context.read<DetailBukuBloc>().add(
                        GetDetailBuku(id: book.idBuku.toString()),
                      );
                      context.read<UlasanKamuBloc>().add(
                        GetUlasanKamu(id: book.idBuku.toString()),
                      );
                      return Future.delayed(const Duration(seconds: 1));
                    },
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(top: 100),
                      child: Column(
                        children: [
                          Center(
                            child: Image.network(
                              "${ApiConstants.baseUrlImage}/${book.thumbnail}",
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
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  book.judul,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  book.penulis,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // Rating dan ketersediaan
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: List.generate(5, (index) {
                                            return const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: 20,
                                            );
                                          }),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "${book.ulasanAvgRating} Rating",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "1",
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
                                          '${book.jumlahBuku} Buku Tersedia',
                                          style: TextStyle(
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
                                if ((!book.statusDipinjam &&
                                        book.jumlahBuku > 0) ||
                                    (book.statusDipinjam &&
                                        book.jumlahBuku == 0))
                                  firstBtn(book, context),

                                // Tombol Daftar Tunggu
                                if (!book.statusDipinjam &&
                                    book.jumlahBuku == 0)
                                  secondBtn(context, book),
                                if ((!book.statusDipinjam &&
                                        book.jumlahBuku == 0 &&
                                        book.statusDipinjam) ||
                                    (book.statusDipinjam &&
                                        book.jumlahBuku == 0))
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Gap(Y: 10),
                                      MyText(
                                        title: "Peminjaman Anda",
                                        fontSize: 13,
                                      ),
                                      Gap(Y: 4),
                                      MyText(
                                        title:
                                            book
                                                .peminjaman!
                                                .tanggalPeminjaman
                                                .dateReadable,
                                      ),
                                      Row(
                                        children: [
                                          MyText(
                                            title:
                                                "Berlaku sampai ${book.peminjaman?.tanggalPengembalian.dateReadable}",
                                            fontSize: 11,
                                          ),
                                          Gap(X: 7),
                                          MyText(
                                            title:
                                                book.peminjaman!.durasiTersisa
                                                    .toString(),
                                            fontSize: 11,
                                            color: Colors.lightBlue,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                const SizedBox(height: 24),
                                // Statistik cepat
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildStatItem(
                                      Icons.chat_bubble_outline,
                                      '0',
                                      Colors.orange,
                                    ),
                                    _verticalDivider(),
                                    _buildStatItem(
                                      Icons.description,
                                      '0',
                                      Colors.blue,
                                    ),
                                    _verticalDivider(),
                                    _buildStatItem(
                                      Icons.copy,
                                      '1',
                                      Colors.black87,
                                    ),
                                    _verticalDivider(),
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.check_circle,
                                          color: Colors.teal,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          '1 Tersedia',
                                          style: TextStyle(color: Colors.teal),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),

                                // Deskripsi expandable
                                GestureDetector(
                                  onTap:
                                      () => setState(
                                        () => _isExpanded = !_isExpanded,
                                      ),
                                  child: Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            duration: const Duration(
                                              milliseconds: 300,
                                            ),
                                            crossFadeState:
                                                _isExpanded
                                                    ? CrossFadeState.showSecond
                                                    : CrossFadeState.showFirst,
                                            firstChild: Text(
                                              '${(book.deskripsi).split('.').first}.',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                            secondChild: Text(
                                              book.deskripsi,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
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
                                        content: book.penulis,
                                      ),
                                      _verticalDivider(),
                                      _buildInfoColumn(
                                        title: 'Penerbit',
                                        icon: Icons.business,
                                        content: book.penerbit,
                                      ),
                                      _verticalDivider(),
                                      _buildInfoColumn(
                                        title: 'ISBN',
                                        icon: Icons.qr_code,
                                        content: book.isbn,
                                      ),
                                      _verticalDivider(),
                                      _buildInfoColumn(
                                        title: 'Tahun',
                                        icon: Icons.calendar_today,
                                        content: book.tahunTerbit,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 24),
                                if (book.statusDipinjam == true ||
                                    book.statusSelesai == true)
                                  if (book.ulasan != null)
                                    UlasanKamuSection()
                                  else if (book.ulasan == null)
                                    WriteReviewWidget(
                                      idBuku: book.idBuku.toString(),
                                    ),
                                // Ulasan
                                const SizedBox(height: 24),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Apa yang orang lain katakan',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      // _buildUlasanSection(),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 5,
                                        ),
                                        child: UlasanGlobal(),
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
                  ),
                  Positioned(
                    top: 20,
                    left: 16,
                    child: FloatingActionButton(
                      mini: true,
                      backgroundColor: Colors.white,
                      heroTag: 'back',
                      onPressed: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),
                  // Positioned(
                  //   top: 20,
                  //   right: 70,
                  //   child: FloatingActionButton(
                  //     mini: true,
                  //     backgroundColor: Colors.white,
                  //     heroTag: 'share',
                  //     onPressed: () {
                  //       // Fungsi share di sini
                  //     },
                  //     child: const Icon(Icons.share, color: Colors.black),
                  //   ),
                  // ),
                  Positioned(
                    top: 20,
                    right: 16,
                    child: FloatingActionButton(
                      mini: true,
                      backgroundColor: Colors.white,
                      heroTag: 'favorite',
                      onPressed: () {
                        // Fungsi favorite di sini
                      },
                      child: Icon(
                        book.favorit ? Icons.favorite : Icons.favorite_border,
                        color: book.favorit ? Colors.red : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Row secondBtn(BuildContext context, Data book) {
    return Row(
      children: [
        BlocListener<AntrianBukuBloc, AntrianBukuState>(
          listener: (context, state) {
            if (state is AntrianBukuSuccess) {
              context.read<DetailBukuBloc>().add(
                GetDetailBuku(id: book.idBuku.toString()),
              );
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            } else if (state is AntrianBukuError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: BlocListener<BatalAntrianBloc, BatalAntrianState>(
            listener: (context, stateBatal) {
              if (stateBatal is BatalAntrianSuccess) {
                context.read<DetailBukuBloc>().add(
                  GetDetailBuku(id: book.idBuku.toString()),
                );
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(stateBatal.message)));
              } else if (stateBatal is BatalAntrianError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(stateBatal.message)));
              }
            },
            child: Expanded(
              flex: 1,
              child: BlocBuilder<AntrianBukuBloc, AntrianBukuState>(
                builder: (context, state) {
                  return BlocBuilder<BatalAntrianBloc, BatalAntrianState>(
                    builder: (context, stateBatal) {
                      return ElevatedButton.icon(
                        onPressed: () {
                          if (book.statusMengantri) {
                            dialogBatalDaftarTunggu(context, () {
                              context.read<BatalAntrianBloc>().add(
                                BatalAntrian(idBuku: book.idBuku.toString()),
                              );
                              Navigator.pop(context);
                            });
                          } else {
                            dialogDaftarTunggu(context, () {
                              context.read<AntrianBukuBloc>().add(
                                PostAntrianBukuEvent(
                                  idBuku: book.idBuku.toString(),
                                ),
                              );
                              Navigator.pop(context);
                            });
                          }
                        },
                        icon: Icon(
                          (book.statusMengantri)
                              ? Icons.library_add_check_rounded
                              : Icons.add_to_photos_rounded,
                          color: Colors.white,
                        ),
                        label: Text(
                          (book.statusMengantri)
                              ? "Dalam Daftar Tunggu"
                              : "Daftar Tunggu",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor:
                              (book.statusMengantri)
                                  ? Colors.green
                                  : ColorConstants.textC,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
        Gap(X: 12),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRouter.daftarTungguBukuPage,
              arguments: {'idBuku': book.idBuku.toString()},
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(13), // Atur sesuai ukuran ikon
            backgroundColor: ColorConstants.textC,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Icon(Icons.timer, color: Colors.white, size: 25),
        ),
      ],
    );
  }

  Widget firstBtn(Data book, BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: BlocListener<PinjamBukuBloc, PinjamBukuState>(
            listener: (context, state) {
              if (state is PinjamBukuLoaded) {
                context.read<DetailBukuBloc>().add(
                  GetDetailBuku(id: book.idBuku.toString()),
                );
              } else if (state is PinjamBukuFailed) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            child: BlocBuilder<PinjamBukuBloc, PinjamBukuState>(
              builder: (context, state) {
                return ElevatedButton.icon(
                  onPressed:
                      state is PinjamBukuLoading
                          ? null
                          : () {
                            if (!book.statusDipinjam && book.jumlahBuku > 0) {
                              dialogPinjamBuku(context, () {
                                context.read<PinjamBukuBloc>().add(
                                  PinjamBuku(idBuku: book.idBuku.toString()),
                                );
                                Navigator.pop(context);
                              });
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          PDFRenderScreen(urlBuku: book.path),
                                ),
                              );
                            }
                          },
                  icon: Icon(
                    book.statusDipinjam
                        ? Icons.menu_book_rounded
                        : Icons.amp_stories_outlined,
                    color: Colors.white,
                  ),
                  label: Text(
                    state is PinjamBukuLoading
                        ? "Loading..."
                        : book.statusDipinjam
                        ? 'Baca'
                        : 'Pinjam Buku',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor:
                        book.statusDipinjam ? Colors.green : Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        book.statusDipinjam ? Gap(X: 12) : Container(),
        book.statusDipinjam
            ? BlocListener<KembalikanBukuBloc, KembalikanBukuState>(
              listener: (context, state) {
                if (state is KembalikanBukuError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                } else if (state is KembalikanBukuSuccess) {
                  context.read<DetailBukuBloc>().add(
                    GetDetailBuku(id: book.idBuku.toString()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Buku berhasil dikembalikan")),
                  );
                }
              },
              child: InkWell(
                onTap: () {
                  showReturnBookDialog(context, () {
                    context.read<KembalikanBukuBloc>().add(
                      KembalikanBuku(idBuku: book.idBuku.toString()),
                    );
                    Navigator.pop(context);
                  });
                },
                child: SizedBox(
                  width: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.more_vert, size: 30),
                  ),
                ),
              ),
            )
            : Container(),
      ],
    );
  }
}

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

Widget _buildUlasanSection() {
  final List<String> ulasan = [];
  if (ulasan.isEmpty) {
    return const Text(
      'Belum ada ulasan',
      style: TextStyle(fontSize: 14, color: Colors.black54),
    );
  }
  return Column(
    children:
        ulasan
            .map(
              (review) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Text(review, style: const TextStyle(fontSize: 14)),
                ),
              ),
            )
            .toList(),
  );
}
