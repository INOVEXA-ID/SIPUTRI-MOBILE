import '../export/index.dart';

Widget buildTab(
  BuildContext context, {
  required int index,
  required IconData icon,
  required String label,
  required bool selected,
}) {
  final color = selected ? Colors.blue : Colors.grey;

  return Expanded(
    child: InkWell(
      onTap: () {
        context.read<TabBloc>().add(ChangeTab(index));
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: color, fontSize: 13)),
          if (selected)
            Container(
              margin: const EdgeInsets.only(top: 6),
              height: 3,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
        ],
      ),
    ),
  );
}
