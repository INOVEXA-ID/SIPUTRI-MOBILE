import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siputri_mobile/core/widgets/gap.dart';
import 'package:siputri_mobile/features/detail_buku/bloc/detail_buku_bloc.dart';
import 'package:siputri_mobile/features/detail_buku/bloc/kembalikan_buku_bloc.dart';
import 'package:siputri_mobile/features/detail_buku/bloc/pinjam_buku_bloc.dart';
import 'package:siputri_mobile/features/detail_buku/models/detail_buku_model.dart';
import 'package:siputri_mobile/features/pdf_render/index.dart';

Widget firstBtn(
  Data book,
  BuildContext context,
  VoidCallback onConfirm1,
  VoidCallback onConfirm2,
) {
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
                          if (!book.statusDipinjam) {
                            onConfirm1;
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
              onTap: onConfirm2,
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
