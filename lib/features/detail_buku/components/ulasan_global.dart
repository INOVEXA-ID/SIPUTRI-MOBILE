// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:siputri_mobile/features/bookshelf/export/index.dart';
import 'package:siputri_mobile/features/detail_buku/bloc/ulasan_global_bloc.dart';

class UlasanGlobal extends StatefulWidget {
  String idBuku;
  UlasanGlobal({super.key, required this.idBuku});

  @override
  State<UlasanGlobal> createState() => _UlasanGlobalState();
}

class _UlasanGlobalState extends State<UlasanGlobal> {
  @override
  void initState() {
    context.read<UlasanGlobalBloc>().add(
      GetUlasanGlobalEvent(bukuId: widget.idBuku),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UlasanGlobalBloc, UlasanGlobalState>(
      builder: (context, state) {
        log('STATE: $state');
        if (state is UlasanGlobalLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UlasanGlobalFailed) {
          return Center(child: Text(state.message));
        } else if (state is UlasanGlobalLoaded) {
          final ulasanG = state.ulasanGlobalModel.ulasan;
          if (ulasanG.isEmpty) {
            return Text("Belum Ada Ulasan");
          } else {
            return ListView.builder(
              itemCount: ulasanG.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final data = ulasanG[index];
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Atas: profil dan rating
                      Row(
                        children: [
                          data.user.foto == null
                              ? CircleAvatar(
                                radius: 22,
                                child: MyText(
                                  title: data.user.nama[0],
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                              )
                              : CircleAvatar(
                                radius: 22,
                                backgroundImage: NetworkImage(data.user.foto!),
                              ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.user.nama,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Container(
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
                                      fontSize: 12,
                                      color: Colors.green.shade800,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              RatingBarIndicator(
                                rating: double.parse(data.rating),
                                itemCount: 5,
                                itemSize: 16,
                                itemBuilder:
                                    (_, __) =>
                                        Icon(Icons.star, color: Colors.amber),
                              ),
                              SizedBox(height: 4),
                              Text(data.rating, style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Divider(),
                      Text(data.ulasan),
                    ],
                  ),
                );
              },
            );
          }
        } else {
          return Text("terjadi kesalahan");
        }
      },
    );
  }
}
