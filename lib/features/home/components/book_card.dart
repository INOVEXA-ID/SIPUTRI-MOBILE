import 'package:flutter/material.dart';
import 'package:siputri_mobile/core/widgets/gap.dart';
import 'package:siputri_mobile/core/widgets/my_text.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        color: Colors.grey.shade200,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/4.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                color: const Color.fromARGB(122, 0, 0, 0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: MyText(
                              title: "Buku One Piece Kedua dari One Piece",
                              maxLine: 1,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.white, size: 11),
                              Icon(Icons.star, color: Colors.white, size: 11),
                              Icon(Icons.star, color: Colors.white, size: 11),
                              Icon(Icons.star, color: Colors.white, size: 11),
                              Icon(Icons.star, color: Colors.white, size: 11),
                            ],
                          ),
                        ],
                      ),
                      Gap(Y: 2),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: MyText(
                              title:
                                  "Deskripsi buku One Piece Kedua dari One Piece",
                              maxLine: 1,
                              fontSize: 11,
                              color: Colors.white70,
                            ),
                          ),
                          MyText(
                            title: "0.0",
                            maxLine: 1,
                            fontSize: 11,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
