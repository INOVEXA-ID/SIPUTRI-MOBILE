import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:siputri_mobile/core/constants/api_constants.dart';
import 'package:siputri_mobile/features/detail_buku/bloc/ulasan_kamu_bloc.dart';

class UlasanKamuSection extends StatefulWidget {
  const UlasanKamuSection({super.key});

  @override
  State<UlasanKamuSection> createState() => _UlasanKamuSectionState();
}

class _UlasanKamuSectionState extends State<UlasanKamuSection> {
  bool isEditing = false;
  double rating = 0.0;
  final TextEditingController commentController = TextEditingController(
    text: '',
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UlasanKamuBloc, UlasanKamuState>(
      builder: (context, state) {
        if (state is UlasanKamuLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UlasanKamuFailed) {
          return Center(child: Text(state.message));
        } else if (state is UlasanKamuLoaded) {
          final ulasan = state.data.data;
          var data = ulasan == null ? 0 : 1;
          // rating = double.parse(ulasan!.rating);
          if (data == 0) {
            return Container();
          } else {
            commentController.text = ulasan!.ulasan;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ulasan kamu',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (!isEditing)
                      IconButton(
                        icon: Icon(Icons.edit, size: 20),
                        onPressed: () => setState(() => isEditing = true),
                      ),
                    if (isEditing)
                      IconButton(
                        icon: Icon(Icons.close, size: 20),
                        onPressed: () => setState(() => isEditing = false),
                      ),
                  ],
                ),
                const SizedBox(height: 12),

                // Kondisional antara tampilan ulasan dan form input
                isEditing
                    ? buildFormUlasan(
                      idUser: ulasan.idUser.toString(),
                      idBuku: ulasan.idBuku.toString(),
                    )
                    : buildUlasanPreview(
                      nama: ulasan.user.nama,
                      rating: double.parse(ulasan.rating),
                      img: ulasan.user.foto,
                    ),
              ],
            );
          }
        } else {
          return Text("Terjadi Kesalahan ulasan kamu");
        }
      },
    );
  }

  Widget buildUlasanPreview({
    required nama,
    required double rating,
    required img,
  }) {
    return GestureDetector(
      onTap: () => setState(() => isEditing = true),
      child: Container(
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
                CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage(
                    "${ApiConstants.baseUrlImage}/$img",
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(nama, style: TextStyle(fontWeight: FontWeight.bold)),
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
                      rating: rating,
                      itemCount: 5,
                      itemSize: 16,
                      itemBuilder:
                          (_, __) => Icon(Icons.star, color: Colors.amber),
                    ),
                    SizedBox(height: 4),
                    Text(rating.toString(), style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(),
            Text(commentController.text),
          ],
        ),
      ),
    );
  }

  Widget buildFormUlasan({required String idUser, required String idBuku}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RatingBar.builder(
            initialRating: rating,
            minRating: 0,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 30,
            itemBuilder: (_, __) => Icon(Icons.star, color: Colors.amber),
            onRatingUpdate: (value) {
              setState(() => rating = value);
              log(rating.toString());
            },
          ),
          const SizedBox(height: 12),
          TextField(
            controller: commentController,
            maxLength: 244,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Apa pendapat kamu tentang buku ini?',
              filled: true,
              fillColor: Colors.white,
              counterText: "${commentController.text.length}/244",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                log(
                  {
                    'id_user': idUser,
                    'id_buku': idBuku,
                    'ulasan': commentController.text,
                    'rating': rating,
                  }.toString(),
                );
                context.read<UlasanKamuBloc>().add(
                  UpdateUlasanKamu(
                    idUser: idUser,
                    idBuku: idBuku,
                    ulasan: commentController.text,
                    rating: rating,
                  ),
                );
                setState(() => isEditing = false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Kirim"),
            ),
          ),
        ],
      ),
    );
  }
}
