// ignore_for_file: must_be_immutable

import 'package:flutter/services.dart';
import 'package:siputri_mobile/core/config/app_router.dart';

import '../export/index.dart';

class CardItems extends StatefulWidget {
  String idBuku = "";
  String title = "";
  String penulis = "";
  String rating = "";
  String description = "";
  String image = "";
  int jmlUlasan = 0;
  int jmlPembaca = 0;
  String namaPembaca = "";
  int jmlBuku = 0;
  int tersedia = 0;

  CardItems({
    super.key,
    required this.idBuku,
    required this.title,
    required this.penulis,
    required this.rating,
    required this.description,
    required this.image,
    required this.jmlUlasan,
    required this.jmlPembaca,
    required this.namaPembaca,
    required this.jmlBuku,
    required this.tersedia,
  });

  @override
  State<CardItems> createState() => _CardItemsState();
}

class _CardItemsState extends State<CardItems> {
  final LayerLink _layerLink = LayerLink();
  final LayerLink _layerLink2 = LayerLink();
  final LayerLink _layerLink3 = LayerLink();

  void _showPopup(BuildContext context, String text, LayerLink link) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            width: 150,
            child: CompositedTransformFollower(
              link: link,
              showWhenUnlinked: false,
              offset: const Offset(0, -40), // posisi popup di atas teks
              child: Material(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    text,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
    );

    overlay.insert(overlayEntry);

    // Hapus popup setelah 2 detik
    Future.delayed(const Duration(seconds: 1), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          () => Navigator.pushNamed(
            context,
            AppRouter.detailBukuPage,
            arguments: {'id': widget.idBuku.toString()},
          ),
      child: Container(
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
                    child: Container(
                      height: 140,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(widget.image),
                          fit: BoxFit.cover,
                        ),
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
                          title: widget.title,
                          fontSize: 12,
                          maxLine: 2,
                          fontWeight: FontWeight.w600,
                        ),
                        MyText(
                          title: widget.penulis,
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
                              title: widget.rating,
                              fontSize: 11,
                              maxLine: 2,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                        Gap(Y: 4),
                        MyText(
                          title: widget.description,
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
              Gap(Y: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CompositedTransformTarget(
                    link: _layerLink,
                    child: InkWell(
                      onTap: () {
                        _showPopup(context, "Ulasan", _layerLink);
                      },
                      child: MyText(
                        title: widget.jmlUlasan.toString(),
                        icon: Icons.chat_outlined,
                        addIcon: true,
                        sizeIcon: 20,
                        colorIcon: Colors.amber.shade700,
                      ),
                    ),
                  ),
                  Container(width: 1.5, height: 20, color: Colors.grey),
                  CompositedTransformTarget(
                    link: _layerLink2,
                    child: InkWell(
                      onTap: () {
                        _showPopup(context, "Jumlah Pembaca", _layerLink2);
                      },
                      child: MyText(
                        title: widget.jmlPembaca.toString(),
                        icon: Icons.menu_book_rounded,
                        addIcon: true,
                        sizeIcon: 20,
                        colorIcon: ColorConstants.primaryColor,
                      ),
                    ),
                  ),
                  Container(width: 1.5, height: 20, color: Colors.grey),
                  CompositedTransformTarget(
                    link: _layerLink3,
                    child: InkWell(
                      onTap: () {
                        _showPopup(context, "Jumlah Buku", _layerLink3);
                      },
                      child: MyText(
                        title: widget.jmlBuku.toString(),
                        icon: Icons.copy_rounded,
                        addIcon: true,
                        sizeIcon: 20,
                        colorIcon: Colors.grey,
                      ),
                    ),
                  ),
                  Container(width: 1.5, height: 20, color: Colors.grey),
                  MyText(
                    title: "${widget.tersedia} Tersedia",
                    fontSize: 11,
                    icon: Icons.check_circle_outline,
                    addIcon: true,
                    sizeIcon: 20,
                    colorIcon: Colors.green,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
