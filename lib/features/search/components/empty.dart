import 'package:flutter/material.dart';
import 'package:siputri_mobile/core/constants/color_constants.dart';
import 'package:siputri_mobile/core/widgets/my_text.dart';

class EmptySearch extends StatelessWidget {
  const EmptySearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.do_not_disturb_alt_outlined,
            size: 50,
            color: Colors.amber,
          ),
          MyText(
            title: "Data yang anda cari kosong!",
            color: ColorConstants.textC,
            fontSize: 12,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
