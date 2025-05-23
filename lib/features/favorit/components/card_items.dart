import '../export/index.dart';

class CardItems extends StatelessWidget {
  const CardItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        image: AssetImage("assets/images/4.jpeg"),
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
                        title: "Automated Reasoning",
                        fontSize: 12,
                        maxLine: 2,
                        fontWeight: FontWeight.w600,
                      ),
                      MyText(
                        title: "Budi Mulya, S.Si., M.Si.",
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
                            title: "0.0",
                            fontSize: 11,
                            maxLine: 2,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      Gap(Y: 4),
                      MyText(
                        title:
                            "Added customizable button border style and shadow Added navbar RTL support (thanks to hennonoman) Added semantic label (thanks to tsinis)",
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
                MyText(
                  title: "0",
                  icon: Icons.chat_outlined,
                  addIcon: true,
                  sizeIcon: 20,
                  colorIcon: Colors.amber.shade700,
                ),
                Container(width: 1.5, height: 20, color: Colors.grey),
                MyText(
                  title: "0",
                  icon: Icons.menu_book_rounded,
                  addIcon: true,
                  sizeIcon: 20,
                  colorIcon: ColorConstants.primaryColor,
                ),
                Container(width: 1.5, height: 20, color: Colors.grey),
                MyText(
                  title: "0",
                  icon: Icons.copy_rounded,
                  addIcon: true,
                  sizeIcon: 20,
                  colorIcon: Colors.grey,
                ),
                Container(width: 1.5, height: 20, color: Colors.grey),
                MyText(
                  title: "0 Tersedia",
                  fontSize: 11,
                  icon: Icons.check_circle_outline,
                  addIcon: true,
                  sizeIcon: 20,
                  colorIcon: Colors.black,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
