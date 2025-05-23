import 'package:flutter/material.dart';
import 'package:siputri_mobile/core/widgets/gap.dart';
import 'package:siputri_mobile/core/widgets/my_text.dart';

class BookCard extends StatelessWidget {
  final String title;
  final String description;
  final String thumbnail;

  const BookCard({
    super.key,
    required this.title,
    required this.description,
    required this.thumbnail,
  });

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
                  image: NetworkImage(thumbnail),
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
                              title: title,
                              maxLine: 1,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            children: List.generate(
                              5,
                              (index) => const Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gap(Y: 2),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: MyText(
                              title: description,
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
