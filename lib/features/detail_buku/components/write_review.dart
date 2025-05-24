import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:siputri_mobile/features/detail_buku/bloc/detail_buku_bloc.dart';
import 'package:siputri_mobile/features/detail_buku/bloc/ulasan_kamu_bloc.dart';

class WriteReviewWidget extends StatefulWidget {
  String idBuku;
  WriteReviewWidget({super.key, required this.idBuku});

  @override
  State<WriteReviewWidget> createState() => _WriteReviewWidgetState();
}

class _WriteReviewWidgetState extends State<WriteReviewWidget> {
  double rating = 0;
  final TextEditingController _controller = TextEditingController();
  final int maxLength = 244;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UlasanKamuBloc, UlasanKamuState>(
      listener: (context, state) {
        if (state is PostUlasanKamuLoaded) {
          context.read<DetailBukuBloc>().add(GetDetailBuku(id: widget.idBuku));
          context.read<UlasanKamuBloc>().add(GetUlasanKamu(id: widget.idBuku));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Ulasan berhasil dikirim")),
          );
          _controller.clear();
          setState(() {
            rating = 0;
          });
        } else if (state is PostUlasanKamuFailed) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Gagal: ${state.message}")));
        }
      },
      child: BlocBuilder<UlasanKamuBloc, UlasanKamuState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Tulis ulasan",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    RatingBar.builder(
                      initialRating: rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 30,
                      unratedColor: Colors.grey.shade300,
                      itemBuilder:
                          (context, _) =>
                              const Icon(Icons.star, color: Colors.amber),
                      onRatingUpdate: (newRating) {
                        setState(() {
                          rating = newRating;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextField(
                        controller: _controller,
                        maxLength: maxLength,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Apa pendapat kamu tentang buku ini?',
                          counterText: '',
                        ),
                        onChanged: (_) {
                          setState(() {});
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${_controller.text.length}/$maxLength',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          log(
                            {
                              'id_user': 1,
                              'id_buku': widget.idBuku,
                              'rating': rating,
                              'ulasan': _controller.text,
                            }.toString(),
                          );
                          context.read<UlasanKamuBloc>().add(
                            PostUlasanKamu(
                              idUser: "1",
                              idBuku: widget.idBuku,
                              ulasan: _controller.text,
                              rating: rating,
                            ),
                          );
                          context.read<UlasanKamuBloc>().add(
                            GetUlasanKamu(id: widget.idBuku),
                          );
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
              ),
            ],
          );
        },
      ),
    );
  }
}
