import '../export/index.dart';

class CardItemRead extends StatelessWidget {
  const CardItemRead({super.key});

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
            Gap(Y: 3),
            MyText(
              title: "18 Mei 2025",
              fontSize: 10,
              maxLine: 5,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
            Row(
              children: [
                MyText(
                  title: "Berlaku sampai 20 Mei 2025 23:59",
                  fontSize: 10,
                  maxLine: 5,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
                Gap(X: 5),
                MyText(
                  title: "(2 Hari lagi)",
                  fontSize: 10,
                  maxLine: 5,
                  color: ColorConstants.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            Gap(Y: 3),
            Divider(thickness: 2, color: Colors.white),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  title: "Belum di baca",
                  fontSize: 10,
                  maxLine: 5,
                  color: Colors.amber.shade800,
                  fontWeight: FontWeight.w600,
                ),
                Material(
                  borderOnForeground: true,
                  child: InkWell(
                    onTap: () {
                      debugPrint("Baca");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 7,
                        ),
                        child: Center(
                          child: MyText(
                            title: "Baca",
                            fontSize: 10,
                            maxLine: 5,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
