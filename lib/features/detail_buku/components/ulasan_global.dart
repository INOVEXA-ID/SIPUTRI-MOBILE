import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class UlasanGlobal extends StatelessWidget {
  const UlasanGlobal({super.key});

  @override
  Widget build(BuildContext context) {
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
              CircleAvatar(
                radius: 22,
                // backgroundImage: NetworkImage(
                //   "${ApiConstants.baseUrlImage}/$img",
                // ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("nama", style: TextStyle(fontWeight: FontWeight.bold)),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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
                    rating: 4.5,
                    itemCount: 5,
                    itemSize: 16,
                    itemBuilder:
                        (_, __) => Icon(Icons.star, color: Colors.amber),
                  ),
                  SizedBox(height: 4),
                  Text("4.5", style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(),
          Text("commentController.text"),
        ],
      ),
    );
  }
}
