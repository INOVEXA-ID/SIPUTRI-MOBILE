import '../export/index.dart';

class FavoritEmpty extends StatelessWidget {
  const FavoritEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 50,
            color: ColorConstants.primaryColor,
          ),
          MyText(
            title: "Belum ada buku favorit yang\nanda tambahkan",
            color: ColorConstants.textC,
            fontSize: 12,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
