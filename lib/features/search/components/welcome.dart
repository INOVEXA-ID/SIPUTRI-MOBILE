import 'package:flutter/material.dart';
import 'package:siputri_mobile/core/constants/color_constants.dart';
import 'package:siputri_mobile/core/widgets/my_text.dart';

class WelcomeSearch extends StatelessWidget {
  const WelcomeSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 50, color: ColorConstants.primaryColor),
          MyText(
            title: "Ketikan kata kunci untuk\nmemulai pencarian",
            color: ColorConstants.textC,
            fontSize: 12,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
